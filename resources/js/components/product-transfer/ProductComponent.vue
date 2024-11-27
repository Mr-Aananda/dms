<template>
    <div class="col-12 my-2">
        <label for="product" class="form-label required">Products</label>
         <Multiselect
            v-model="selectedProduct"
            :options="store.branchProducts"
            label="name"
            track-by="name"
            placeholder="Choose one"
            :close-on-select="true"
            :clear-on-select="false"
            :open-direction="'bottom'"
            />
    </div>
    <div class="col-12 mt-4">
        <div class="table-responsive mb-3">
            <table class="table table-striped table-bordered table-sm">
                <thead>
                    <tr>
                        <th class="text-center">#</th>
                        <th style="min-width: 150px">Product name</th>
                        <th class="text-end">Stock</th>
                        <th>Quantity</th>
                        <th>Purchase price</th>
                        <th class="text-end print-none">Action</th>
                    </tr>
                </thead>
                <tbody style="vertical-align: middle !important;">
                    <tr v-for="(product, cartIndex) in store.cartProducts" :key="cartIndex">
                        <td class="text-center">{{ cartIndex + 1 }}</td>
                        <td>{{ product.name }}</td>
                        <td class="text-end">{{ product.display_quantity }}</td>
                        <!-- Quantity-->
                        <td class="p-0">
                            <div class="input-group">
                                <input
                                    type="number"
                                    v-for="(label,labelIndex) in product.product_unit_labels"
                                    :placeholder="label"
                                    :key="labelIndex"
                                    :value="product.quantity_in_unit[labelIndex]"
                                    @blur="addQuantity($event,product.id,labelIndex)"
                                    @change="addQuantity($event,product.id,labelIndex)"
                                    @keyup="addQuantity($event,product.id,labelIndex)"
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
                            <span v-if="product.stock.length > 1">
                                <select class="form-select form-select-sm" v-model.trim="product.purchase_price">
                                    <option :value="null">Choose one</option>
                                    <option v-for="(stock, index) in product.stock.filter(stock => stock.branch_id == store.branchId)" :key="index"
                                        :value="stock.purchase_price">
                                        {{ stock.purchase_price }}
                                    </option>
                                </select>
                            </span>
                            <span v-else >
                                <input
                                type="number"
                                step="any"
                                class="form-control form-control-sm"
                                v-model.trim="product.purchase_price"
                            />
                            </span>
                        </td>
                        <td class="text-end print-none">
                            <button
                                class="btn btn-danger sm"
                                @click.prevent="store.cartProducts.splice(cartIndex,1)"
                                >
                                <i class="bi bi-trash-fill"></i>
                            </button>
                        </td>
                    </tr>

                    <tr v-if="store.cartProducts.length == 0">
                        <td colspan="11" class="text-center">No product in cart</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { usePiniaStore } from '@/store';
import convertToLowestUnit from "../../ConvertToLowestUnit";
import convertToUpperUnit from "../../ConvertToUpperUnit";
import alert from "../../alert";

const props = defineProps({
    oldProductTransfer: {
        type: Object
    },
});

const store = usePiniaStore()

let selectedProduct = ref(null);

// watcher
watch(selectedProduct, (_selectedProduct) => {
    if (_selectedProduct) {
        // console.log(_selectedProduct.stock);
        const productId = _selectedProduct.id;
        addToCart(productId);
        _selectedProduct.value = null;
    }
}, { deep: true });


//Same product multiple time added
// const addToCart = async (productId) => {
//     if (productId) {
//         let product = store.products.find(product => product.id == productId);
//         let branchProduct = product.branches.filter(branch => branch.id == store.branchId)
//         let branchQuantity = branchProduct.reduce((total, branch) => {
//             return total + parseFloat(branch.stock.quantity)
//         }, 0)

//         let displayQuantity = convertToUpperUnit(branchQuantity, product.unit_label, product.unit_relation);

//         const unitRelation = product.unit_relation.split('/')
//         let _quantity = [];
//         for (let i = 0; i < unitRelation.length; i++) {
//             _quantity[i] = null;
//         }

//         product.quantity_in_unit = _quantity;
//         product.product_unit_labels = product.unit_label.split('/');

//         const newProduct = {
//             ...product,
//             quantity: 0,
//             error: '',
//             display_quantity: displayQuantity || 'No Quantity Available',
//         };

//         store.$patch({
//             cartProducts: [...store.cartProducts, { ...newProduct }] // Push a new instance of the product to the cart
//         })

//         selectedProduct.value = null
//     }
// }

const addToCart = (productId) => {
    if (productId) {
        const index = store.cartProducts.findIndex(product => product.id == productId);
        let product = store.products.find(product => product.id == productId);
        if (index == -1) {
            let branchProduct = product.branches.filter(branch => branch.id == store.branchId)
            let branchQuantity = branchProduct.reduce((total, branch) => {
                return total + parseFloat(branch.stock.quantity)
            }, 0)

            let displayQuantity = convertToUpperUnit(branchQuantity, product.unit_label, product.unit_relation);

            const unitRelation = product.unit_relation.split('/')
            let _quantity = [];
            for (let i = 0; i < unitRelation.length; i++) {
                _quantity[i] = null;
            }

            product.quantity_in_unit = _quantity;
            product.product_unit_labels = product.unit_label.split('/');

            const newProduct = {
                ...product,
                quantity: 0,
                error: '',
                display_quantity: displayQuantity || 'No Quantity Available',
            };

            store.$patch({
                cartProducts: [...store.cartProducts, newProduct]
            })
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
const addQuantity = (event, selectedProduct, order) => {
    let product = store.cartProducts.find(product => product.id == selectedProduct);
    product.quantity_in_unit[order] = event.target.value ? event.target.value : null;
    product.quantity = convertToLowestUnit(product.quantity_in_unit, product.unit_relation);
    product.quantity_for_price = (product.quantity / product.divisor_number)
};

const initialValues = () => {
    if (props.oldProductTransfer) {
        props.oldProductTransfer.product_transfer_details.forEach(details => {
            addToCart(details.product_id);
            let product = store.cartProducts.find(product => product.id == details.product_id);
            product.quantity = details.quantity
            product.purchase_price = details.purchase_price
            product.quantity_in_unit = Object.assign({}, details.quantity_in_unit)
            // product.quantity_in_unit = JSON.parse(details.quantity_in_unit);
        })
    }
}

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


