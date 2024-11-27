<template>
    <!-- Party -->
    <div class="col-10 mt-2">
        <label
            for="party_id"
            class="form-label required">
            {{ props.partyType == 'customer' ? 'Customer' : 'Supplier' }}
        </label>
        <Multiselect
            v-model="selectedParty"
            :options="props.partyType == 'customer' ? store.customers : store.suppliers"
            label="custom_name"
            track-by="custom_name"
            placeholder="Choose one"
            :close-on-select="true"
            :clear-on-select="false"
            :open-direction="'bottom'"
        />
    </div>
    <div v-if="party_balance != null" class="col-10 mt-2">
        <p class="d-block text-light p-1 px-2" :style="{ backgroundColor: '#0B93A8' }">৳ {{ party_balance + ' ' + party_balance_status }}</p>
    </div>
</template>

<script setup>
import {onMounted, ref, watchEffect } from "vue";
import { usePiniaStore } from '@/store';

const store = usePiniaStore();

const props = defineProps({
    oldDueManage: {
        type: Object
    },
    partyType: String,
});

const selectedParty = ref(null);
const party_balance = ref(null);
const party_balance_status = ref(null);

watchEffect(() => {
    let parties = props.partyType == 'customer' ? store.customers : store.suppliers;
    const party = parties.find(party => party.id == selectedParty.value?.id);

    if (party) {
        party_balance.value = Math.abs(party.balance);
        party_balance_status.value = party.balance >= 0 ? 'Receivable' : 'Payable';
    }
});

defineExpose({
    selectedParty,
});

const initialValues = () => {

    if (props.oldDueManage) {
        let parties = props.partyType == 'customer' ? store.customers : store.suppliers;
        const party = parties.find(party => party.id == props.oldDueManage.party_id);
        selectedParty.value = party;
    }
};

onMounted( async () => {
    await store.loadAllSuppliers()
    await store.loadAllCustomers()
    initialValues();
});
</script>

<style scoped>
.multiselect{
    min-height: auto !important;
    height: 40px !important;
}
</style>

