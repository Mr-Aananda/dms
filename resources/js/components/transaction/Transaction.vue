<template>
    <div>
        <form @submit.prevent="transaction()" method="POST">
            <div class="row">
                <div class="form-group col-md-6 pr-3">
                    <label for="date" class="required">Date</label>
                    <input type="date" v-model="date" class="form-control" id="date" required>
                </div>

                <div class="form-group col-md-6 pl-3">
                    <label for="amount" class="required">Amount</label>
                    <input type="number" v-model="amount" class="form-control" placeholder="0.00" id="amount" required>
                </div>
            </div>

            <div class="row mt-3">
                <!-- Transfer From -->
                <div class="col-md-6">
                    <div class="card border" style="background-color: #FFFFFF;">
                        <div class="card-header" style="background-color: #FFFFFF;">Transfer From </div>
                        <div class="card-body my-2">
                            <div class="form-group row">
                                <div class="col-sm-auto mb-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input"  style="font-size: 17px" type="radio" v-model="transaction_from" @click ="getFromTransactionType" id="from-cash" value="cash">
                                        <label class="form-check-label"  style="font-size: 17px" for="from-cash">Cash </label>
                                    </div>

                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input"  style="font-size: 17px" v-model="transaction_from" @click ="getFromTransactionType" type="radio" id="from-bank" value="bank">
                                        <label class="form-check-label"  style="font-size: 17px" for="from-bank">Bank </label>
                                    </div>
                                </div>
                            </div>

                            <!-- cash -->
                            <div class="row" v-if="transaction_from == 'cash'">
                                <div class="form-group col-md-12">
                                    <label class="required">Cash</label>
                                    <select v-model="from_cash_id" @change="getFromBalance" class="form-select" required>
                                        <option :value="null" selected disabled>Choose one</option>
                                        <option v-for="(cash, index) in props.cashes" :value="cash.id" :key="index">
                                            {{ cash.name }}
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <!-- bank -->
                            <div class="row" v-if="transaction_from == 'bank'">
                                <div class="form-group col-md-12">
                                    <label class="required">Bank Account</label>
                                    <select v-model="from_bank_id" @change="getFromBalance" class="form-select" required>
                                        <option :value="null" selected disabled>Choose one</option>
                                        <option v-for="(bank, index) in props.banks" :value="bank.id" :key="index">
                                            {{ bank.custom_name }}
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div v-if="fromBalance" class="col-12 mt-2">
                                <!-- cash balance start -->
                                <p class="d-block text-light p-1 px-2" :style="{ backgroundColor: '#0B93A8' }">{{ fromBalance }}</p>
                                <!-- cash balance end -->
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Transfer From -->
                <div class="col-md-6">
                    <div class="card border" style="background-color: #FFFFFF;">
                        <div class="card-header" style="background-color: #FFFFFF;">Transfer To</div>
                        <div class="card-body my-2">
                            <div class="form-group row">
                                <div class="col-sm-auto mb-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input"  style="font-size: 17px" type="radio" v-model="transaction_to" @click ="getToTransactionType" id="to-cash" value="cash">
                                        <label class="form-check-label"  style="font-size: 17px"  for="to-cash">Cash </label>
                                    </div>

                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input"  style="font-size: 17px" v-model="transaction_to" @click ="getToTransactionType" type="radio" id="to-bank" value="bank">
                                        <label class="form-check-label"  style="font-size: 17px" for="to-bank">Bank </label>
                                    </div>
                                </div>
                            </div>

                            <!-- cash -->
                            <div class="row" v-if="transaction_to == 'cash'">
                                <div class="form-group col-md-12">
                                    <label class="required">Cash</label>
                                    <select v-model="to_cash_id" @change="getToBalance" class="form-select" required>
                                        <option :value="null" selected disabled>Choose one</option>
                                        <option v-for="(cash, index) in props.cashes" :value="cash.id" :key="index">
                                            {{ cash.name }}
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <!-- bank -->
                            <div class="row" v-if="transaction_to == 'bank'">
                                <div class="form-group col-md-12">
                                    <label class="required">Bank Account</label>
                                    <select v-model="to_bank_id" @change="getToBalance" class="form-select" required>
                                        <option :value="null" selected disabled>Choose one</option>
                                        <option v-for="(bank, index) in props.banks" :value="bank.id" :key="index">
                                            {{ bank.custom_name }}
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div v-if="toBalance" class="col-12 mt-2">
                                <!-- cash balance start -->
                                <p class="d-block text-light p-1 px-2" :style="{ backgroundColor: '#0B93A8' }">{{ toBalance }}</p>
                                <!-- cash balance end -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row my-2">
                <div class="form-group col-md-12 pr-3">
                    <label>Note</label>
                    <textarea name="note" class="form-control" v-model="note" id="note" rows="3" placeholder="Optional"></textarea>

                </div>
            </div>
            <!-- Button start -->
            <div class="row my-3">
                <div class="col-12 text-end">
                    <button class="btn btn-danger me-2" type="reset"><i class="bi bi-stars"></i>Reset</button>
                    <button class="btn btn-success" type="submit"><i class="bi bi-download"></i>
                        {{ oldTransaction ? 'Update Transaction' : 'Create Transaction' }}
                    </button>
                </div>
            </div>
                <!-- Button end -->
        </form>
    </div>
