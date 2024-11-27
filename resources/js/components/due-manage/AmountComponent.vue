<template>
    <div class="row mt-2">
        <div  class="col-6">
            <label for="payment" class="form-label required">Amount</label>
            <div class="input-group">
                <input
                    type="number"
                    step="any"
                    min="0"
                    v-model="tempAmount"
                    class="form-control"
                    id="payment"
                    placeholder="Enter Amount"
                    required
                >
                <div class="input-group-append">
                    <select v-model="paymentType" class="form-select px-5 dropdown-toggle fw-bold">
                        <option class="dropdown-item" value="paid">Paid</option>
                        <option class="dropdown-item" value="received">Received</option>
                    </select>
                </div>
            </div>
        </div>
         <!-- Adjustment -->
        <div  class="col-4">
            <label for="adjustment" class="form-label">Adjustment</label>
            <div class="input-group">
                <input
                    type="number"
                    step="any"
                    min="0"
                    v-model="adjustment"
                    class="form-control"
                    placeholder="Enter Amount"
                    id="adjustment"
                >
            </div>
        </div>
    </div>
</template>

<script setup>
import {onMounted,ref} from "vue";
import { usePiniaStore } from '@/store';

const store = usePiniaStore()

const props = defineProps({
    oldDueManage: {
        type: Object
    },
    partyType: String,
})

const paymentType = ref('received');
const tempAmount = ref(null);
const adjustment = ref(0);
const amount = ref(null);
const party_type = ref(null);

defineExpose({
    paymentType,
    tempAmount,
    adjustment,
    amount,
    party_type,
})

const initialValues = () => {
    if (props.oldDueManage) {
        if (props.oldDueManage.amount > 0) {
            paymentType.value = 'received'
        }else{
            paymentType.value = 'paid'
        }
        adjustment.value = props.oldDueManage.adjustment
        tempAmount.value = Math.abs(props.oldDueManage.amount)
    }
}

onMounted(() => {
    party_type.value = props.partyType;
    party_type.value == 'customer' ? paymentType.value = 'received' : paymentType.value = 'paid';
    initialValues()
})
</script>
