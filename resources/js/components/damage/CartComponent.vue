<template>
    <div class="table-responsive mb-3">
        <table class="table table-striped table-bordered table-sm">
            <thead>
                <tr>
                    <th class="text-center">#</th>
                    <th style="min-width: 150px">Product name</th>
                    <th class="text-end">Stock</th>
                    <th>Purchase price</th>
                    <th>Quantity</th>
                    <th class="text-end print-none">Action</th>
                </tr>
            </thead>
            <tbody style="vertical-align: middle !important;">
                <tr v-for="(product, cartIndex) in store.cartProducts" :key="cartIndex">
                    <td class="text-center">{{ cartIndex + 1 }}</td>
                    <td>{{ product.name }}</td>
                    <td class="text-end">{{ product.display_quantity }}</td>
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
                    <!-- Quantity-->
                    <td>
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
import { usePiniaStore } from '@/store';
import convertToLowestUnit from "../../ConvertToLowestUnit";

const store = usePiniaStore()

//Add quantity method
const addQuantity = (event, selectedProduct, order) => {
    let product = store.cartProducts.find(product => product.id == selectedProduct);
    product.quantity_in_unit[order] = event.target.value ? event.target.value : null;
    product.quantity = convertToLowestUnit(product.quantity_in_unit, product.unit_relation);
    product.quantity_for_price = (product.quantity / product.divisor_number)
};

</script>

<style scoped>
</style>


