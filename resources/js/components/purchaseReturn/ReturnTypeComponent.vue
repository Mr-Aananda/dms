<!-- ReturnTypeComponent.vue -->
<template>
  <div class="col-sm-10 mt-2">
    <div class="form-check form-check-inline">
      <input
        class="form-check-input fs-5"
        type="radio"
        v-model="store.return_type"
        @change="getDamageProducts"
        value="stock_return"
        id="stock_return"
      />
      <label class="form-check-label fw-bold fs-5" for="stock_return">Stock Return</label>
    </div>
    <div class="form-check form-check-inline">
      <input
        class="form-check-input fs-5"
        type="radio"
        v-model="store.return_type"
        @change="getDamageProducts"
        id="damage_return"
        value="damage_return"
      />
      <label class="form-check-label fw-bold fs-5" for="damage_return">Damage Return</label>
    </div>
  </div>
</template>

<script setup>
import { usePiniaStore } from '@/store';
import { onMounted, watch } from "vue";
import { storeToRefs } from 'pinia';
import alert from "../../alert";

const store = usePiniaStore();

const { oldPurchaseReturn: _oldPurchaseReturn } = storeToRefs(store);
watch(_oldPurchaseReturn, (oldPurchaseReturn) => {
  if (oldPurchaseReturn) {
    initialValues(oldPurchaseReturn);
  }
}, { deep: true });

const getDamageProducts = () => {
  if (store.return_type == 'damage_return') {
    store.products.forEach((product) => {
      if (product.damage_quantity > 0) {
        store.addToCart(product.id);
      }
    //   else {
    //     alert().fire({
    //         icon: 'warning',
    //         title: 'Damage Product not Available!'
    //     })
    //     return
    //   }
    });
  }
};

const initialValues = (oldPurchaseReturn) => {
    if (oldPurchaseReturn) {
        store.return_type = oldPurchaseReturn.return_type
    }
}

onMounted(() => {
    initialValues()
})
</script>
