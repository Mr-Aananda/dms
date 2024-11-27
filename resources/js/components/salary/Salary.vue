<template>
    <div>
        <form @submit.prevent="salary()" method="POST">
            <div class="row mb-2">
                <div class="col-md-12">
                    <label for="branch" class="form-label required">Select Employee</label>
                    <select name="employee_id" v-model="employee_id" id="branch" required class="form-select">
                        <option :value="null" disabled selected> -- Choose an employee --</option>
                        <option
                            v-for="(user, index) in props.users"
                            :value="user.id"
                            :key="index"
                            required

                            >
                            {{ user.name }}
                        </option>
                    </select>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-6">
                    <label for="salary_month" class="form-label required">Salary Month</label>
                    <input
                        type="month"
                        class="form-control"
                        name="salary_month"
                        v-model="salary_month"
                        id="salary_month"
                        required
                    />
                </div>
                <div class="col-md-6">
                    <label for="given_date" class="form-label required">Given Date</label>
                    <input
                        type="date"
                        class="form-control"
                        name="given_date"
                        v-model="given_date"
                        id="given_date"
                        required
                    />
                </div>
            </div>

            <div class="row mb-2">
                <div class="col-md-12">
                    <label for="basic_salary" class="form-label required">Basic Salary</label>
                    <input
                        type="number"
                        class="form-control"
                        name="basic_salary"
                        v-model="basic_salary"
                        step="any"
                        min="0"
                        id="basic_salary"
                        :placeholder="'Enter Amount'+' (' + 'BDT' +')'"
                        required
                    />
                </div>
            </div>

            <div v-if="advanced > 0" class="row mb-2">
                <div class="col-md-12">
                    <label for="advance" class="form-label">Advanced</label>
                    <input
                        type="number"
                        class="form-control"
                        :class="advanced > 0 ? 'border border-danger':''"
                        name="advanced"
                        v-model="advanced"
                        step="any"
                        min="0"
                        :placeholder="'Enter Advanced'+' (' + 'BDT' +')'"
                        id="advance"
                        readonly
                    />
                </div>
            </div>

            <div class="row mb-2">
                <div class="col-md-6">
                    <label for="bonus" class="form-label">Bonus</label>
                    <input
                        type="number"
                        class="form-control"
                        name="bonus"
                        v-model="bonus"
                        step="any"
                        min="0"
                        id="bonus"
                        :placeholder="'Enter Bonus'+' (' + 'BDT' +')'"
                    />
                </div>
                <div class="col-md-6">
                    <label for="deduction" class="form-label">Deduction</label>
                    <input
                        type="number"
                        class="form-control"
                        name="deduction"
                        v-model="deduction"
                        step="any"
                        min="0"
                        :placeholder="'Enter Deduction'+' (' + 'BDT' +')'"
                        id="deduction"
                    />
                </div>
            </div>

            <!-- Payment Method -->
            <payment-option-component ref="paymentOption" :old-salary = "props.oldSalary" />
            <!-- Note -->
            <note-component ref="note" :old-salary = "props.oldSalary"/>

            <!-- Button start -->
            <div class="row my-3">
                <div class="col-12 text-end">
                    <button class="btn btn-danger me-2" type="reset"><i class="bi bi-stars"></i>Reset</button>
                    <button class="btn btn-success" type="submit"><i class="bi bi-download"></i>
                        {{ props.oldSalary ? 'Update Salary' : 'Create Salary' }}
                    </button>
                </div>
            </div>
                <!-- Button end -->
        </form>
    </div>
</template>

<script setup>
import { onMounted, ref, watch } from 'vue';
import PaymentOptionComponent from './PaymentOptionComponent.vue';
import NoteComponent from '../reusableComponent/NoteComponent.vue';
import alert from "../../alert";
import confirmAlert from "../../confirmAlert";


const props = defineProps({
  oldSalary : {
    type: Object
    },
  users : {
    type: Array
    },
  userId : {
    type: [Number,String, null]
    },
  month : {
    type: [String, null]
    },
});

const employee_id = ref(null);
const given_date = ref(new Date().toISOString().substr(0, 10));

