<template>
    <form  @submit.prevent="purchaseReturn">

        <div class="row mb-2">
            <return-type-component/>
        </div>

        <div class="row mb-2">
            <barcode-component ref="barcode" class="col-6"/>
        </div>

        <div class="row mb-4">
            <date-component ref="date" class="col-3" :old-purchase-return = "props.oldPurchaseReturn"/>
            <branch-component ref="branch" class="col-3" :old-purchase-return = "props.oldPurchaseReturn"/>
            <!-- <product-type-component ref="type" class="col-2" /> -->
            <product-component class="col-6" />
        </div>

        <div class="row mb-2">
            <cart-component/>
        </div>

        <div class="row">
            <div class="col-6">
                <supplier-component ref="supplier" class="col-11" :old-purchase-return = "props.oldPurchaseReturn"/>
                <note-component ref="note" class="col-11" :old-purchase-return = "props.oldPurchaseReturn" />
            </div>
            <div class="col-6">
                <payment-component ref="payment" :old-purchase-return = "props.oldPurchaseReturn"/>
            </div>
        </div>

        <div class="row my-3">
            <div class="col-12 text-end">
                <button class="btn btn-danger me-2" type="reset"><i class="bi bi-stars"></i>Reset</button>
                <button class="btn btn-success" type="submit"><i class="bi bi-download"></i>
                    {{ oldPurchaseReturn ? 'Update Return' : 'New Return' }}
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
// import ProductTypeComponent from "../reusableComponent/ProductTypeComponent.vue";
import ProductComponent from "../reusableComponent/ProductComponent.vue";
import BarcodeComponent from "../reusableComponent/BarcodeComponent.vue";
import CartComponent from "./CartComponent.vue";
import SupplierComponent from "../reusableComponent/SupplierComponent.vue";
import PaymentComponent from "./PaymentComponent.vue";
import NoteComponent from "../reusableComponent/NoteComponent.vue";
import ReturnTypeComponent from "./ReturnTypeComponent.vue";
import alert from "../../alert";
import confirmAlert from "../../confirmAlert";

const store = usePiniaStore()

const props = defineProps({
    oldPurchaseReturn: {
        type: Object
    },
})

let barcode = ref(null)
let date = ref(null)
let branch = ref(null)
// let type = ref(null)
let supplier = ref(null)
let payment = ref(null)
let note = ref(null)
let disabledPurchaseButton = ref(false)

const purchaseReturn = () => {
    let text = props.oldPurchaseReturn ? 'You want to update this return!' : 'You want to return this!';
    confirmAlert(text).then((result) => {
        if (result.isConfirmed) {
            savePurchaseReturn()
        }
    })
}

const savePurchaseReturn = () => {
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
            title: 'Please enter date!'
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

    if (!payment.value.cashId && payment.value.payment_type == 'cash') {
        toast.fire({
            icon: 'error',
            title: 'Please select cash!'
        })
        return
    }
    if (!supplier.value.selectedSupplier) {
        toast.fire({
            icon: 'error',
            title: 'Please select supplier!'
        })
        return
    }

    let form = new FormData();
    form.append('date', date.value.date);
    form.append('party_id', supplier.value.selectedSupplier.id);
    form.append('branch_id', store.branchId);
    form.append('return_type', store.return_type);
    form.append('note',  note.value.note);

    //from payment
    form.append('previous_balance', supplier.value.supplierBalance);
    form.append('party_remaining_balance', payment.value.partyRemainingBalance);
    form.append('subtotal', payment.value.subtotal);
    form.append('paid', payment.value.paid || 0);
    form.append('discount', payment.value.adjustment || 0);
    form.append('payment_type', payment.value.payment_type);
    form.append('cash_id', payment.value.cashId ?? '');
    form.append('bank_account_id', payment.value.bankAccountId ?? '');

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
            return_price: product.return_price,
            quantity_in_unit: product.quantity_in_unit,
            line_total: product.total_price,
        });
    });
    disabledPurchaseButton.value = true

    if(quantityError) {
        products = []
        return
    }

    form.append('products', JSON.stringify(products))

    if (props.oldPurchaseReturn) {
        updatePurchaseReturn(form)
    }else{
        newPurchaseReturn(form)
    }
}

const newPurchaseReturn = (form) => {
    // form.append('_enctype', 'multipart/form-data')
    axios.post(baseURL+'/pos/purchase-return', form)
        .then((response) => {
            console.log(response.data)
             alert().fire({
                icon: 'success',
                title: 'Purchase return created successfully!'
            });
            setTimeout(() => {
                window.location.href = baseURL + "/pos/purchase-return/" + response.data.id
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

const updatePurchaseReturn = (form) => {
    form.append('_method', 'PUT')
    axios.post(baseURL+'/pos/purchase-return/'+ props.oldPurchaseReturn.id, form)
        .then((response) => {
            console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'Purchase return updated successfully!'
            });
            setTimeout(() => {
                window.location.href = baseURL + "/pos/purchase-return/" + response.data.id

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

const initialValues = () => {
   if (props.oldPurchaseReturn) {
        store.$patch({
            oldPurchaseReturn: props.oldPurchaseReturn
        });
    }

    // console.log(props.oldPurchase);
}

onMounted( async () => {
    await store.loadAllProducts()
    initialValues()
})

</script>
