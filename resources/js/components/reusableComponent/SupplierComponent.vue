<template>
  <div class="col-10">
    <div class="mb-2">
      <label for="supplier" class="form-label required">Supplier</label>
        <Multiselect
            v-model="selectedSupplier"
            :options="store.suppliers"
            @select="getSupplierDetails"
            label="custom_name"
            track-by="custom_name"
            placeholder="Choose one"
            :close-on-select="true"
            :clear-on-select="false"
            :open-direction="'bottom'"
        />
    </div>
    <div class="mb-2">
      <label for="mobile" class="mt-1 form-label">Mobile</label>
      <input
        type="text"
        class="form-control"
        name="mobile"
        v-model="supplierMobile"
        id="mobile"
        placeholder="Enter mobile"
        disabled
      />
    </div>

    <div class="mb-2">
      <label for="address" class="mt-1 form-label">Address</label>
      <textarea
        name="address"
        v-model="supplierAddress"
        class="form-control"
        id="address"
        rows="2"
        placeholder="Enter address"
        disabled
      ></textarea>
    </div>
  </div>
</template>

<script setup>
import { storeToRefs } from 'pinia';
import { ref, onMounted, watch, computed } from "vue";
import { usePiniaStore } from "@/store";

const store = usePiniaStore();

const { oldPurchase: _oldPurchase } = storeToRefs(store);
const { oldPurchaseReturn: _oldPurchaseReturn } = storeToRefs(store);

const props = defineProps({
    oldPurchase: {
        type: Object
    },
    oldPurchaseReturn: {
        type: Object
    },
})

const selectedSupplier = ref(null);
const supplierMobile = ref(null);
const supplierAddress = ref(null);

const supplierBalance = ref(0);

// Create a computed property to determine the source of old data
const oldData = computed(() => {
    return props.oldPurchase || props.oldPurchaseReturn;
});

watch(supplierBalance, (balance) => {
  if (balance) {
    store.supplierBalance = balance;
  }
});

watch(_oldPurchase, (oldPurchase) => {
    if (oldPurchase) {
        initialValues(oldPurchase);
    }
}, { deep: true });

watch(_oldPurchaseReturn, (oldPurchaseReturn) => {
    if (oldPurchaseReturn) {
        initialValues(oldPurchaseReturn);
    }
}, { deep: true });

const getSupplierDetails = () => {
    if (!selectedSupplier.value) {
        // Handle the case when selectedSupplier is undefined
        return;
    }

    // console.log(selectedSupplier.value);

    const selectedSupplierId = selectedSupplier.value.id;
    const supplier = store.suppliers.find((s) => s.id == selectedSupplierId);

    const isSupplierMatch = oldData.value ? supplier.id == oldData.value.party_id : false;

    supplierBalance.value = oldData.value
        ? isSupplierMatch
            ? oldData.value.previous_balance
            : supplier.balance
        : supplier.balance;

    supplierMobile.value = supplier.phone || "";
    supplierAddress.value = supplier.address || "";
};

const initialValues = (oldData) => {
    if (oldData) {
        selectedSupplier.value = store.suppliers.find((supplier)=> supplier.id == oldData.party_id);
        getSupplierDetails();
    }
};

onMounted( async () => {
    await store.loadAllSuppliers()
     initialValues();
});

defineExpose({
    selectedSupplier,
    supplierBalance,
})
</script>

<style scoped>
.multiselect{
    min-height: auto !important;
    height: 40px !important;
}
</style>


