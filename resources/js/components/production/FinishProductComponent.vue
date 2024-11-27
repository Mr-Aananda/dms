<template>
    <div class="mb-4">
        <label for="category" class="form-label required">Production Products</label>
         <Multiselect
            v-model="selectedProduct"
            :options="store.products"
            label="name"
            track-by="name"
            placeholder="Choose one"
            :close-on-select="true"
            :clear-on-select="false"
            :open-direction="'bottom'"
            @select="finishAddToCart"
            />
    </div>

    <div class="mb-2">
        <table class="table table-striped table-bordered table-sm">
            <thead>
                <tr>
                    <th class="text-center">#</th>
                    <th style="min-width: 150px">Product Name</th>
                    <th class="text-end">Stock</th>
                    <th>Add Quantity</th>
                    <th>Purchase price</th>
                    <th>Trade price</th>
                    <th>MRP price</th>
                    <th class="text-end print-none">Action</th>
                </tr>
            </thead>
            <tbody style="vertical-align: middle !important;">
                <tr v-for="(product, cartIndex) in finishCartProducts" :key="cartIndex">
                    <td class="text-center">{{ cartIndex + 1 }}</td>
                    <td>{{ product.name }}</td>
                    <td class="text-end">{{ product.display_quantity }}</td>
                    <td>
                        <div class="input-group">
                            <input
                                type="number"
                                aria-describedby="quantityError"
                                v-for="(label,labelIndex) in product.product_unit_labels"
                                :placeholder="label"
                                :key="labelIndex"
                                :value="product.quantity_in_unit[labelIndex]"
                                @blur="addFinishQuantity($event,product.id,labelIndex)"
                                @change="addFinishQuantity($event, product.id,labelIndex)"
                                @keyup="addFinishQuantity($event,product.id,labelIndex)"
                                min="0"
                                step="any"
                                class="form-control form-control-sm"
                            />
                        </div>
                        <div v-if="product.error" id="quantityError" class="form-text text-danger">
                            {{ product.error }}
                        </div>
                    </td>

                    <!-- Purchase Price -->
                    <td>
                        <input
                            type="number"
                            step="any"
                            class="form-control form-control-sm"
                            v-model.trim="product.purchase_price"
                        />
                    </td>
                    <!-- Sale Price -->
                    <td>
                        <input
                            type="number"
                            step="any"
                            class="form-control form-control-sm"
                            v-model.trim="product.sale_price"
                        />
                    </td>
                    <!-- Wholesale Price -->
                    <td>
                        <input
                            type="number"
                            step="any"
                            class="form-control form-control-sm"
                            v-model.trim="product.wholesale_price"
                        />
                    </td>

                    <td class="text-end print-none">
                        <button
                            class="btn btn-danger sm"
                            @click.prevent="finishCartProducts.splice(cartIndex,1)"
                            >
                            <i class="bi bi-trash-fill"></i>
                        </button>
                    </td>
                </tr>

                <tr v-if="finishCartProducts.length == 0">
                    <td colspan="11" class="text-center">No product in cart!</td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script setup>
import { ref, onMounted} from 'vue';
import { usePiniaStore } from '@/store';
import { storeToRefs } from 'pinia';
import convertToUpperUnit from "../../ConvertToUpperUnit";
import convertToLowestUnit from "../../ConvertToLowestUnit";
import alert from "../../alert";

const store = usePiniaStore()
const { products: _products } = storeToRefs(store);

const props = defineProps({
    oldProduction: {
        type: Object
    },
});


const selectedProduct = ref(null)
const finishProducts = ref([])
const finishCartProducts = ref([])

// watch(_products, (products) => {
//     if (products) {
//         finishProducts.value = products.filter(product => product.product_type == 'finish_product');
//     }
// }, { deep: true });

const finishAddToCart =  () => {
    if (selectedProduct) {
        const index = finishCartProducts.value.findIndex(product => product.id == selectedProduct.value.id);
        let product = store.products.find(product => product.id == selectedProduct.value.id);
        if (index == -1) {
            let branchProduct = product.branches.filter(branch => branch.id == store.branchId)
            let branchQuantity = branchProduct.reduce((total, branch) => {
                return total + parseFloat(branch.stock.quantity)
            }, 0)

            let displayQuantity = convertToUpperUnit(branchQuantity, product.unit_label, product.unit_relation);

            const unitRelation = product.unit_relation.split("/");
            let _quantity = Array(unitRelation.length).fill(null);

            product.quantity_in_unit = _quantity;
            product.product_unit_labels = product.unit_label.split("/");

            const newProduct = {
                ...product,
                quantity: 0,
                error: '',
                display_quantity: displayQuantity || 'No Quantity Available',
            };

            // finishCartProducts.value = [...finishCartProducts.value, newProduct]
            finishCartProducts.value.push(newProduct);

        }else{
            let toast = alert()
            toast.fire({
                icon: 'error',
                title: 'Product already added in cart!'
            })
        }
        selectedProduct.value = null
    }
}

//Add quantity method
const addFinishQuantity = (event, productId, order) => {
    let product = finishCartProducts.value.find(product => product.id == productId);
    product.quantity_in_unit[order] = event.target.value ? event.target.value : null;
    product.quantity = convertToLowestUnit(product.quantity_in_unit, product.unit_relation);
};

defineExpose({
    finishCartProducts
})

const initialValues = () => {
     if (props.oldProduction) {
        props.oldProduction.details.forEach((details) => {
            if (details.production_type == 'finish_product') {
            let exitProduct = store.products.find((product) => product.id == details.product_id);
            selectedProduct.value = exitProduct;
            finishAddToCart();
            let product = finishCartProducts.value.find((product) => product.id == details.product_id);
            product.quantity = details.quantity;
            product.quantity_in_unit = Object.assign({},details.quantity_in_unit);
            // product.quantity_in_unit = JSON.parse(details.quantity_in_unit);

           }
        });
    }

};

onMounted( async () => {
    await store.loadAllProducts()
    initialValues();
});

</script>

<style scoped>
.multiselect{
    min-height: auto !important;
    height: 40px !important;
}
</style>

