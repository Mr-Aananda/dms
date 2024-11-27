<template>
    <div class="mb-4">
        <label for="category" class="form-label required">Raw Products</label>
        <Multiselect
            v-model="selectedProduct"
            :options="store.products"
            label="name"
            track-by="name"
            placeholder="Choose one"
            :close-on-select="true"
            :clear-on-select="false"
            :open-direction="'bottom'"
            @select="rawAddToCart"
        />
    </div>
    <div class="mb-2">
        <table class="table table-striped table-bordered table-sm">
            <thead>
                <tr>
                    <th class="text-center">#</th>
                    <th style="min-width: 150px">Product Name</th>
                    <th class="text-end">Stock</th>
                    <th>Purchase price</th>
                    <th>Cut Quantity</th>
                    <th class="text-end">Total</th>
                    <th class="text-end print-none">Action</th>
                </tr>
            </thead>
            <tbody style="vertical-align: middle !important">
                <tr
                    v-for="(product, cartIndex) in rawCartProducts"
                    :key="cartIndex"
                >
                    <td class="text-center">{{ cartIndex + 1 }}</td>
                    <td>{{ product.name }}</td>
                    <td class="text-end">{{ product.display_quantity }}</td>
                    <!-- Purchase Price -->
                    <td>
                        <span v-if="product.stock.length > 0">
                            <select
                                class="form-select form-select-sm"
                                v-model.trim="product.purchase_price"
                                @change="stockPurchasePrice(product)"
                            >
                                <option :value="null">Choose one</option>
                                <option v-for="(stock, index) in product.stock?.filter(stock => stock.branch_id == store.branchId)" :key="index"
                                    :value="stock.purchase_price ">
                                    {{ stock.purchase_price }}
                                </option>
                            </select>
                        </span>
                        <span v-else>
                            <input
                            type="number"
                            step="any"
                            class="form-control form-control-sm"
                            v-model.trim="product.purchase_price"
                        />
                        </span>
                    </td>
                    <td>
                        <div class="input-group">
                            <input
                                type="number"
                                aria-describedby="quantityError"
                                v-for="(label, labelIndex) in product.product_unit_labels"
                                :placeholder="label"
                                :key="labelIndex"
                                :value="product.quantity_in_unit[labelIndex]"
                                @blur="addRawQuantity($event,product.id,labelIndex, cartIndex)"
                                @change="addRawQuantity($event,product.id,labelIndex, cartIndex)"
                                @keyup="addRawQuantity($event,product.id,labelIndex, cartIndex)"
                                min="0"
                                step="any"
                                class="form-control form-control-sm"
                            />
                        </div>
                        <div
                            v-if="product.error"
                            id="quantityError"
                            class="form-text text-danger"
                        >
                            {{ product.error }}
                        </div>
                    </td>

                    <td class="text-end">
                        {{Number.parseFloat(product.line_total = (product?.purchase_price * product?.quantity_for_price ).toFixed(2))}}
                     </td>

                    <td class="text-end print-none">
                        <button
                            class="btn btn-danger sm"
                            @click.prevent="
                                rawCartProducts.splice(cartIndex, 1)
                            "
                        >
                            <i class="bi bi-trash-fill"></i>
                        </button>
                    </td>
                </tr>

                <tr v-if="rawCartProducts.length == 0">
                    <td colspan="11" class="text-center">
                        No product in cart!
                    </td>
                </tr>
            </tbody>
            <tfoot>
                <tr class="fw-bold">
                    <td colspan="5" class="text-end">Total: </td>
                    <td class="text-end">{{ Number.parseFloat(totalPrice).toFixed(2) }}</td>
                </tr>
            </tfoot>
        </table>
    </div>
</template>

<script setup>
import { ref, onMounted,computed } from "vue";
import { usePiniaStore } from "@/store";
import { storeToRefs } from "pinia";
import convertToUpperUnit from "../../ConvertToUpperUnit";
import convertToLowestUnit from "../../ConvertToLowestUnit";
import alert from "../../alert";

const store = usePiniaStore();
const { products: _products } = storeToRefs(store);

const props = defineProps({
    oldProduction: {
        type: Object,
    },
});

const selectedProduct = ref(null);
const rawProducts = ref([]);
const rawCartProducts = ref([]);

const totalPrice = computed(() => {
    // Calculate total price by summing up line totals of all products
    return rawCartProducts.value.reduce((total, product) => {
        return total + parseFloat(product.line_total);
    }, 0).toFixed(2);
});

const rawAddToCart = () => {
    if (selectedProduct) {
        let product = store.products.find(product => product.id == selectedProduct.value.id);
        let branchProduct = product.branches.filter(branch => branch.id == store.branchId);
        let branchQuantity = branchProduct.find(_product => _product.stock.purchase_price == product.stock.find(stock => stock.branch_id === store.branchId)?.purchase_price)?.stock?.quantity ?? 0;

        let displayQuantity = convertToUpperUnit(branchQuantity, product.unit_label, product.unit_relation);

        const unitRelation = product.unit_relation.split("/");
        let _quantity = Array(unitRelation.length).fill(null);

        product.quantity_in_unit = _quantity;
        product.product_unit_labels = product.unit_label.split("/");

        const newProduct = {
            ...product,
            quantity: 0,
            quantity_for_price: 0,
            line_total:0,
            purchase_price: product.stock.find(stock => stock.branch_id == store.branchId)?.purchase_price ?? product.purchase_price,
            error: "",
            display_quantity: displayQuantity || "No Quantity Available",
        };

        rawCartProducts.value.push(newProduct);

        selectedProduct.value = null;
    }
    // console.log(rawCartProducts);
};

const stockPurchasePrice = (product) => {
    let selectedPurchasePrice = product.purchase_price;
    if (selectedPurchasePrice != null) {
        let branchProduct = product.branches.find(branch => branch.id == store.branchId && branch.stock.purchase_price == selectedPurchasePrice);
        if (branchProduct) {
            console.log(branchProduct.stock.quantity);
            product.display_quantity = convertToUpperUnit(branchProduct.stock.quantity, product.unit_label, product.unit_relation);
        }
    } else {
        // Reset display quantity if no purchase price selected
        product.display_quantity = 0;
    }
}

//Add quantity method
const addRawQuantity = (event, productId, order, index) => {
    // let product = rawCartProducts.value.find((product) => product.id == productId);
    let product = rawCartProducts.value[index];
    product.quantity_in_unit[order] = event.target.value ? event.target.value: null;
    product.quantity = convertToLowestUnit(product.quantity_in_unit, product.unit_relation);
    product.quantity_for_price = (product.quantity / product.divisor_number)
};

defineExpose({
    rawCartProducts,
});

const initialValues = () => {
    if (props.oldProduction) {
        props.oldProduction.details.forEach((details, index) => {
            if (details.production_type == 'raw_product') {
                let exitProduct = store.products.find((product) => product.id == details.product_id);
                selectedProduct.value = exitProduct;
                rawAddToCart();
                let product = rawCartProducts.value[index];
                product.quantity = details.quantity;
                product.purchase_price = details.purchase_price;
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