</template>

<script setup>
import { onMounted, ref, watch } from 'vue';
import alert from "../../alert";
import confirmAlert from "../../confirmAlert";


const props = defineProps({
  banks: {
    type: Array
    },
  cashes: {
    type: Array
    },
  oldTransaction : {
    type: Object
    },
});

let date = ref(new Date().toISOString().substr(0, 10));
let amount = ref(0)
let transaction_from = ref('cash')
let transaction_to = ref('bank')
let transaction_from_id = ref(null)
let transaction_to_id = ref(null)
let note = ref(null)

let from_bank_id = ref(null)
let from_cash_id = ref(null)
let to_bank_id = ref(null)
let to_cash_id = ref(null)
let fromBalance = ref(null)
let toBalance = ref(null)

const getFromTransactionType = () => {
        from_cash_id.value = null;
        from_bank_id.value = null;
        fromBalance.value = null;
}
const getToTransactionType = () => {
        to_cash_id.value = null;
        to_bank_id.value = null;
        toBalance.value = null;
}

function getFromBalance() {
    if (from_cash_id.value) {
        fromBalance.value = props.cashes.find(cash => cash.id == from_cash_id.value).balance
    }else{
        fromBalance.value = props.banks.find(account => account.id == from_bank_id.value).balance
    }
}

function getToBalance() {
    if (to_cash_id.value) {
        toBalance.value = props.cashes.find(cash => cash.id == to_cash_id.value).balance
    }else{
        toBalance.value = props.banks.find(account => account.id == to_bank_id.value).balance
    }
}

const transaction = () => {
    confirmAlert('You want to transfer this').then((result) => {
        if (result.isConfirmed) {
            saveTransaction()
        }
    })
}

const saveTransaction = () => {
    if (from_cash_id.value) {
        transaction_from_id.value = from_cash_id.value;
    } else {
        transaction_from_id.value = from_bank_id.value;
    }

    if (to_cash_id.value) {
        transaction_to_id.value = to_cash_id.value;
    } else {
       transaction_to_id.value = to_bank_id.value;
    }

    if (!from_cash_id.value && !from_bank_id.value) {
        alert().fire({
            icon: 'warning',
            title: 'Please select from transfer method!'
        })
        return
    }

    if (!amount.value) {
        alert().fire({
            icon: 'warning',
            title: 'Enter amount!'
        });
        return;
    }

    if (!to_cash_id.value && !to_bank_id.value) {
        alert().fire({
            icon: 'warning',
            title: 'Please select to transfer method!'
        })
        return
    }

    let form = new FormData();

    //from basic input
    form.append('date', date.value);
    form.append('amount', amount.value);
    form.append('transaction_from', transaction_from.value);
    form.append('transaction_from_id', transaction_from_id.value);
    form.append('transaction_to', transaction_to.value);
    form.append('transaction_to_id', transaction_to_id.value);
    form.append('note', note.value);


    if (props.oldTransaction) {
        updateTransaction(form)
    }else{
        createTransaction(form)
    }
}

//Transaction Create
const createTransaction = (form) => {
   // console.log(form)
    axios.post(baseURL + '/pos/transaction', form)
    .then((response) => {

        console.log(response.data)
        alert().fire({
            icon: 'success',
            title: 'Transaction has been save successfully!'
        })

        setTimeout(() => {
         window.location.href = baseURL + "/pos/transaction";

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
};

//Transaction update
const updateTransaction = (form) => {
   form.append('_method', 'PUT')
    axios.post(baseURL+'/pos/transaction/'+ props.oldTransaction.id, form)
        .then((response) => {
            console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'Transaction has been save successfully!'
            })
            setTimeout(() => {
                window.location.href = baseURL + "/pos/transaction"

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
};

 const initialValues = () => {
    if (props.oldTransaction) {
        note.value = props.oldTransaction?.note == "null" ? "" : props.oldTransaction.note;
        amount.value = props.oldTransaction?.amount;
        date.value = props.oldTransaction?.formatted_date;
        transaction_from.value = props.oldTransaction?.transaction_from;
        transaction_to.value = props.oldTransaction?.transaction_to;

         if (props.oldTransaction.transaction_from == 'cash') {
                from_cash_id.value = props.oldTransaction.transaction_from_id
            }else{
                let where = 'from';
                getInitialBankDetails(props.oldTransaction, where)
            }
            if(props.oldTransaction.transaction_to == 'cash') {
                to_cash_id.value = props.oldTransaction.transaction_to_id
            }else{
                let where = 'to';
                getInitialBankDetails(props.oldTransaction, where)
            }
            getFromBalance()
            getToBalance()
        }
    };

    function getInitialBankDetails(oldTransaction, where) {
        if (where == 'to') {
            to_bank_id.value = oldTransaction.transaction_to_id
        }else{
            from_bank_id.value = oldTransaction.transaction_from_id
        }
    }

onMounted(() => {
        initialValues();
       console.log(props.oldTransaction);
    });

</script>

