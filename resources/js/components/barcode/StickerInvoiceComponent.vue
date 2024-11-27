<script setup>
import { onMounted, ref } from "vue";
import alert from "../../alert";

const props = defineProps({
    sale: [Object, null]
});

const allSale = ref([]);
const importer_name = ref(null);

const showAlert = (icon, title, text = '') => {
    alert().fire({ icon, title, text, confirmButtonText: 'OK' });
};

const setImporter = () => {
    if (!importer_name.value) {
        return showAlert('warning', 'Please enter an importer name.');
    }

    allSale.value.details.forEach(details => {
        details.product.importer_name = importer_name.value;
    });

    showAlert('success', 'Importer name set successfully!');
};

const generateSticker = () => {
    if (!importer_name.value || allSale.value.details.some(details => !details.product.importer_name)) {
        return showAlert('warning', 'Missing Importer Name', 'Please enter and set an importer name before generating the sticker.');
    }

    const data = JSON.stringify(allSale.value);
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    const form = document.createElement('form');
    form.method = 'POST';
    form.action = `${baseURL}/pos/generate-invoice-sticker`;

    const csrfInput = document.createElement('input');
    csrfInput.type = 'hidden';
    csrfInput.name = '_token';
    csrfInput.value = csrfToken;
    form.appendChild(csrfInput);

    const dataInput = document.createElement('input');
    dataInput.type = 'hidden';
    dataInput.name = 'data';
    dataInput.value = data;
    form.appendChild(dataInput);

    document.body.appendChild(form);
    form.submit();
};

onMounted(() => {
    allSale.value = props.sale;
});
</script>

<template>
    <div class="widget">
        <div v-if="allSale" class="widget-body" id="print-widget">
            <div class="row">
                <div class="col-6">
                    <input type="text" v-model="importer_name" placeholder="Enter importer name" class="form-control mb-3">
                </div>
                <div class="col-3">
                    <button @click="setImporter" class="btn btn-warning" type="button">Set Importer</button>
                </div>
                <table class="table table-bordered table-sm">
                    <thead>
                        <tr>
                            <th class="text-center" style="width: 50px;">SL</th>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th class="text-end">Price</th>
                            <th class="text-end">MRP</th>
                            <th>Importer</th>
                            <th class="text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(details, index) in allSale.details" :key="index">
                            <td class="text-center">{{ index + 1 }}</td>
                            <td>{{ details?.product_name }}</td>
                            <td class="text-end">
                                <div class="input-group">
                                    <input type="number" v-model="details.quantity" class="form-control form-control-sm"/>
                                    <span class="p-2">{{ details?.product?.unit_label }}</span>
                                </div>
                            </td>
                            <td class="text-end">{{ details?.sale_price }} Tk</td>
                            <td class="text-end">{{ details?.wholesale_price }} Tk</td>
                            <td>
                                <input type="text" v-model="details.product.importer_name" class="form-control form-control-sm" placeholder="Enter importer name"/>
                            </td>
                            <td class="text-end print-none">
                                <button class="btn btn-danger sm" @click.prevent="allSale.details.splice(index, 1)">
                                    <i class="bi bi-trash-fill"></i>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div v-if="allSale" class="text-center my-3">
            <button class="btn btn-primary" type="button" @click="generateSticker">
                <i class="bi bi-upc"></i>
                Generate Sticker
            </button>
        </div>
    </div>
</template>

<style scoped>
/* Scoped styles here */
</style>
