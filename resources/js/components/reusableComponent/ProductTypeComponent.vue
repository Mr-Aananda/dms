<template>
    <div>
         <label for="type" class="form-label required">Product Type</label>
            <select name="type" v-model="productType" required id="type" @change="getProducts" class="form-select">
            <option value='raw_material'>Raw Product</option>
            <option value="finish_product">Finish Product</option>
        </select>
    </div>

</template>

<script setup>
import { ref ,onMounted, watch} from 'vue';
import { usePiniaStore } from '@/store';
import { storeToRefs } from 'pinia';

const store = usePiniaStore()

const { products: _products } = storeToRefs(store)

let productType = ref('finish_product');

// watcher
watch(_products, (product) => {
    if (product) {
        getProducts();
    }
}, { deep: true });

const getProducts = () => {
    store.filteredProducts = store.products.filter(product => product.product_type == productType.value);
};


onMounted( () => {
    //  getProducts();
});
</script>
