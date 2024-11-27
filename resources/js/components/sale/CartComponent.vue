<template>
    <div class="table-responsive mb-3">
        <table class="table table-striped table-bordered table-sm">
            <thead>
                <tr>
                    <th class="text-center">#</th>
                    <th style="min-width: 150px">Product name</th>
                    <th>Barcode</th>
                    <th class="text-end">Stock</th>
                    <th class="text-center">Price Type</th>
                    <th>Quantity</th>
                    <th>Purchase price</th>
                    <th>Trade price</th>
                    <th>Discount</th>
                    <th>Line Total</th>
                    <th class="text-end print-none">Action</th>
                </tr>
            </thead>
            <tbody style="vertical-align: middle !important;">
                <tr v-for="(product, cartIndex) in store.cartProducts" :key="cartIndex">
                    <td class="text-center">{{ cartIndex + 1 }}</td>
                    <td>{{ product.name }}</td>
                    <td>{{ product.barcode }}</td>
                    <td class="text-end">{{ product.display_quantity }}</td>
                    <td class="text-center">{{ product.product_unit_labels[product.price_type] }}</td>
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
                    <!-- Sale Price -->
                    <td>
                        <input
                            type="number"
                            step="any"
                            class="form-control form-control-sm"
                            v-model.trim="product.sale_price"
                        />
                    </td>
                    <!-- Discount Amount  -->
                    <td>
                        <input
                            @blur="addDiscount($event,product.id)"
                            @change="addDiscount($event,product.id)"
                            @keyup="addDiscount($event,product.id)"
                            type="text"
                            class="form-control form-control-sm"
                            v-model="product.discount"
                        />
                    </td>
                    <!--Line Total Amount -->
                    <td class="text-end">
                        {{
                            product.discountType == 'flat'
                            ?
                            Number.parseFloat(
                                product.total_price = ((product?.sale_price) * product?.quantity_for_price) - product?.discountAmount)
                                .toFixed(2)
                            :
                            Number.parseFloat(
                                product.total_price = ((((product?.sale_price) * product?.quantity_for_price) || 0) - ((((product?.sale_price) * product?.quantity_for_price) || 0) * parseFloat(product?.discountAmount || 0)) / 100))
                                .toFixed(2)
                        }}
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
</template>

<script setup>
import { onMounted } from "vue";
import { usePiniaStore } from '@/store';
import convertToUpperUnit from "../../ConvertToUpperUnit";
import convertToLowestUnit from "../../ConvertToLowestUnit";

const store = usePiniaStore()

//Add quantity method
const addQuantity = (event, selectedProduct, order) => {
    let product = store.cartProducts.find(product => product.id == selectedProduct);
    product.quantity_in_unit[order] = event.target.value ? event.target.value : null;
    product.quantity = convertToLowestUnit(product.quantity_in_unit, product.unit_relation);
    product.quantity_for_price = (product.quantity / product.divisor_number);
};


const addDiscount = (event, productId) => {
    let product = store.cartProducts.find(product => product.id == productId)

    if (product?.discount?.toString()?.includes('%')) {
        product.discountAmount = parseFloat(product?.discount.slice(0, -1))
        product.discountType = 'percentage'
    }else{
        product.discountAmount = parseFloat(product?.discount || 0)
        product.discountType = 'flat'
    }
}

// const selectedPurchasePrice = computed(() => {
//     return Array.isArray(product.stock) && product.stock.length == 1
//         ? product.stock[0].purchase_price
//         : product.purchase_price;
// });

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

onMounted(() => {


});


</script>

<style scoped>
</style>


