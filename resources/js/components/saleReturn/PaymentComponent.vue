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
        <div class="row mt-3">
            <label for="previous_balance" class="col-sm-2 col-form-label">Previous Balance</label>
            <div class="col-sm-6">
                <input type="number" :value="Math.abs(store.customerBalance)" readonly class="form-control" id="previous_balance">
            </div>
            <div class="col-sm-4">
                <input type="text" readonly :value="(store.customerBalance >= 0) ? 'Receivable' : 'Payable'" class="form-control">
            </div>
        </div>

        <div class="row mt-3">
            <label for="adjustment" class="col-sm-2 col-form-label">Adjustment</label>
            <div class="col-sm-10">
                <div class="input-group">
                    <input
                        type="number"
                        step="any"
                        v-model="adjustment"
                        class="form-control"
                        id="adjustment">
                    <div class="input-group-prepend">
                        <div class="input-group-text">৳</div>
                    </div>
                </div>
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
                        :value="
                    Number.parseFloat(
                        grandTotal = (parseFloat(subtotal || 0)
                        - parseFloat(store.customerBalance || 0)
                        - parseFloat(adjustment || 0))
                    )"
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

const store = usePiniaStore()

const props = defineProps({
    from:String
});

const { cartProducts: _cartProducts } = storeToRefs(store);
const { oldSaleReturn: _oldSaleReturn } = storeToRefs(store);
const { cashes: _cashes } = storeToRefs(store);

let payment_type = ref('cash')
let subtotal = ref(0)
let grandTotal = ref(0)
let adjustment = ref(0)
let cashId = ref(null)
let bankAccountId = ref(null)
let paid = ref(0)

let partyRemainingBalance = computed(() => {
  return grandTotal.value - paid.value;
});

watch(_cartProducts, (cartProducts) => {
    subtotal.value = cartProducts.reduce((total, item) => {
        return parseFloat(item.total_price) + total;
    }, 0);
}, { deep: true })

watch(_oldSaleReturn, (oldSaleReturn) => {
  if (oldSaleReturn) {
    initialValues(oldSaleReturn);
  }
}, { deep: true });

watch(() => _cashes.value,(newCashes) => {
    if (!store.oldSaleReturn.value) {
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
    subtotal,
    adjustment,
    grandTotal,
    paid,
    cashId,
    bankAccountId,
    partyRemainingBalance,
})

const initialValues = (oldSaleReturn) => {
    if (oldSaleReturn) {
        payment_type.value = oldSaleReturn?.payments[0]?.cash_id ? 'cash' : 'bank'
        adjustment.value = oldSaleReturn?.discount
        cashId.value = oldSaleReturn?.payments[0]?.cash_id
        bankAccountId.value = oldSaleReturn?.payments[0]?.bank_account_id
        paid.value = oldSaleReturn?.payments[0]?.amount

    }
}

onMounted( async () => {
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
