import { createApp } from "vue/dist/vue.esm-bundler.js";
import { createPinia } from "pinia";
import Multiselect from "vue-multiselect";
import unit from "./components/unit/Unit.vue";
import getSubcategories from "./components/reusableComponent/GetSubcategoriesComponent.vue";
import paymentOptionComponent from "./components/reusableComponent/PaymentOptionComponent.vue";
import priceTypeByUnit from "./components/product/PriceTypeByUnit.vue";
import purchase from "./components/purchase/purchase.vue";
import purchaseReturn from "./components/purchaseReturn/PurchaseReturn.vue";
import sale from "./components/sale/Sale.vue";
import saleReturn from "./components/saleReturn/SaleReturn.vue";
import damage from "./components/damage/Damage.vue";
import dueManage from "./components/due-manage/DueManage.vue";
import production from "./components/production/Production.vue";
import productTransfer from "./components/product-transfer/ProductTransfer.vue";
import transaction from "./components/transaction/Transaction.vue";
import paymentOption from "./components/advanced-salary/PaymentOption.vue";
import salary from "./components/salary/Salary.vue";
import BarcodeSaleComponent from "./components/barcode/BarcodeSaleComponent.vue";
import StickerInvoiceComponent from "./components/barcode/StickerInvoiceComponent.vue";


const vueApp = createApp({});
const pinia = createPinia();

//Vue-Multiselect
vueApp.component("Multiselect", Multiselect);

// register component
//Unit
vueApp.component("unit", unit);
//Product
vueApp.component("getSubcategories", getSubcategories);
vueApp.component("priceTypeByUnit", priceTypeByUnit);
//Purchase
vueApp.component("purchase", purchase);
//Purchase-Return
vueApp.component("purchase-return", purchaseReturn);
//Sale
vueApp.component("sale", sale);
//Sale-return
vueApp.component("sale-return", saleReturn);
//Damage
vueApp.component("damage", damage);
//Due Manage
vueApp.component("due-manage", dueManage);
//Production
vueApp.component("production", production);
//Product Transfer
vueApp.component("product-transfer", productTransfer);
//Transaction
vueApp.component("transaction", transaction);
//Advanced salary
vueApp.component("payment-option", paymentOption);
// Salary
vueApp.component("salary", salary);
//expense, loan, loan installment
vueApp.component("payment-option-component", paymentOptionComponent);
vueApp.component("BarcodeSaleComponent", BarcodeSaleComponent);
vueApp.component("StickerInvoiceComponent", StickerInvoiceComponent);


vueApp.use(pinia);
// mount if exists vueRoot id
if (document.getElementById("vueRoot")) {
    vueApp.mount("#vueRoot");
}
