<template>
    <div>
        <label for="note" class="col-sm-2 col-form-label" >Note</label>
        <textarea name="note" v-model="note" id="note" class="form-control" rows="3" placeholder="Optional"></textarea>
    </div>
</template>

<script setup>
import { onMounted, ref} from "vue";

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
    oldSalary: {
        type: Object
    },
})

let note = ref(null)

defineExpose({
    note,
})

onMounted(() => {
    if (props.oldPurchase) {
        note.value = props.oldPurchase.note == 'null' ? "" : props.oldPurchase.note;
    }
    else if (props.oldPurchaseReturn) {
        note.value = props.oldPurchaseReturn.note == 'null' ? "" : props.oldPurchaseReturn.note;
    }
    else if (props.oldSale) {
        note.value = props.oldSale.note == 'null' ? "" : props.oldSale.note;
    }
    else if (props.oldSaleReturn) {
        note.value = props.oldSaleReturn.note == 'null' ? "" : props.oldSaleReturn.note;
    }
    else if (props.oldDamage) {
        note.value = props.oldDamage.note == 'null' ? "" : props.oldDamage.note;
    }
    else if (props.oldDueManage) {
        note.value = props.oldDueManage.note == 'null' ? "" : props.oldDueManage.note;
    }
    else if (props.oldProduction) {
        note.value = props.oldProduction.note == 'null' ? "" : props.oldProduction.note;
    }
    else if (props.oldProductTransfer) {
        note.value = props.oldProductTransfer.note == 'null' ? "" : props.oldProductTransfer.note;
    }
    else if (props.oldSalary) {
        note.value = props.oldSalary.note == 'null' ? "" : props.oldSalary.note;
    }
    else {
        note.value = null
    }

})
</script>
