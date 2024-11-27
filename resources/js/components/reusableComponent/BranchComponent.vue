<template>
    <div>
        <label for="branch" class="form-label required">Select Branch</label>
        <select
            name="branch_id"
            v-model="store.branchId"
            id="branch"
            @change="getBranchProducts"
            required
            class="form-select"
            :disabled="!store.isAdmin"
        >
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
</template>

<script setup>
import { onBeforeMount, onMounted, watch } from "vue";
import { storeToRefs } from 'pinia';
import { usePiniaStore } from '@/store';
import alert from "../../alert";

const props = defineProps({
    oldPurchase: {
        type: Object
    },
    oldPurchaseReturn: {
        type: Object
    },
    oldSale: {
    type: Object,
  },
    oldSaleReturn: {
    type: Object,
  },
    oldDamage: {
    type: Object,
  },
    oldProduction: {
    type: Object,
  },
})

const store = usePiniaStore();
const { branches: _branches } = storeToRefs(store);
const { branchId: _branchId } = storeToRefs(store);


watch(_branches, (newBranches) => {
    if (newBranches) {
        if (props.oldPurchase) {
            store.branchId = props.oldPurchase.branch_id;
        }
        else if (props.oldPurchaseReturn) {
           store.branchId =  props.oldPurchaseReturn.branch_id;

        }
        else if (props.oldSale) {
            store.branchId =  props.oldSale.branch_id;
        }
        else if (props.oldSaleReturn) {
            store.branchId =  props.oldSaleReturn.branch_id;
        }
        else if (props.oldDamage) {
            store.branchId =  props.oldDamage.branch_id;
        }
        else if (props.oldProduction) {
            store.branchId =  props.oldProduction.branch_id;
        }
    }
}, { deep: true });

// watcher
watch(_branchId, (branchId) => {
    if (branchId) {
        getBranchProducts()
    }
}, { deep: true });

const getBranchProducts = () => {
    axios.get(baseURL+'/utility/get-product-for-branch/' + store.branchId)
        .then((response) => {
            // console.log(response.data)
            store.branchProducts = response.data
        })
        .catch((error) => {
            console.log(error)
        })
}

onBeforeMount(async () => {
    await store.loadAllBranches()
    await store.loadBranchIdFromUser()
    await store.getAdminRule()

});

</script>

<style scoped>
</style>
