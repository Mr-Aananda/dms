<template>
   <form @submit.prevent="production">
        <!-- Date -->
        <div class="row mb-5">
            <date-component ref="date" class="col-6" :old-production = "props.oldProduction"/>
            <branch-component ref="branch" class="col-6" :old-production = "props.oldProduction"/>
        </div>
        <div class="row border rounded-3 p-2 m-2">
            <div class="col-6">
                <raw-product-component ref="getRawProducts" :old-production = "props.oldProduction" />
            </div>
            <div class="col-6">
                <finish-product-component ref="getFinishProducts" :old-production = "props.oldProduction" />
            </div>
        </div>

        <!-- Note -->
        <note-component ref="note" class="col-12 mt-4" :old-production = "props.oldProduction"/>

        <div class="row my-3">
            <div class="col-12 text-end">
                <button class="btn btn-danger me-2" type="reset"><i class="bi bi-stars"></i>Reset</button>
                <button class="btn btn-success" type="submit" :disabled="disabledProductionButton"><i class="bi bi-download"></i>
                    {{ oldProduction ? 'Update Production' : 'Create Production' }}
                </button>
            </div>
        </div>
   </form>
</template>

<script setup>
import {onMounted,ref} from "vue";
import { usePiniaStore } from '@/store';
import DateComponent from '../reusableComponent/DateComponent.vue';
import BranchComponent from '../reusableComponent/BranchComponent.vue';
import NoteComponent from '../reusableComponent/NoteComponent.vue';
import RawProductComponent from "./RawProductComponent.vue";
import FinishProductComponent from "./FinishProductComponent.vue";
import alert from "../../alert";
import confirmAlert from "../../confirmAlert";

const store = usePiniaStore()

const props = defineProps({
    oldProduction: {
        type: Object
    },
})

let date = ref(null);
let branch = ref(null);
let getRawProducts = ref(null);
let getFinishProducts = ref(null);
let note = ref(null);
const disabledProductionButton = ref(false)

const production = () => {
    let text = props.oldProduction ? 'You want to update this production!' : 'You want to production this!';
    confirmAlert(text).then((result) => {
        if (result.isConfirmed) {
            saveProduction()
        }
    })
}

const saveProduction = () => {
    // Validate form data
    if (!validateFormData()) {
        return;
    }

    let form = new FormData();
    form.append('date', date.value.date);
    form.append('branch_id', store.branchId);
    form.append('note',  note.value.note);

    let rawProducts = [];
    let finishProducts = [];

    let rawQuantityError = false;
    let finishQuantityError = false;

    getRawProducts.value.rawCartProducts.forEach(product => {
        if(product.quantity <= 0) {
            rawQuantityError = true
            product.error = "Quantity can\'t be empty"
        }else{
            product.error = ''
        }
        rawProducts.push({
            id: product.id,
            quantity: product.quantity,
            purchase_price: product.purchase_price,
            sale_price: product.sale_price,
            wholesale_price: product.wholesale_price,
            quantity_in_unit: product.quantity_in_unit,
        });
    });
    getFinishProducts.value.finishCartProducts.forEach(product => {
        if(product.quantity <= 0) {
            finishQuantityError = true
            product.error = "Quantity can\'t be empty"
        }else{
            product.error = ''
        }
        finishProducts.push({
            id: product.id,
            quantity: product.quantity,
            purchase_price: product.purchase_price,
            sale_price: product.sale_price,
            wholesale_price: product.wholesale_price,
            quantity_in_unit: product.quantity_in_unit,
        });
    });
    // disabledPurchaseButton.value = true

    if(rawQuantityError) {
        rawProducts = []
        return
    }
    if(finishQuantityError) {
        finishProducts = []
        return
    }

    form.append('rawProducts', JSON.stringify(rawProducts))
    form.append('finishProducts', JSON.stringify(finishProducts))

    if (props.oldProduction) {
        updateProduction(form)
    }else{
        newProduction(form)
    }
}

const newProduction = (form) => {
    // console.log(form)
    axios.post(baseURL + '/pos/production', form)
        .then((response) => {
            console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'production has been save successfully!'
            })
            setTimeout(() => {
                window.location.href = baseURL + "/pos/production";

            }, 1000);
        })
        .catch((error) => {
        if (error.response && error.response.data && error.response.data.errors) {
            alert().fire({
            icon: 'error',
            title: error.response.data.message ?? "Somthing went wrong !"
        });
        console.log(error.response.data.errors);
        } else {
            console.error(error);
            alert().fire({
                icon: 'error',
                title: "Somthing went wrong !"
            });
        }
    });
}

const updateProduction = (form) => {
    form.append('_method', 'PUT')
    axios.post(baseURL + '/pos/production/' + props.oldProduction.id, form)
        .then((response) => {
            console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'production has been save successfully!'
            })
            setTimeout(() => {

                 window.location.href = baseURL + "/pos/production";

            }, 1000);
        })
        .catch((error) => {
        if (error.response && error.response.data && error.response.data.errors) {
            alert().fire({
            icon: 'error',
            title: error.response.data.message ?? "Somthing went wrong !"
        });
        console.log(error.response.data.errors);
        } else {
            console.error(error);
            alert().fire({
                icon: 'error',
                title: "Somthing went wrong !"
            });
        }
    });
}

const validateFormData = () => {
    let toast = alert()
    if (getRawProducts.value.rawCartProducts.length <= 0) {
        alert().fire({
            icon: 'warning',
            title: 'Raw product cart is empty!'
        })
        return
    }
    if (getFinishProducts.value.finishCartProducts.length <= 0) {
        alert().fire({
            icon: 'warning',
            title: 'Finish product cart is empty!'
        })
        return
    }

    if (!date.value.date) {
        toast.fire({
            icon: 'error',
            title: 'Please select date!'
        })
        return
    }

    if (!store.branchId) {
        toast.fire({
            icon: 'error',
            title: 'Please select branch!'
        })
        return
    }

  // If all validations pass, return true
  return true;
};

const initialValues = () => {
   if (props.oldProduction) {
        store.$patch({
            oldProduction: props.oldProduction
        });
    }
}

onMounted(() => {
    initialValues()
})

</script>
