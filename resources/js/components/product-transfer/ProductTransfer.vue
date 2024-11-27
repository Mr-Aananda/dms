<template>
    <form @submit.prevent="productTransfer">

        <date-component ref="date" :old-product-transfer = "props.oldProductTransfer"/>
        <branch-component ref="branch" :old-product-transfer = "props.oldProductTransfer"/>

        <product-component ref="products" :old-product-transfer = "props.oldProductTransfer"/>

        <note-component ref="note" class="col-12" :old-product-transfer = "props.oldProductTransfer"/>
         <div class="row my-3">
            <div class="col-12 text-end">
                <button class="btn btn-danger me-2" type="reset"><i class="bi bi-stars"></i>Reset</button>
                <button class="btn btn-success" type="submit" :disabled="disabledProductTransferButton"><i class="bi bi-download"></i>
                    {{ oldProductTransfer ? 'Update Transfer' : 'Create Transfer' }}
                </button>
            </div>
        </div>
    </form>
</template>

<script setup>
import {onMounted,ref} from "vue";
import { usePiniaStore } from '@/store';
import DateComponent from '../reusableComponent/DateComponent.vue';
import ProductComponent from './ProductComponent.vue';
import NoteComponent from '../reusableComponent/NoteComponent.vue';
import BranchComponent from './BranchComponent.vue';
import alert from "../../alert";
import confirmAlert from "../../confirmAlert";

const store = usePiniaStore()

const props = defineProps({
    oldProductTransfer: {
        type: Object
    },
});

let date = ref(null);
let branch = ref(null);
let note = ref(null);
let disabledProductTransferButton = ref(false)


const productTransfer = () => {
    let text = props.oldProductTransfer ? 'You want to update transfer product!' : 'You want to transfer this!';
    confirmAlert(text).then((result) => {
        if (result.isConfirmed) {
            saveProductTransfer()
        }
    })
}

const saveProductTransfer = () => {
    // Validate form data
    if (!validateFormData()) {
        return;
    }

    let form = new FormData();
    form.append('date', date.value.date);
    form.append('from_branch_id', branch.value.from_branch_id);
    form.append('to_branch_id', branch.value.to_branch_id);
    form.append('note', note.value.note);

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
        });
    });

    if(quantityError) {
        products = []
        return
    }

    form.append('products', JSON.stringify(products))

    if (props.oldProductTransfer) {
        updateProductTransfer(form)
    }else{
        newProductTransfer(form)
    }

}

const newProductTransfer = (form) => {
    // console.log(form)
    axios.post(baseURL + '/pos/product-transfer', form)
        .then((response) => {
            console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'Product transfer successfully!'
            })
            setTimeout(() => {
                window.location.href = baseURL + "/pos/product-transfer ";

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
                title: error.response.data.error ?? "Somthing went wrong !"
            });
        }
    });
}

const updateProductTransfer = (form) => {
    form.append('_method', 'PUT')
    axios.post(baseURL+'/pos/product-transfer/'+ props.oldProductTransfer.id, form)
        .then((response) => {
            console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'Product transfer update successfully!'
            })
            setTimeout(() => {
                window.location.href = baseURL + "/pos/product-transfer";

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
                title: error.response.data.error ?? "Somthing went wrong !"
            });
        }
    });
}

const validateFormData = () => {
    let toast = alert()
    if (store.cartProducts.length <= 0) {
        alert().fire({
            icon: 'warning',
            title: 'Cart is empty!'
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

    if (!branch.value.from_branch_id) {
        toast.fire({
            icon: 'error',
            title: 'Please select from branch!'
        })
        return
    }
    if (!branch.value.to_branch_id) {
        toast.fire({
            icon: 'error',
            title: 'Please select to branch!'
        })
        return
    }

  // If all validations pass, return true
  return true;
};



const initialValues = () => {
   if (props.oldProductTransfer) {
        store.$patch({
            oldProductTransfer: props.oldProductTransfer
        });
    }
}

onMounted( async () => {
    await store.loadAllBranches()
    initialValues()
})
</script>