const salary_month = ref(null);

const basic_salary = ref(null);
const advanced = ref(null);
const bonus = ref(null);
const deduction = ref(null);


let paymentOption = ref(null)
let note = ref(null)


const salary = () => {
    confirmAlert('You want to create this').then((result) => {
        if (result.isConfirmed) {
            saveSalary()
        }
    })
}

const saveSalary = () => {

    // Validate form data
    if (!validateFormData()) {
        return;
    }

    const formData = {
    employee_id: employee_id.value,
    salary_month: salary_month.value + '-01',
    given_date: given_date.value,
    basic_salary: basic_salary.value,
    bonus: bonus.value,
    advanced:advanced.value,
    deduction:deduction.value,
    payment_method:paymentOption.value.payment_method,
    cash_id:paymentOption.value.cash_id,
    bank_account_id:paymentOption.value.bank_account_id,
    note:note.value.note,
  };


    if (props.oldSalary) {
        updateSalary(formData)
    }else{
        createSalary(formData)
    }
}

//Transaction Create
const createSalary = (formData) => {
    axios.post(baseURL + '/pos/salary', formData)
    .then((response) => {
        console.log(response.data);
        alert().fire({
            icon: 'success',
            title: 'Salary has been given successfully!'
        });
        setTimeout(() => {
            window.location.href = baseURL + "/pos/salary";
        }, 1000);
    })
    .catch((error) => {
        if (error.response && error.response.data && error.response.data.errors) {
            alert().fire({
            icon: 'error',
            title: error.response.data.errors ?? "Somthing went wrong !"
        });
        console.log(error.response.data.errors);
        } else {
            console.error(error);
            alert().fire({
                icon: 'error',
                title: error.response.data.message ?? "Somthing went wrong !"
            });
        }
    });
};


//Transaction update
const updateSalary = (formData) => {
   formData['_method'] = 'PUT';
    axios.post(baseURL+'/pos/salary/'+ props.oldSalary.id, formData)
        .then((response) => {
            console.log(response.data)
            alert().fire({
                icon: 'success',
                title: 'Salary has been updated successfully!'
            })
            setTimeout(() => {
                window.location.href = baseURL + "/pos/salary"
            }, 1000);
        })
        .catch((error) => {
        if (error.response && error.response.data && error.response.data.errors) {
            alert().fire({
            icon: 'error',
            title: error.response.data.errors ?? "Somthing went wrong !"
        });
        console.log(error.response.data.errors);
        } else {
            console.error(error);
            alert().fire({
                icon: 'error',
                title: error.response.data.message ?? "Somthing went wrong !"
            });
        }
    });
};


const validateFormData = () => {
  // Validate Party
  if (!employee_id.value) {
    alert().fire({
      icon: 'warning',
      title: 'Please select an employee!',
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

const getEmployeeDetails = (employeeId) => {
    const selectedUser = props.users.find(user => user.id == employeeId);
    let advancedDues = parseFloat(Math.abs(selectedUser.total_advanced_paid) - selectedUser.total_advanced_receive);

    if (!props.oldSalary) {
        advanced.value = advancedDues;
        // basic_salary.value = selectedEmployee.basic_salary;
    }
    // console.log(advancedDues);
}

watch(employee_id, (employeeId) => {
    if (employeeId) {
        getEmployeeDetails(employeeId);
    }
});

const initialValues = () => {
    if (props.oldSalary) {
        employee_id.value = props.oldSalary.employee_id;
        given_date.value = props.oldSalary.given_date;
        basic_salary.value = props.oldSalary.details.find(detail => detail.purpose == 'basic_salary')?.amount;
        bonus.value = props.oldSalary.details.find(detail => detail.purpose == 'bonus')?.amount;
        advanced.value = Math.abs(props.oldSalary.details.find(detail => detail.purpose == 'advanced')?.amount);
        deduction.value = Math.abs(props.oldSalary.details.find(detail => detail.purpose == 'deduction')?.amount);
    }
}

onMounted(() => {
    employee_id.value = props.userId ? Number(props.userId) : null;
    salary_month.value = props.month ? props.month : null;

    initialValues()

});

</script>


