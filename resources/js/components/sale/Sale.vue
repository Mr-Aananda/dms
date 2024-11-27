<template>
    <form @submit.prevent="sale" >
        <div class="row mb-2">
            <barcode-component ref="barcode" class="col-6"/>
        </div>
        <div class="row mb-4">
            <date-component ref="date" class="col-3" :old-sale = "props.oldSale"/>
            <branch-component ref="branch" class="col-3" :old-sale = "props.oldSale"/>
            <!-- <product-type-component ref="type" class="col-4" /> -->
            <product-component class="col-6" />
        </div>

        <div class="row mb-2">
            <cart-component />
        </div>

        <div class="row">
            <div class="col-6">
                <customer-component ref="customer" class="col-11" :from = "from" :old-sale = "props.oldSale"/>
                <note-component ref="note" class="col-11" :old-sale = "props.oldSale"/>
            </div>
            <div class="col-6">
                <payment-component ref="payment" :from = "from" :old-sale = "props.oldSale"/>
            </div>
        </div>

        <div class="row my-3">
            <div class="col-12 text-end">
                <button class="btn btn-danger me-2" type="reset"><i class="bi bi-stars"></i>Reset</button>
                <button class="btn btn-success" type="submit" :disabled="disabledSaleButton"><i class="bi bi-download"></i>
                    {{ oldSale ? 'Update Sale' : 'New Sale' }}
                </button>
            </div>
        </div>

    </form>

</template>

<script setup>
import { ref, onMounted } from "vue";
import { usePiniaStore } from '@/store';
import BarcodeComponent from "../reusableComponent/BarcodeComponent.vue";
import DateComponent from '../reusableComponent/DateComponent.vue';
import BranchComponent from "../reusableComponent/BranchComponent.vue";
// import ProductTypeComponent from "../reusableComponent/ProductTypeComponent.vue";
import ProductComponent from "../reusableComponent/ProductComponent.vue";
import CustomerComponent from "../reusableComponent/CustomerComponent.vue";
import CartComponent from "./CartComponent.vue";
import PaymentComponent from "./PaymentComponent.vue";
import NoteComponent from "../reusableComponent/NoteComponent.vue";
import alert from "../../alert";
import confirmAlert from "../../confirmAlert";

const store = usePiniaStore()

const props = defineProps({
    oldSale: {
        type: Object
    },
})
let from = ref('sale');
let barcode = ref(null)
let date = ref(null)
let branch = ref(null)
let type = ref(null)
let customer = ref(null)
let payment = ref(null)
let note = ref(null)
let disabledSaleButton = ref(false)

const sale = () => {
    let text = props.oldSale ? 'You want to update this sale!' : 'You want to sale this!';
    confirmAlert(text).then((result) => {
        if (result.isConfirmed) {
            saveSale()
        }
    })
}

const saveSale = () => {
    let toast = alert()
    if (store.cartProducts.length <= 0) {
        alert().fire({
            icon: 'warning',
            title: 'Cart is empty!'
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

    if (!customer.value.selectedCustomer && !customer.value.name) {
        toast.fire({
            icon: 'error',
            title: 'Please select customer!'
        })
        return
    }

    let form = new FormData();
    form.append('date', date.value.date);
    form.append('branch_id', store.branchId);
    form.append('customer_type', customer.value.customerType);
    if (customer.value.selectedCustomer) {
        form.append('party_id', customer.value.selectedCustomer.id);
    }else{
        form.append('name', customer.value.name);
        form.append('phone', customer.value.phone);
        form.append('address', customer.value.address);
    }
    form.append('note',  note.value.note);

    //from payment
    form.append('previous_balance', customer.value.customerBalance);
    form.append('subtotal', payment.value.subtotal);
    form.append('discount', payment.value.discount || 0);
    form.append('labour_cost', payment.value.labourCost || 0);
    form.append('transport_cost', payment.value.transportCost || 0);
    form.append('grand_total', payment.value.grandTotal);
    form.append('paid', payment.value.paid || 0);
   if (payment.value.partyRemainingBalance > 0) {
        form.append('due', payment.value.partyRemainingBalance);
        form.append('change', 0);
        form.change = 0;
    } else {
        form.append('change', Math.abs(payment.value.partyRemainingBalance));
        form.append('due', 0);
    }
    form.append('payment_type', payment.value.payment_type);
    form.append('discount_type', payment.value.discount_type);
    form.append('cash_id', payment.value.cashId ?? '');
    form.append('bank_account_id', payment.value.bankAccountId ?? '');

    // let due = (parseFloat(payment.value.grandTotal) - parseFloat(payment.value.paid ?? 0))
    // due > 0 ? form.append('due', due) : form.append('due', 0)

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
            sale_price: product.sale_price,
            wholesale_price: product.wholesale_price,
            discount: product.discountAmount,
            discount_type: product.discountType,
            quantity_in_unit: product.quantity_in_unit,
            line_total: product.total_price,
        });
    });
    // disabledSaleButton.value = true

    if(quantityError) {
        products = []
        return
    }

    form.append('products', JSON.stringify(products))

    if (props.oldSale) {
        updateSale(form)
    }else{
        newSale(form)
    }
}

const newSale = (form) => {
    // form.append('_enctype', 'multipart/form-data')
    axios.post(baseURL+'/pos/sale', form)
        .then((response) => {
            // console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'Sale has been created successfully!'
            });
            setTimeout(() => {
             window.location.href = baseURL + "/pos/sale/" + response.data.id

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

const updateSale = (form) => {
    form.append('_method', 'PUT')
    axios.post(baseURL+'/pos/sale/'+ props.oldSale.id, form)
        .then((response) => {
            console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'Sale updated successfully!'
            });
            setTimeout(() => {
                window.location.href = baseURL + "/pos/sale/" + response.data.id

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
   if (props.oldSale) {
        store.$patch({
            oldSale: props.oldSale
        });
    }
}

onMounted( async () => {
    await store.loadAllProducts()
    initialValues()
})

</script>
