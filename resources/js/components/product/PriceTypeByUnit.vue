<template>
    <div :class="{'col-md-6': !showStockInput, 'col-md-4': showStockInput}">
        <label for="unit" class="form-label required mt-1">Unit</label>
        <select name="unit_id" v-model="unit_id" required @change="getUnitDetails" id="unit" class="form-select">
            <option :value="null" disabled> --Select unit-- </option>
            <option v-for="(unit, unit_index) in props.units" :value="unit.id" :key="unit_index">{{ unit.name + ' (' + unit.description + ')' }}</option>
        </select>
        <div v-if="props.errors?.unit_id" class="text-danger">
            <strong>{{ props.errors.unit_id[0] }}</strong>
        </div>
    </div>
    <div :class="{'col-md-6': !showStockInput, 'col-md-4': showStockInput}">
        <label for="price_type" class="form-label required">Price Type</label>
        <select v-model="price_type" name="price_type" id="price_type" class="form-select" required>
            <option :value="null" disabled>--Select price type--</option>
            <option v-for="(label, index) in unitLabels" :value="index" :key="index">{{ label }}</option>
        </select>
        <div v-if="props.errors?.price_type" class="text-danger">
            <strong>{{ props.errors.price_type[0] }}</strong>
        </div>
    </div>
    <div class="col-md-4" v-if="showStockInput">
        <label for="stock_alert" class="form-label mt-1">Stock Alert</label>
        <div class="input-group">
            <input
                type="number"
                id="stock_alert"
                aria-describedby="quantityError"
                v-for="(label, labelIndex) in unitLabels"
                :placeholder="label"
                :key="labelIndex"
                v-model="quantity_in_unit[labelIndex]"
                name="quantity_in_unit[]"
                @blur="addStockAlertQuantity($event, labelIndex)"
                @change="addStockAlertQuantity($event, labelIndex)"
                @keyup="addStockAlertQuantity($event, labelIndex)"
                min="0"
                class="form-control form-control"
            />
        </div>
        <!-- <input type="hidden" name="quantity_in_unit[]" :value="quantity_in_unit"> -->
        <input type="hidden" name="stock_alert" v-model="stock_alert" >
    </div>
</template>

<script setup>
import {ref, watch, onMounted } from 'vue';
import lowestConverter from "@/ConvertToLowestUnit";

const props = defineProps({
  units: {
    type: Array,
    default: () => []
  },
  oldProduct: {
    type: Object,
    },
    errors: {
        type: [Array, Object, null],
    },
    old_unit_id: {
        type: [null, String],
    },
    old_price_type: {
        type: [null, String],
    },
    old_stock_alert: {
        type: [null, String],
    },
    old_quantity_in_unit: {
        type: [null, String, Array],
    },
});

const unit_id = ref(null);
const unit = ref({});
const price_type = ref(null);
const stock_alert = ref(null);
const unitLabels = ref([]);
const quantity_in_unit = ref([]);
const showStockInput = ref(false); // Initialize it as false initially

// Function to get unit details
const getUnitDetails = () => {
  if (unit_id.value !== null) {
    const selectedUnit = props.units.find(unit => unit.id == parseInt(unit_id.value));
    if (selectedUnit) {
        unit.value = selectedUnit;
        showStockInput.value = true; // Show the stock input when a unit is selected

        const unitRelation = selectedUnit.relation.split('/');

         let _quantity = [];
            for (let i = 0; i < unitRelation.length; i++) {
                _quantity[i] = null
            }
        quantity_in_unit.value = _quantity;


    } else {
      unit.value = {};
      showStockInput.value = false; // Hide the stock input if a unit is not found
    }
  } else {
    unit.value = {};
    showStockInput.value = false; // Hide the stock input when no unit is selected
  }
};

const addStockAlertQuantity = (event, order) => {
    quantity_in_unit.value[order] = event.target.value ? event.target.value : null;
    stock_alert.value = lowestConverter(quantity_in_unit.value, unit.value.relation);
    // console.log(stock_alert.value);
};

// Watcher for unit changes
watch(unit, (value) => {
  if (Object.keys(value).length !== 0) {
    unitLabels.value = value.label.split('/');
  } else {
    unitLabels.value = [];
  }
}, { deep: true });

const initialValues = () => {
    console.log(props.oldProduct);
  if (props.oldProduct) {
    unit_id.value = props.oldProduct.unit_id;
    getUnitDetails();
    price_type.value = props.oldProduct.price_type;
    // const splitValues = props.oldProduct.quantity_in_unit[0].split(',');
    // quantity_in_unit.value = splitValues.map(value => parseInt(value)); // Convert to integers if needed
    quantity_in_unit.value = Object.assign({}, props.oldProduct.quantity_in_unit);
    stock_alert.value = props.oldProduct.stock_alert;
  }
};

// Set initial values when the component is mounted
onMounted(() => {
  initialValues()
    if (props.old_unit_id) {
        unit_id.value = props.old_unit_id
        getUnitDetails();
        price_type.value = props.old_price_type
        // const splitValues = props.old_quantity_in_unit[0].split(',');
        // quantity_in_unit.value = splitValues.map(value => parseInt(value));
        quantity_in_unit.value = Object.assign({}, props.oldProduct.quantity_in_unit);
        stock_alert.value = props.old_stock_alert;
    }

})
</script>
