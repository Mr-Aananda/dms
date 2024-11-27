// bootstrap application with required js dependency
import "./bootstrap";

import "./registerVueComponents";
// import "../template/js/aside"
import "../template/js/navigation";
import "../template/js/utilities";

// import.meta.glob(["../template**"]);

import.meta.glob([
    "../template/assets/images/**",
    // '../fonts/**',
    "../template/assets/icons/**",
]);

$(document).on("select2:open", () => {
    document.querySelector(".select2-search__field").focus();
});


