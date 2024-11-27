<template>
    <div class="row mt-2">
        <div class="col-6">
            <label for="from-branch" class="form-label required">From Branch</label>
            <select name="from_branch_id" v-model="from_branch_id" @change="getBranchProducts" id="from-branch" required class="form-select">
                <option :value="null" disabled selected> Choose one </option>
                <option
                    v-for="(branch, index) in store.branches"
                    :value="branch.id"
                    :key="index"
                    >
                    {{ branch.name }}
                </option>
            </select>
        </div>
        <div class="col-6">
            <label for="to-branch" class="form-label required">To Branch</label>
            <select name="to_branch_id" v-model="to_branch_id" id="to-branch" required class="form-select">
                <option :value="null" disabled selected> Choose one </option>
                <option
                    v-for="(branch, index) in store.branches"
                    :value="branch.id"
                    :key="index"
                    >
                    {{ branch.name }}
                </option>
            </select>
        </div>
    </div>
</template>

<script setup>
import {onMounted,ref} from "vue";
import { usePiniaStore } from '@/store';
const store = usePiniaStore()

const props = defineProps({
    oldProductTransfer: {
        type: Object
    },
});

const from_branch_id = ref(null);
const to_branch_id = ref(null);

const getBranchProducts = () => {
    axios.get(baseURL+'/utility/get-product-for-branch/' + from_branch_id.value)
        .then((response) => {
            // console.log(response.data)
            store.branchProducts = response.data
            store.branchId = from_branch_id.value
        })
        .catch((error) => {
            console.log(error)
        })
}

defineExpose({
    from_branch_id,
    to_branch_id
})

onMounted( () => {
    if (props.oldProductTransfer) {
        from_branch_id.value = props.oldProductTransfer.from_branch_id
       getBranchProducts()
       to_branch_id.value = props.oldProductTransfer.to_branch_id
    }
});

</script>
