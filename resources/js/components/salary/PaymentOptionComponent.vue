<template>
    <!-- Cash or Bank Radio -->
    <div class="col-12 mt-3">
        <label>
            <input
            class="form-check-input me-2"
            type="radio"
            @change="changePaymentDetails"
            name="pay_from"
            v-model="payment_method"
            value="cash"
            id="cash"
            style="font-size: 17px"
            />
            <span class="form-check-label me-3"  style="font-size: 17px">Cash</span>
        </label>

        <label>
            <input
            class="form-check-input me-2"
            type="radio"
            name="pay_from"
            @change="changePaymentDetails"
            id="bank"
            v-model="payment_method"
            value="bank"
             style="font-size: 17px"
            />
            <span class="form-check-label"  style="font-size: 17px">Bank</span>
        </label>
    </div>

    <!-- Cash Select -->
    <div v-if="payment_method == 'cash'" class="col-12 mt-3">
        <label for="cash_id" class="form-label required"> Select Cash</label>
        <select v-model="cash_id" id="cash_id" required class="form-select">
            <option :value="null">Choose cash</option>
            <option v-for="(cash, index) in store.cashes" :value="cash.id" :key="index">{{ cash.name }}</option>
        </select>
    </div>
    <!-- Cash Balance show -->
    <div v-if="cash_balance != null" class="col-12 mt-2">
        <p class="d-block text-light p-1 px-2" :style="{ backgroundColor: '#0B93A8' }">৳ {{ cash_balance }} BDT</p>
    </div>

    <div v-if="payment_method == 'bank'" class="row mt-3">
        <!-- Bank select start -->
        <div  class="col-6">
            <label for="bank_id" class="form-label required"> Select Bank</label>
            <select @change="getBankAccount" required v-model="bank_id" id="bank_id" class="form-select">
                <option :value="null">Choose one</option>
                <option v-for="(bank, index) in store.banks" :value="bank.id" :key="index">
                    {{ bank.name }}
                </option>
            </select>
        </div>
        <!-- Bank Account select start -->
        <div  class="col-6">
            <label for="bank_account_id" class="form-label required"> Select Account </label>
            <select required v-model="bank_account_id" id="bank_account_id" class="form-select">
                <option :value="null">Choose one</option>
                <option v-for="(bank_account, index) in bank_accounts" :value="bank_account.id" :key="index">
                    {{ bank_account.account_name }} ({{ bank_account.account_number }})
                </option>
            </select>
        </div>
        <!-- Check number input -->
         <!-- <div  class="col-4">
            <label for="check_number" class="form-label" >Check number</label>
            <input
                type="text"
                class="form-control"
                v-model="check_number"
                id="check_number"
                placeholder="Enter check no (Optional)"
            />
        </div> -->
        <!-- Bank Balance show -->
        <div v-if="bank_balance != null" class="col-12 mt-2">
            <p class="d-block text-light p-1 px-2" :style="{ backgroundColor: '#0B93A8' }">৳ {{ bank_balance }} BDT</p>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref, watchEffect } from 'vue';
import { usePiniaStore } from '@/store';

const store = usePiniaStore()


const props = defineProps({
    oldSalary: {
        type: Object
    },
});


const payment_method = ref('cash');

const cash_id = ref(null);
const bank_id = ref(null);
const bank_accounts = ref([]); // Define as a reactive ref
const bank_account_id = ref(null);
const cash_balance = ref(null);
const bank_balance = ref(null);
const check_number = ref(null);

watchEffect(() => {
  const cash = store.cashes.find(cash => cash.id == cash_id.value);
  if (cash) {
    cash_balance.value = cash.balance;
    bank_balance.value = null;
  }
});

watchEffect(() => {
    const bank_account = bank_accounts.value?.find(account => account.id == bank_account_id.value);
  if (bank_account) {
    bank_balance.value = bank_account.balance;
    cash_balance.value = null;
  }
});


const changePaymentDetails = () => {
  cash_id.value = null;
  cash_balance.value = null;
  bank_account_id.value = null;
  bank_balance.value = null;
};

const getBankAccount = () => {
    const selectedBank = store.banks.find(bank => bank.id == bank_id.value);
    if (selectedBank) {
        bank_accounts.value = selectedBank.bank_accounts;
        cash_id.value = null;
        cash_balance.value = null;
        bank_account_id.value = null;
        bank_balance.value = null;
    }
};

defineExpose({
    payment_method,
    cash_id,
    bank_id,
    bank_account_id,
    // check_number
})

const initialValues =  () => {
    if (props.oldSalary.cash_id) {
        payment_method.value = 'cash'
        cash_id.value = props.oldSalary.cash_id
    }else{
        payment_method.value = 'bank'
        bank_id.value = props.oldSalary.bank_account.bank_id
        getBankAccount()
        bank_account_id.value = props.oldSalary.bank_account_id
        check_number.value = props.oldSalary.check_number
    }
}

onMounted( async () => {
    await store.loadAllBanks()
    await store.loadAllBankAccounts()
    await store.loadAllCashes()
    if (props.oldSalary) {
        initialValues()
    }

});
</script>
