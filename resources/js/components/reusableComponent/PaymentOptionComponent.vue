<template>
    <!-- Cash or Bank Radio -->
    <div class="mt-2">
        <label>
            <input
            class="form-check-input me-2"
            type="radio"
            @change="changePaymentDetails"
            name="pay_from"
            v-model="payment_method"
            value="cash"
            id="cash"
            style="font-size: 18px"
            />
            <span class="form-check-label me-3" style="font-size: 18px">Cash</span>
        </label>

        <label>
            <input
            class="form-check-input me-2"
            type="radio"
            name="pay_from"
            @change="changePaymentDetails"
            id="bank"
            v-model="payment_method"
            value="bank_account"
            style="font-size: 18px"
            />
            <span class="form-check-label" style="font-size: 18px">Bank</span>
        </label>
    </div>

    <input type="hidden" name="payment_method" v-model="payment_method">
    <input type="hidden" name="transactionable_id" v-model="transactionable_id">


    <!-- Cash Select -->
    <div v-if="payment_method == 'cash'" class="col-12 mt-3">
        <label for="cash_id" class="form-label required"> Select Cash</label>
        <select v-model="cash_id" id="cash_id" required class="form-select">
            <option :value="null">Choose cash</option>
            <option v-for="(cash, index) in store.cashes" :value="cash.id" :key="index">{{ cash.name }}</option>
        </select>
        <div
            v-if="props.errors.transactionable_id"
            class="text-danger"
        >
            <strong>{{ props.errors.transactionable_id.join(', ') }}</strong>
        </div>
    </div>
    <!-- Cash Balance show -->
    <div v-if="cash_balance != null" class="col-12 mt-2">
        <p class="d-block text-light p-1 px-2" :style="{ backgroundColor: '#0B93A8' }">৳ {{ cash_balance }} BDT</p>
    </div>

    <div v-if="payment_method == 'bank_account'" class="row mt-3">
        <!-- Bank select start -->
        <div  class="col-6">
            <label for="bank_id" class="form-label required"> Select Bank</label>
            <select @change="getBankAccount" v-model="bank_id" id="bank_id" class="form-select" required>
                <option :value="null">Choose one</option>
                <option v-for="(bank, index) in store.banks" :value="bank.id" :key="index">
                    {{ bank.name }}
                </option>
            </select>
        </div>
        <!-- Bank Account select start -->
        <div  class="col-6">
            <label for="bank_account_id" class="form-label required"> Select Account </label>
            <select v-model="bank_account_id" id="bank_account_id" class="form-select" required>
                <option :value="null">Choose one</option>
                <option v-for="(bank_account, index) in bank_accounts" :value="bank_account.id" :key="index">
                    {{ bank_account.account_name }} ({{ bank_account.account_number }})
                </option>
            </select>
            <!-- <div
                v-if="form.errors.bank_account_id"
                class="text-danger"
            >
                {{ form.errors.bank_account_id }}
            </div> -->
        </div>
        <!-- Bank Balance show -->
        <div v-if="bank_balance != null" class="col-12 mt-2">
            <p class="d-block text-light p-1 px-2" :style="{ backgroundColor: '#0B93A8' }">৳ {{ bank_balance }} BDT</p>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref, watchEffect,watch } from 'vue';
import { usePiniaStore } from '@/store';

const store = usePiniaStore()


const props = defineProps({
    oldExpense: {
        type: Object,
    },
    oldLoan: {
        type: Object,
    },
    oldLoanInstallment: {
        type: Object,
    },
    oldIncomeRecord: {
        type: Object,
    },
    oldWithdraw: {
        type: Object,
    },
    oldInvest: {
        type: Object,
    },
    errors: {
        type: [Array, Object, null],
    },
});


const payment_method = ref('cash');

const cash_id = ref(null);
const bank_id = ref(null);
const bank_accounts = ref([]); // Define as a reactive ref
const bank_account_id = ref(null);
const cash_balance = ref(null);
const bank_balance = ref(null);
const transactionable_id = ref(null);

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

watch(cash_id, (currentId) => {
    if (currentId) {
        transactionable_id.value = currentId;
    }

});
watch(bank_account_id, (currentId) => {
    if (currentId) {
        transactionable_id.value = currentId;
    }
});

const initialValues = () => {
    if (props.oldExpense) {
        payment_method.value = props.oldExpense.payment_method;
        if (props.oldExpense.payment_method == 'cash') {
            cash_id.value = props.oldExpense.transactionable_id;
            bank_id.value = null;
            bank_account_id.value = null;
        } else {
            bank_id.value = props.oldExpense.transactionable.bank_id;
            getBankAccount();
            bank_account_id.value = props.oldExpense.transactionable_id;
            cash_id.value = null;
        }
    }

    if (props.oldLoan) {
        payment_method.value = props.oldLoan.payment_method;
        if (props.oldLoan.payment_method == 'cash') {
            cash_id.value = props.oldLoan.transactionable_id;
            bank_id.value = null;
            bank_account_id.value = null;
        } else {
            bank_id.value = props.oldLoan.transactionable.bank_id;
            getBankAccount();
            bank_account_id.value = props.oldLoan.transactionable_id;
            cash_id.value = null;
        }
    }
    if (props.oldLoanInstallment) {
        payment_method.value = props.oldLoanInstallment.payment_method;
        if (props.oldLoanInstallment.payment_method == 'cash') {
            cash_id.value = props.oldLoanInstallment.transactionable_id;
            bank_id.value = null;
            bank_account_id.value = null;
        } else {
            bank_id.value = props.oldLoanInstallment.transactionable.bank_id;
            getBankAccount();
            bank_account_id.value = props.oldLoanInstallment.transactionable_id;
            cash_id.value = null;
        }
    }
    if (props.oldIncomeRecord) {
        payment_method.value = props.oldIncomeRecord.payment_method;
        if (props.oldIncomeRecord.payment_method == 'cash') {
            cash_id.value = props.oldIncomeRecord.transactionable_id;
            bank_id.value = null;
            bank_account_id.value = null;
        } else {
            bank_id.value = props.oldIncomeRecord.transactionable.bank_id;
            getBankAccount();
            bank_account_id.value = props.oldIncomeRecord.transactionable_id;
            cash_id.value = null;
        }
    }
    if (props.oldWithdraw) {
        payment_method.value = props.oldWithdraw.payment_method;
        if (props.oldWithdraw.payment_method == 'cash') {
            cash_id.value = props.oldWithdraw.transactionable_id;
            bank_id.value = null;
            bank_account_id.value = null;
        } else {
            bank_id.value = props.oldWithdraw.transactionable.bank_id;
            getBankAccount();
            bank_account_id.value = props.oldWithdraw.transactionable_id;
            cash_id.value = null;
        }
    }
    if (props.oldInvest) {
        payment_method.value = props.oldInvest.payment_method;
        if (props.oldInvest.payment_method == 'cash') {
            cash_id.value = props.oldInvest.transactionable_id;
            bank_id.value = null;
            bank_account_id.value = null;
        } else {
            bank_id.value = props.oldInvest.transactionable.bank_id;
            getBankAccount();
            bank_account_id.value = props.oldInvest.transactionable_id;
            cash_id.value = null;
        }
    }
}

onMounted(async () => {
    // console.log(props.errors);
    await store.loadAllBanks()
    await store.loadAllBankAccounts()
    await store.loadAllCashes()

    initialValues()
});
</script>
