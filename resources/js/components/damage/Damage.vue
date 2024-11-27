<template>
    <form @submit.prevent="damage">
        <div class="row mb-2">
            <barcode-component ref="barcode" class="col-6"/>
        </div>

        <div class="row mb-4">
            <date-component ref="date" class="col-3" :old-purchase = "props.oldDamage"/>
            <branch-component ref="branch" class="col-3" :old-purchase = "props.oldDamage"/>
            <!-- <product-type-component ref="type" class="col-2" /> -->
            <product-component class="col-6" />
        </div>

        <div class="row">
            <cart-component/>
        </div>

        <div class="row">
            <note-component ref="note" class="col-12" :old-purchase = "props.oldDamage" />
        </div>

        <div class="row my-3">
            <div class="col-12 text-end">
                <button class="btn btn-danger me-2" type="reset"><i class="bi bi-stars"></i>Reset</button>
                <button class="btn btn-success" type="submit" :disabled="disabledDamageButton"><i class="bi bi-download"></i>
                    {{ oldDamage ? 'Update Damage' : 'New Damage' }}
                </button>
            </div>
        </div>

    </form>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { usePiniaStore } from '@/store';
import DateComponent from '../reusableComponent/DateComponent.vue';
import BranchComponent from "../reusableComponent/BranchComponent.vue";
import ProductTypeComponent from "../reusableComponent/ProductTypeComponent.vue";
import ProductComponent from "../reusableComponent/ProductComponent.vue";
import BarcodeComponent from "../reusableComponent/BarcodeComponent.vue";
import CartComponent from "./CartComponent.vue";
import NoteComponent from "../reusableComponent/NoteComponent.vue";
import alert from "../../alert";
import confirmAlert from "../../confirmAlert";

const store = usePiniaStore()

const props = defineProps({
    oldDamage: {
        type: Object
    },
})

let date = ref(null)
let branch = ref(null)
let type = ref(null)
let note = ref(null)
let disabledDamageButton = ref(false)

const damage = () => {
    let text = props.oldDamage ? 'You want to update this damage!' : 'You want to damage this!';
    confirmAlert(text).then((result) => {
        if (result.isConfirmed) {
            saveDamage()
        }
    })
}

const saveDamage = () => {
    let toast = alert()
    if (store.cartProducts.length <= 0) {
        alert().fire({
            icon: 'warning',
            title: 'Cart is empty!'
        })
        return
    }


    let form = new FormData();
    form.append('date', date.value.date);
    form.append('branch_id', store.branchId);
    form.append('note',  note.value.note);

    let products = [];

    let quantityError = false;
    store.cartProducts.forEach(product => {
        if(product.quantity <= 0) {
            quantityError = true
            product.error = "Quantity can\'t be empty"
        }else{
            product.error = ''
        }
        products.push({
            id: product.id,
            quantity: product.quantity,
            purchase_price: product.purchase_price,
            quantity_in_unit: product.quantity_in_unit,
            line_total: product.total_price,
        });
    });
    // disabledDamageButton.value = true

    if(quantityError) {
        products = []
        return
    }

    form.append('products', JSON.stringify(products))

    if (props.oldDamage) {
        updateDamage(form)
    }else{
        newDamage(form)
    }
}

const newDamage = (form) => {
    // form.append('_enctype', 'multipart/form-data')
    axios.post(baseURL+'/pos/damage', form)
        .then((response) => {
            // console.log(response.data)
             alert().fire({
                icon: 'success',
                title: 'Damage created successfully!'
            });
            setTimeout(() => {
                window.location.href = baseURL + "/pos/damage/" + response.data.id

            }, 1000);
        })
        .catch((error) => {
            console.log(error.response.data.errors)
            store.$patch({
                errors: error.response.data.errors
            });
        })
}

const updateDamage = (form) => {
    form.append('_method', 'PUT')
    axios.post(baseURL+'/pos/damage/'+ props.oldDamage.id, form)
        .then((response) => {
            console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'Damage updated successfully!'
            });
            setTimeout(() => {
                window.location.href = baseURL + "/pos/damage/" + response.data.id
            }, 1000);
        })
        .catch((error) => {
            console.log(error.response.data.errors)
            store.$patch({
                errors: error.response.data.errors
            });
        })
}

const initialValues = () => {
   if (props.oldDamage) {
        store.$patch({
            oldDamage: props.oldDamage
        });
    }
}

onMounted( async () => {
    await store.loadAllProducts()
    initialValues()
})

</script>
