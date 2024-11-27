<template>
  <div class="mb-3">
    <label for="name" class="form-label required">Name</label>
    <input
      type="text"
      class="form-control"
      name="name"
      v-model="name"
      id="name"
      placeholder="EX: Mon"
      required
      autofocus
    />
  </div>
  <div class="mb-3">
    <label for="label" class="form-label required">Label</label>
    <input
      type="text"
      class="form-control"
      name="label"
      v-model="label"
      id="label"
      placeholder="EX: Mon/Kg"
      required
    />
  </div>

  <div class="mb-3">
    <label v-if="relations.length > 0" for="relation" class="form-label required">Relation</label>
    <div v-for="(_relation, index) in relations" :key="index">
      <div class="input-group m-1">
        <span class="input-group-text bg-primary rounded-0 text-light">
          {{ _relation.parent }}
        </span>
        <input
            type="text"
            name="relation"
            id="relation"
            step="any"
            :value="unitRelation[index + 1]"
            @blur="addUnitRelation($event, index + 1)"
            @change="addUnitRelation($event, index + 1)"
            @keyup="addUnitRelation($event, index + 1)"
            :placeholder="'Enter ' + _relation.children"
            required
            class="form-control"
        />
        <span class="input-group-text rounded-0 bg-primary text-light">
          {{ _relation.children }}
        </span>
      </div>
    </div>
    <input type="hidden" id="relation" name="relation" v-model="relation"/>
  </div>

  <div class="mb-3">
    <label for="description" class="form-label required">Description</label>
    <textarea
      name="description"
      class="form-control"
      id="description"
      cols="30"
      v-model="description"
      placeholder="Ex: 1 Mon = 40 Kg"
      rows="3"
    ></textarea>
  </div>
  <div class="row mt-3">
    <div class="col-12 text-end">
      <button class="btn btn-danger me-2" type="reset"><i class="bi bi-stars"></i> Reset</button>
      <button class="btn btn-success" type="submit"><i class="bi bi-download"></i>
        {{ unit ? 'Update Unit' : 'Add Unit' }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';

const props = defineProps({
  unit: Object,
});

const name = ref(null);
const label = ref(null);
const relations = ref([]);
const unitRelation = ref([]);
const description = ref(null);
const relation = ref(null);

watch(label, (newLabel) => {
  getRelation();
}, { deep: true });

watch(unitRelation, (unitRelation) => {
  relation.value = unitRelation.join('/');
}, { deep: true });

const getRelation = () => {
  relations.value = [];
  if (!label.value) {
    alert("Label can't be empty");
    return;
  }
  let labels = label.value.split("/");
  for (let i = 0; i < labels.length; i++) {
    if (i == 0) {
      unitRelation.value[i] = 1;
    } else {
      unitRelation.value[i] = null;
    }
    if ((i + 1) < labels.length) {
        let data = {};
        data.parent = `1 ${labels[i]}`
        data.children = `${labels[i + 1]}`
        relations.value.push(data);
    }
  }
};

const addUnitRelation = (event, index) => {
  unitRelation.value[index] = event.target.value ? event.target.value : null;
};

const initialValues = async () => {
    // console.log(props.unit);
    if (props.unit) {
        name.value = props.unit.name;
        label.value = props.unit.label;
        relations.value = []; // Clear existing relations
        unitRelation.value = Array(props.unit.unit_labels.length).fill(null); // Initialize unitRelation with the correct length
        props.unit.unit_labels.forEach((label, index) => {
            if (index + 1 < props.unit.unit_labels.length) {
                let data = {};
                data.parent = `1 ${label}`;
                data.children = `${props.unit.unit_labels[index + 1]}`;
                relations.value.push(data);
            }
        });
        await getRelation(); // Wait for getRelation to finish
        unitRelation.value = props.unit.relation.split('/');
        description.value = props.unit.description;
    }
};

onMounted(() => {
    initialValues();
});

</script>

