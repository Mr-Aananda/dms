<template>
    <div>
        <label for="category" class="form-label required">Products</label>
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
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { storeToRefs } from 'pinia';
import { usePiniaStore } from '@/store';
import convertToUpperUnit from "../../ConvertToUpperUnit";
import alert from "../../alert";


const store = usePiniaStore()
const { barcodeProduct: _barcodeProduct } = storeToRefs(store)
const { oldPurchase: _oldPurchase } = storeToRefs(store);
const { oldPurchaseReturn: _oldPurchaseReturn } = storeToRefs(store);
const { oldSale: _oldSale } = storeToRefs(store);
const { oldSaleReturn: _oldSaleReturn } = storeToRefs(store);
const { oldDamage: _oldDamage } = storeToRefs(store);

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

watch(_barcodeProduct, (barcodeProduct) => {
    if (barcodeProduct) {
        selectedProduct.value = barcodeProduct;
        store.$patch({
            barcodeProduct: null
        });
    }
}, { deep: true });

watch(_oldPurchase, (oldPurchase) => {
  if (oldPurchase) {
    initialValues(oldPurchase);
  }
}, { deep: true });

watch(_oldPurchaseReturn, (oldPurchaseReturn) => {
  if (oldPurchaseReturn) {
    initialValues(oldPurchaseReturn);
  }
}, { deep: true });

watch(_oldSale, (oldSale) => {
  if (oldSale) {
    initialValues(oldSale);
  }
}, { deep: true });

watch(_oldSaleReturn, (oldSaleReturn) => {
  if (oldSaleReturn) {
    initialValues(oldSaleReturn);
  }
}, { deep: true });

watch(_oldDamage, (oldDamage) => {
  if (oldDamage) {
    initialValues(oldDamage);
  }
}, { deep: true });

const addToCart = (productId) => {
    if (productId) {
        const index = store.cartProducts.findIndex(product => product.id == productId);
        let product = store.products.find(product => product.id == productId);
              console.log(store.cartProducts);
        if (index == -1) {
            let branchProduct = product.branches.filter(branch => branch.id == store.branchId)

            // let branchQuantity = branchProduct.reduce((total, branch) => {
            //     return total + parseFloat(branch.stock.quantity)
            // }, 0)
            let branchQuantity = branchProduct.find(_product => _product.stock.purchase_price == product?.stock?.filter(stock => stock.branch_id == store.branchId)[0]?.purchase_price)?.stock?.quantity ?? 0

            let quantity = store.return_type == 'stock_return' ? branchQuantity : product.damage_quantity;

            let displayQuantity = convertToUpperUnit(quantity, product.unit_label, product.unit_relation);

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
                discount: 0,
                discountAmount: 0,
                discountType: 'flat',
                quantity_for_price: 0,
                total_price: 0,
                return_price: product.stock?.filter(stock => stock.branch_id == store.branchId)[0]?.purchase_price ?? product.purchase_price,
                purchase_price: product.stock?.filter(stock => stock.branch_id == store.branchId)[0]?.purchase_price ?? product.purchase_price,
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

const initialValues = async (oldData) => {
    // console.log(oldData);
    if (oldData) {
     await  oldData.details.forEach(details => {
            addToCart(details.product_id);
            let product = store.cartProducts.find(product => product.id == details.product_id);
            product.quantity = details.quantity
            product.purchase_price = details.purchase_price
            product.sale_price = details.sale_price
            product.return_price = details.return_price
            product.wholesale_price = details.wholesale_price
            product.discount = details.discount
            product.quantity_for_price = (details.quantity / product.divisor_number)
            product.quantity_in_unit = Object.assign({}, details.quantity_in_unit)
            product.discountAmount = details.discount
            product.discountType = 'flat'
            // product.quantity_in_unit = JSON.parse(details.quantity_in_unit);
        })
    }
}

onMounted(() => {
    initialValues();

    store.$patch({
        addToCart: addToCart
    });

});

</script>

<style scoped>
.multiselect{
    min-height: auto !important;
    height: 40px !important;
}
</style>


