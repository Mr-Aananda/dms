<template>
    <div class="col-12">
        <div class="row">
            <label for="total_price" class="col-sm-2 col-form-label" >Subtotal</label>
            <div class="col-sm-10">
                <div class="input-group">
                    <input
                        type="number"
                        readonly
                        step="any"
                        v-model="subtotal"
                        class="form-control"
                        id="total_price">
                    <div class="input-group-prepend">
                        <div class="input-group-text">৳</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3 row">
            <label for="discount" class="col-sm-2 col-form-label">Discount</label>
            <div class="col-sm-10">
                <div class="input-group">
                    <input
                        type="number"
                        step="any"
                        v-model="discount"
                        class="form-control"
                        id="discount">
                    <div class="input-group-prepend">
                        <div class="input-group-text">৳</div>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <div class="mt-3 row">
                <label for="labour_cost" class="col-sm-2 col-form-label">Labour Cost</label>
                <div class="col-sm-6">
                    <div class="input-group">
                        <input
                            type="number"
                            step="any"
                            v-model="labour_cost"
                            class="form-control"
                            id="labour_cost">
                        <div class="input-group-prepend">
                            <div class="input-group-text">৳</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4 mt-1">
                    <div class="form-check form-switch">
                        <input class="form-check-input" v-model="labour_cost_adjust_to_supplier" type="checkbox" id="labour_cost_adjust_to_supplier">
                        <label class="form-check-label" for="labour_cost_adjust_to_supplier">Adjust To Supplier</label>
                    </div>
                </div>
            </div>

            <div class="mt-3 row">
                <label for="transport_cost" class="col-sm-2 col-form-label">Transport Cost</label>
                <div class="col-sm-6">
                    <div class="input-group">
                        <input
                            type="number"
                            step="any"
                            v-model="transport_cost"
                            class="form-control"
                            id="transport_cost">
                        <div class="input-group-prepend">
                            <div class="input-group-text">৳</div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4 mt-1">
                    <div class="form-check form-switch">
                        <input class="form-check-input" v-model="transport_cost_adjust_to_supplier" type="checkbox" id="transport_cost_adjust_to_supplier">
                        <label class="form-check-label" for="transport_cost_adjust_to_supplier">Adjust To Supplier</label>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <label for="previous_balance" class="col-sm-2 col-form-label">Previous Balance</label>
            <div class="col-sm-6">
                <input type="number" :value="Math.abs(store.supplierBalance)" readonly class="form-control" id="previous_balance">
            </div>
            <div class="col-sm-4">
                <input type="text" readonly :value="(store.supplierBalance >= 0) ? 'Receivable' : 'Payable'" class="form-control">
            </div>
        </div>

        <div class="row mt-3">
            <label for="grand_total" class="col-sm-2 col-form-label">Grand Total</label>
            <div class="col-sm-10">
                <div class="input-group">
                    <input
                        readonly
                        step="any"
                        type="number"
                        :value="Number.parseFloat(grandTotal).toFixed(2)"
                        class="form-control"
                        id="grand_total">
                    <div class="input-group-prepend">
                        <div class="input-group-text">৳</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-3 row">
            <label for="payment" class="col-sm-2 col-form-label fw-bold">Paid</label>
            <div class="col-sm-6">
                <div class="input-group">
                    <input
                        type="number"
                        step="any"
                        min="0"
                        v-model="paid"
                        class="form-control"
                        id="payment">
                    <div class="input-group-prepend">
                        <div class="input-group-text">৳</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <select v-model="payment_type" class="form-select">
                    <option value="cash">Cash</option>
                    <option value="bank">Bank</option>
                </select>
            </div>
        </div>

        <div v-if="payment_type == 'cash'" class="mt-3 row">
            <label class="col-sm-2 col-form-label" >Cash Name</label>
            <div class="col-sm-10">
                <select class="form-select" v-model="cashId">
                    <option :value="null">Choose Cash</option>
                    <option v-for="(cash, index) in store.cashes" :key="index" :value="cash.id">{{ cash.name }}</option>
                </select>
            </div>
        </div>

        <div v-if="payment_type == 'bank'">
            <div class="mt-2 row">
                <label for="total_price" class="col-sm-2 col-form-label" >Bank Name</label>
                <div class="col-sm-10">
                    <select class="form-select" v-model="bankAccountId">
                        <option :value="null">Choose Bank</option>
                        <option v-for="(account, index) in store.bankAccounts" :key="index" :value="account.id">{{ account.custom_name }}</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="mt-3 row">
            <!-- <label for="due" class="col-sm-2 col-form-label">{{ (grandTotal - paid) > 0 ? 'Due' : 'Advanced' }}</label> -->
            <label for="due" class="col-sm-2 col-form-label">
                {{ partyRemainingBalance >= 0 ? 'Due' : 'Advanced' }}
            </label>
            <div class="col-sm-6">
                <div class="input-group">
                    <input
                        readonly
                        step="any"
                        type="number"
                        :value="
                        Number.parseFloat(Math.abs(grandTotal - paid)).toFixed(2)"
                        class="form-control"
                        id="due">
                    <div class="input-group-prepend">
                        <div class="input-group-text">৳</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <input type="text" :value="partyRemainingBalance > 0 ? 'Payable' : 'Receivable'" readonly class="form-control" placeholder="Receivable">
            </div>
        </div>
    </div>
