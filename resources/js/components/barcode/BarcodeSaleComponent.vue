<script setup>
import {onMounted, ref} from "vue";

    const props = defineProps({
        sale: [Object, null]
    })

    const allSale = ref([])
    const date = ref(new Date().toISOString().substr(0, 10));

    const setDate = () => {
        allSale.value.details.map(details => {
            details.product.expired_date = date.value
        })
    }

    const generateBarcode = () => {
        const data = JSON.stringify(allSale.value);

        // Get the CSRF token from the meta tag
        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

        // Create a form element
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = `${baseURL}/pos/generate-sale-barcode`;

        // Create an input element for the CSRF token
        const csrfInput = document.createElement('input');
        csrfInput.type = 'hidden';
        csrfInput.name = '_token';
        csrfInput.value = csrfToken;
        form.appendChild(csrfInput);

        // Create an input element to hold the JSON data
        const dataInput = document.createElement('input');
        dataInput.type = 'hidden';
        dataInput.name = 'data';
        dataInput.value = data;
        form.appendChild(dataInput);

        // Append the form to the body and submit it
        document.body.appendChild(form);
        form.submit();
        // submitData()
        // console.log(allSale.value)
        // window.location.href = `${baseURL}/generate-sale-barcode/${JSON.stringify(allSale.value)}`
    }

    const submitData = async () => {
        generateBarcode()
    }

    onMounted(() => {
        allSale.value = props.sale
    })
</script>

<template>
    <div class="widget">
        <div v-if="allSale" class="widget-body" id="print-widget">
            <div class="row">
                <div class="col-6">
                    <input type="date" v-model="date" class="form-control mb-3">
                </div>
                <div class="col-3">
                    <button @click="setDate" class="btn btn-primary" type="button">Set Date</button>
                </div>
                <table class="table table-bordered table-sm">
                    <thead>
                    <tr>
                        <th class="text-center" style="width: 50px;">SL</th>
                        <th>Product</th>
                        <th class="text-end">Qty</th>
                        <th class="text-end">Price</th>
                        <th class="text-end">MRP</th>
                        <th class="text-end">Expired Date</th>
                        <th class="text-end">Action</th>
                    </tr>
                    </thead>
                    <tbody>

                    <tr v-for="(details, index) in allSale.details" :key="index">
                        <td class="text-center">{{ index + 1 }}</td>
                        <td>{{ details?.product_name }}</td>
                        <td class="text-end">
                            <div class="input-group">
                                <input
                                    type="number"
                                    v-model="details.quantity"
                                    class="form-control form-control-sm"
                                />
                                {{ details?.product?.unit_label }}
                            </div>
                        </td>
                        <td class="text-end">{{ details?.sale_price }} Tk</td>
                        <td class="text-end">{{ details?.wholesale_price }} Tk</td>
                        <td>
                            <div class="input-group">
                                <input
                                    type="date"
                                    v-model="details.product.expired_date"
                                    class="form-control form-control-sm"
                                />
                            </div>
                        </td>

                        <td class="text-end print-none">
                            <button
                                class="btn btn-danger sm"
                                @click.prevent="allSale.details.splice(index,1)"
                            >
                                <i class="bi bi-trash-fill"></i>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div v-if="allSale" class="text-center my-3">
            <button class="btn btn-primary" type="button" @click="generateBarcode">
                <i class="bi bi-upc"></i>
                Generate Barcode
            </button>
        </div>
    </div>
</template>

<style scoped>

</style>