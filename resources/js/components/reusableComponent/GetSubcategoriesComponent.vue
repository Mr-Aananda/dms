<template>
    <div class="row">
        <div class="col-md-6">
            <label for="category" class="form-label required">Category</label>
            <Multiselect
                v-model="chosenCategory"
                :options="props.categories"
                @select="handleCategoryChange"
                label="name"
                track-by="name"
                placeholder=" -- Select a category -- "
                :close-on-select="true"
                :clear-on-select="false"
                :open-direction="'bottom'"
            />
            <input type="hidden" name="category_id" v-model="category_id">
            <div v-if="props.errors?.category_id" class="text-danger">
                <strong>{{ props.errors.category_id[0] }}</strong>
            </div>
        </div>
        <div class="col-md-6">
            <label for="subcategory" class="form-label">Subcategory</label>
            <Multiselect
                v-model="chosenSubcategory"
                :options="subcategories"
                label="name"
                track-by="name"
                placeholder="-- Select a subcategory --"
                :disabled="subcategories.length == 0"
                :close-on-select="true"
                :clear-on-select="false"
                :open-direction="'bottom'"
            />
            <input type="hidden" name="subcategory_id" v-model="subcategory_id">
            <div v-if="props.errors?.subcategory_id" class="text-danger">
                <strong>{{ props.errors.subcategory_id[0] }}</strong>
            </div>

        </div>
    </div>
</template>

<script setup>
import { onMounted, ref, watch } from "vue";

const props = defineProps({
    categories: {
        type: Array,
        required: true,
    },
    oldProduct: {
        type: Object,
    },
    oldExpense: {
        type: Object,
    },
    errors: {
        type: [Array, Object, null],
    },
    old_category_id: {
        type: [null, String],
    },
    old_subcategory_id: {
        type: [null, String],
    }
});


const chosenCategory = ref(null);
const chosenSubcategory = ref(null);
const category_id = ref(null);
const subcategory_id = ref(null);
const subcategories = ref([]);

const getSubcategoriesByCategory = () => {
    if (chosenCategory.value && chosenCategory.value.id) {
        const selectedCategory = props.categories.find((category) => category.id == chosenCategory.value.id);
        subcategories.value = selectedCategory ? selectedCategory.sub_category : [];
    } else {
    console.log("something went wrong");
   }

};

const handleCategoryChange = () => {
    chosenSubcategory.value = null;
    getSubcategoriesByCategory();
};

watch(chosenCategory, (category) => {
    getSubcategoriesByCategory();
    if (category && category.id) {
     category_id.value = category.id
    } else {
        console.log('No category is here');
   }
});

watch(chosenSubcategory, (subcategory) => {
  if (subcategory && subcategory.id) {
    subcategory_id.value = subcategory.id;
  } else {
    console.log('No subcategory is here');
  }
});

onMounted(() => {
    // console.log(props.oldExpense);
    if (props.oldProduct) {
        let categoryOb = props.categories.find((category) =>
            category.id == props.oldProduct.category_id
        );
        chosenCategory.value = categoryOb;

        getSubcategoriesByCategory();
        let subCategoryOb = subcategories.value.find((subcategory) =>
            subcategory.id == props.oldProduct.subcategory_id
        );

        chosenSubcategory.value = subCategoryOb;
    } else if(props.oldExpense) {
        let categoryOb = props.categories.find((category) =>
            category.id == props.oldExpense.expense_category_id
        );
        chosenCategory.value = categoryOb;

        getSubcategoriesByCategory();
        let subCategoryOb = subcategories.value.find((subcategory) =>
            subcategory.id == props.oldExpense.expense_subcategory_id
        );

        chosenSubcategory.value = subCategoryOb;

    }

    //for Old value
    if (props.old_category_id) {
        category_id.value = props.old_category_id
        getSubcategoriesByCategory()
        subcategory_id.value = props.old_subcategory_id
    }
});
</script>
