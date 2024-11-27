
<template>
    <div>
        <label for="name" class="form-label required">Date</label>
        <input
        type="date"
        class="form-control"
        name="date"
        v-model="date"
        id="date"

        />
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const props = defineProps({
    oldPurchase: {
        type: Object
    },
    oldPurchaseReturn: {
        type: Object
    },
    oldSale: {
        type: Object
    },
    oldSaleReturn: {
        type: Object
    },
    oldDamage: {
        type: Object
    },
    oldDueManage: {
        type: Object
    },
    oldProduction: {
        type: Object
    },
    oldProductTransfer: {
        type: Object
    },
})

const date = ref(new Date().toISOString().substr(0, 10));

defineExpose({
    date
})

onMounted( () => {
    if (props.oldPurchase) {
       date.value = props.oldPurchase.formatted_date
    }
    else if (props.oldPurchaseReturn) {
       date.value = props.oldPurchaseReturn.formatted_date
    }
    else if (props.oldSale) {
       date.value = props.oldSale.formatted_date
    }
    else if (props.oldSaleReturn) {
       date.value = props.oldSaleReturn.formatted_date
    }
    else if (props.oldDamage) {
       date.value = props.oldDamage.formatted_date
    }
    else if (props.oldDueManage) {
       date.value = props.oldDueManage.formatted_date
    }
    else if (props.oldProduction) {
       date.value = props.oldProduction.formatted_date
    }
    else if (props.oldProductTransfer) {
       date.value = props.oldProductTransfer.formatted_date
    }
});

</script>
