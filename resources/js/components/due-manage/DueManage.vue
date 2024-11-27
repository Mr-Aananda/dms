<template>
   <form @submit.prevent="dueManage">
        <!-- Date -->
        <date-component ref="date" class="col-10" :old-due-manage = "props.oldDueManage"/>

        <!-- Party -->
        <party-component ref="party" :old-due-manage = "props.oldDueManage" :party-type ="props.partyType"/>

        <!-- Amount -->
        <amount-component ref="amountComponent" :old-due-manage = "props.oldDueManage" :party-type ="props.partyType"/>
        <!-- Payment Method -->
        <payment-option-component ref="paymentOption" :old-due-manage = "props.oldDueManage" />
        <!-- Note -->
        <note-component ref="note" class="col-10" :old-due-manage = "props.oldDueManage"/>

        <div class="row my-3">
            <div class="col-10 text-end">
                <button class="btn btn-danger me-2" type="reset"><i class="bi bi-stars"></i>Reset</button>
                <button class="btn btn-success" type="submit" :disabled="disabledDueManageButton"><i class="bi bi-download"></i>
                    {{ oldDueManage ? 'Update' : 'Create' }}
                </button>
            </div>
        </div>
   </form>
</template>


<script setup>
import {onMounted,ref} from "vue";
import { usePiniaStore } from '@/store';
import DateComponent from '../reusableComponent/DateComponent.vue';
import NoteComponent from '../reusableComponent/NoteComponent.vue';
import AmountComponent from './AmountComponent.vue';
import PartyComponent from './PartyComponent.vue';
import PaymentOptionComponent from "./PaymentOptionComponent.vue";
import alert from "../../alert";
import confirmAlert from "../../confirmAlert";


const store = usePiniaStore()

const props = defineProps({
    oldDueManage: {
        type: Object
    },
    partyType: String,
})

let date = ref(null);
let party = ref(null);
let amountComponent = ref(null);
let paymentOption = ref(null);
let note = ref(null);
let disabledDueManageButton = ref(false);

const dueManage = () => {
    let text = props.oldDueManage ? 'You want to update this transaction!' : 'You want to transaction this!';
    confirmAlert(text).then((result) => {
        if (result.isConfirmed) {
            saveDueManage()
        }
    })
}

const saveDueManage = () => {
      // Validate form data
  if (!validateFormData()) {
    return;
  }

    if (amountComponent.value.paymentType == 'received') {
        amountComponent.value.amount = amountComponent.value.tempAmount;
    } else {
        amountComponent.value.amount = -1 * amountComponent.value.tempAmount;
    }

    // Prepare form data object
  const formData = {
    date: date.value.date,
    party_id: party.value.selectedParty.id,

    amount: amountComponent.value.amount,
    adjustment: amountComponent.value.adjustment,
    paymentType: amountComponent.value.paymentType,
    type:amountComponent.value.party_type,

    payment_method: paymentOption.value.payment_method,
    cash_id:paymentOption.value.cash_id,
    bank_id:paymentOption.value.bank_id,
    bank_account_id:paymentOption.value.bank_account_id,
    check_number:paymentOption.value.check_number,
    description:note.value.note,
  };
   if (props.oldDueManage) {
        updateDueManage(formData)
    }else{
        createDueManage(formData)
    }
};

const createDueManage = (formData) => {
    const endpoint = baseURL + (props.partyType == 'supplier' ? '/pos/supplier-due' : '/pos/customer-due');
    axios.post(endpoint, formData)
    .then(response => {
      // Handle successful response
      console.log(response.data);
       alert().fire({
          icon: 'success',
          title: 'Created successfully!',
       });
        if (props.partyType == 'supplier') {
             window.location.href = baseURL + "/pos/supplier-due";
        }
        else {
             window.location.href = baseURL + "/pos/customer-due";
        }
    })
    .catch(error => {
      // Handle error
      console.error(error);
      // Show error message if needed
        alert().fire({
          icon: 'error',
          title: 'An error occurred while submitting data!',
        });
    });

};

const updateDueManage = (formData) => {
  formData['_method'] = 'PUT';
  const endpoint = baseURL + (props.partyType == 'supplier' ? '/pos/supplier-due/' + props.oldDueManage.id : '/pos/customer-due/' + props.oldDueManage.id);
  axios
    .post(endpoint, formData)
    .then(response => {
      // Handle successful response
      console.log(response.data);
      alert().fire({
        icon: 'success',
        title: 'Updated successfully!',
      });
      if (props.partyType == 'supplier') {
        window.location.href = baseURL + "/pos/supplier-due";
      } else {
        window.location.href = baseURL + "/pos/customer-due/";
      }
    })
    .catch(error => {
      // Handle error
      console.error(error);
      // Show error message if needed
      alert().fire({
        icon: 'error',
        title: 'An error occurred while submitting data!',
      });
    });
};


const validateFormData = () => {
  // Validate Party
  if (!party.value.selectedParty) {
    alert().fire({
      icon: 'warning',
      title: 'Please select a party!',
    });
    return false;
  }

  // Validate Payment Method
  if (!paymentOption.value.payment_method) {
    alert().fire({
      icon: 'warning',
      title: 'Please select a payment method!',
    });
    return false;
  }

  // Validate Amount
  if (!amountComponent.value.tempAmount || amountComponent.value.tempAmount <= 0) {
    alert().fire({
      icon: 'warning',
      title: 'Please enter a valid amount!',
    });
    return false;
  }

  if (!paymentOption.value.cash_id && !paymentOption.value.bank_account_id) {
    alert().fire({
      icon: 'warning',
      title: 'Please select cash or bank!',
    });
    return false;
  }

  // If all validations pass, return true
  return true;
};


const initialValues = () => {
   if (props.oldSupplierDue) {
        store.$patch({
            oldSupplierDue: props.oldSupplierDue
        });
   }

}

onMounted(async () => {
    initialValues()
})
</script>
