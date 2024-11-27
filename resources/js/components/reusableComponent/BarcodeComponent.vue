<template>
    <div>
        <label for="bercode" class="form-label">Barcode</label>
        <input
            type="text"
            style="border-radius: 5px !important; height: 42px;"
            class="form-control"
            name="bercode"
            v-model="barcode"
            autofocus
            @keydown.enter.prevent="getBarcodeProduct(barcode)"
            id="bercode"
            placeholder="Enter barcode number"
        />
        <!-- <input
            type="text"
            class="form-control"
            style="border-radius: 10px !important; height: 45px;"
            name="bercode"
            v-model="barcode"
            autofocus
            @keydown.enter.prevent="getBarcodeProduct(barcode)"
            id="bercode"
            placeholder="Enter barcode number"
        /> -->
    </div>

</template>

<script setup>
import { ref, onMounted } from "vue";
import { usePiniaStore } from '@/store';
import alert from "../../alert";

const store = usePiniaStore()

let barcode = ref(null)

const getBarcodeProduct = () => {
    if (barcode.value) {
        let product = store.products.find(product => product.barcode == barcode.value)
        if (product) {
            store.barcodeProduct = product
        }
        else {
      let toast = alert()
            toast.fire({
                icon: 'warning',
                title: 'Product does not exist for this barcode!'
            })
    //   alert('Product does not exist for this barcode.');
    }
    }
    barcode.value = null
}
</script>