</template>

<script setup>
import { storeToRefs } from 'pinia';
import {onMounted, ref, watch ,computed} from "vue";
import { usePiniaStore } from '@/store';

const props = defineProps({
    oldPurchase: {
        type: Object
    },
})

const store = usePiniaStore()

const { cartProducts: _cartProducts } = storeToRefs(store);
const { cashes: _cashes } = storeToRefs(store);

let payment_type = ref('cash')
let subtotal = ref(0)
let discount = ref(0)
let discount_type = ref('flat');
let cashId = ref(null)
let bankAccountId = ref(null)
let labour_cost = ref(0)
let transport_cost = ref(0)
let paid = ref(0)
let labour_cost_adjust_to_supplier = ref(true);
let transport_cost_adjust_to_supplier = ref(true);


let grandTotal = computed(() => {
  let labourCost = 0;
  let transportCost = 0;
  if (labour_cost_adjust_to_supplier.value) {
    labourCost = labour_cost.value;
  }
  if (transport_cost_adjust_to_supplier.value) {
    transportCost = transport_cost.value;
  }

  if (store.supplierBalance >= 0) {
    return (
      subtotal.value + parseFloat(labourCost || 0) + parseFloat(transportCost || 0) - parseFloat(store.supplierBalance) - discount.value
    );
  } else {
      return (
          subtotal.value + parseFloat(labourCost || 0) + parseFloat(transportCost || 0) + parseFloat(Math.abs(store.supplierBalance)) - discount.value
      );
  }
});

let partyRemainingBalance = computed(() => {
  return grandTotal.value - paid.value;
});


watch(_cartProducts, (cartProducts) => {
    subtotal.value = cartProducts.reduce((total, item) => {
        return parseFloat(item.total_price) + total;
    }, 0);
}, { deep: true })

// watch(_cartProducts, (cartProducts) => {
//     subtotal.value = cartProducts.reduce((total, item) => {
//         return Number.parseFloat((item.total_price) + total).toFixed(2);
//     }, 0);
// }, { deep: true })



// watch(() => _cashes.value,(newCashes) => {
//     if (newCashes || newCashes.length > 0) {
//     cashId.value = newCashes[0].id;
//     }
// },
//   { deep: true }
// );

watch(() => _cashes.value,(newCashes) => {
    if (!props.oldPurchase) {
      if (newCashes.length > 0) {
        cashId.value = newCashes[0].id;
      }
    }
  },
  { deep: true }
);

watch(payment_type, (newPaymentType) => {
    // Reset values based on the selected payment type
    if (newPaymentType == 'cash') {
        bankAccountId.value = null;
    } else if (newPaymentType == 'bank') {
        cashId.value = null;
    }
});

defineExpose({
    payment_type,
    discount_type,
    subtotal,
    discount,
    labour_cost,
    transport_cost,
    grandTotal,
    paid,
    cashId,
    bankAccountId,
    partyRemainingBalance,
    labour_cost_adjust_to_supplier,
    transport_cost_adjust_to_supplier,
})

const initialValues = () => {
    const oldPurchase = props.oldPurchase
    // console.log(oldPurchase);
    if (oldPurchase) {
        payment_type.value = oldPurchase?.payments[0]?.cash_id ? 'cash' : 'bank'
        discount.value = oldPurchase?.discount
        cashId.value = oldPurchase?.payments[0]?.cash_id
        bankAccountId.value = oldPurchase?.payments[0]?.bank_account_id
        labour_cost.value = oldPurchase?.purchase_cost?.labour_cost ?? 0;
        transport_cost.value = oldPurchase?.purchase_cost?.transport_cost ?? 0;
        labour_cost_adjust_to_supplier.value = oldPurchase?.purchase_cost?.labour_cost_adjust_to_supplier == 0 ? false : true;
        transport_cost_adjust_to_supplier.value = oldPurchase?.purchase_cost?.transport_cost_adjust_to_supplier == 0 ? false : true;
        paid.value = oldPurchase?.payments[0]?.amount
    }
}

onMounted(async () => {
    await store.loadAllBankAccounts()
    await store.loadAllCashes()
    initialValues()
})

</script>

<style scoped>
/* Style for read-only inputs */
/* input:read-only {
    background-color: #D4F7FC;
} */
</style>
