import { usePiniaStore } from "./index";
import state from "./state";

export default {
    async loadAllBranches() {
        const url = `${baseURL}/utility/get-all-branches`;
        const response = await axios.get(url);

        const store = this.store();
        store.$patch((state) => {
            state.branches = response.data;
        });
    },
    async loadBranchIdFromUser() {
        const url = `${baseURL}/utility/get-branchId`;
        const response = await axios.get(url);
        // console.log(response.data);
        const store = this.store();
        store.$patch((state) => {
            state.branchId = response.data;
        });
    },
    async getAdminRule() {
        const url = `${baseURL}/utility/get-admin-rule`;
        const response = await axios.get(url);

        const store = this.store();
        store.$patch((state) => {
            state.isAdmin = response.data?.isAdmin;
        });
    },
    async loadAllProducts() {
        const url = `${baseURL}/utility/get-all-products`;
        const response = await axios.get(url);

        const store = this.store();
        store.$patch((state) => {
            state.products = response.data;
        });
    },
    async loadAllSuppliers() {
        const url = `${baseURL}/utility/get-all-suppliers`;
        const response = await axios.get(url);

        const store = this.store();
        store.$patch((state) => {
            state.suppliers = response.data;
        });
    },
    async loadAllCustomers() {
        const url = `${baseURL}/utility/get-all-customers`;
        const response = await axios.get(url);

        const store = this.store();
        store.$patch((state) => {
            state.customers = response.data;
        });
    },

    async loadAllBanks() {
        const url = `${baseURL}/utility/get-all-banks`;
        const response = await axios.get(url);

        const store = this.store();
        store.$patch((state) => {
            state.banks = response.data;
        });
    },

    async loadAllBankAccounts() {
        const url = `${baseURL}/utility/get-all-bank-accounts`;
        const response = await axios.get(url);

        const store = this.store();
        store.$patch((state) => {
            state.bankAccounts = response.data;
        });
    },

    async loadAllCashes() {
        const url = `${baseURL}/utility/get-all-cashes`;
        const response = await axios.get(url);

        const store = this.store();
        store.$patch((state) => {
            state.cashes = response.data;
        });
    },

    store() {
        return usePiniaStore();
    },
};
