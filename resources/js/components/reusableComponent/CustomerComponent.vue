<template>
    <div class="col-10">
        <div v-if="props.from == 'sale'" class="mb-2">
            <div class="form-check form-check-inline">
                <input
                    class="form-check-input fs-6"
                    type="radio"
                    v-model="customerType"
                    @change="changeCustomerType"
                    value="oldCustomer"
                    id="oldCustomer">
                <label class="form-check-label fw-bold fs-6" for="oldCustomer">Old Customer</label>
            </div>
            <div class="form-check form-check-inline">
                <input
                    class="form-check-input fs-6"
                    type="radio"
                    @change="changeCustomerType"
                    v-model="customerType"
                    id="newCustomer"
                    value="newCustomer">
                <label class="form-check-label fw-bold fs-6" for="newCustomer">New Customer</label>
            </div>
        </div>

        <div v-if="customerType == 'oldCustomer'">
            <div class="mb-2">
                <label for="customer" class="form-label required">Customer</label>
                    <Multiselect
                        v-model="selectedCustomer"
                        :options="store.customers"
                        @select="getCustomerDetails"
                        label="custom_name"
                        track-by="custom_name"
                        placeholder="Choose Customer"
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
                        v-model="customerMobile"
                        id="mobile"
                        placeholder="Enter mobile number"
                        disabled
                    />
            </div>
            <div class="mb-2">
                <label for="address" class="mt-1 form-label">Address</label>
                <textarea name="address" v-model="customerAddress" class="form-control" id="address" rows="2" placeholder="Enter customer address" disabled></textarea>
            </div>
        </div>

        <div v-else>
            <div class="mb-2">
                <label for="customer-id" class="mt-1 form-label required">Customer Name</label>
                    <input
                    type="text"
                    v-model="name"
                    required
                    placeholder="Enter Customer Name"
                    class="form-control"
                />
            </div>
            <div class="mb-2">
                <label for="mobile" class="mt-1 form-label">Mobile Number</label>
                    <input
                        type="text"
                        class="form-control"
                        name="mobile"
                        v-model="phone"
                        id="mobile"
                        placeholder="Enter mobile number"
                    />
            </div>
            <div class="mb-2">
                <label for="address" class="mt-1 form-label">Address</label>
                <textarea name="address" v-model="address" class="form-control" id="address" rows="2" placeholder="Enter customer address"></textarea>
            </div>
        </div>

    </div>
</template>

<script setup>
import { storeToRefs } from 'pinia';
import { ref, watch,onMounted,computed } from 'vue';
import { usePiniaStore } from "@/store";

const store = usePiniaStore();

const props = defineProps({
     oldSale: {
        type: Object
    },
     oldSaleReturn: {
        type: Object
    },
    from:String
});

const { oldSale: _oldSale } = storeToRefs(store)
const { oldSaleReturn: _oldSaleReturn } = storeToRefs(store)

const customerType = ref('oldCustomer');
const selectedCustomer = ref(null);
const customerBalance = ref(0);
const customerMobile = ref(null);
const customerAddress = ref(null);
const name = ref(null);
const phone = ref(null);
const address = ref(null);


// Create a computed property to determine the source of old data
const oldData = computed(() => {
    return props.oldSale || props.oldSaleReturn;
});

watch(_oldSale, (oldSale) => {
    if (oldSale) {
        initialValues(oldSale)
    }
}, { deep: true })

watch(_oldSaleReturn, (oldSaleReturn) => {
    if (oldSaleReturn) {
        initialValues(oldSaleReturn);
    }
}, { deep: true });

watch(customerBalance, (balance) => {
    if (balance) {
        store.customerBalance = balance
    }
});

const changeCustomerType = () => {
    selectedCustomer.value = null
    customerMobile.value = null
    customerAddress.value = null
    getCustomerDetails()
}

const getCustomerDetails = () => {
    if (!selectedCustomer.value) {
        return;
    }

    const selectedCustomerId = selectedCustomer.value.id;
    const customer = store.customers.find((s) => s.id == selectedCustomerId);

    const isCustomerMatch = oldData.value ? customer.id == oldData.value.party_id : false;

    customerBalance.value = oldData.value
        ? isCustomerMatch
            ? oldData.value.previous_balance
            : customer.balance
        : customer.balance;

    customerMobile.value = customer.phone || "";
    customerAddress.value = customer.address || "";
}

defineExpose({
    customerType,
    selectedCustomer,
    name,
    phone,
    address,
    customerBalance,
})


const initialValues = (oldData) => {
    if (oldData) {
        selectedCustomer.value = store.customers.find((customer) => customer.id == oldData.party_id);
        getCustomerDetails();
    }
};

onMounted( async () => {
    await store.loadAllCustomers()
    initialValues()
})
</script>

<style scoped>
.multiselect{
    min-height: auto !important;
    height: 40px !important;
}
</style>


