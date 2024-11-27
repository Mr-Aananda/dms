
<script>
    // Start checkbox all check function
function checkAll(event, input) {
    for (var i = 0; i < input.length; i++) {
        if (event.target.checked) {
            input[i].checked = true;
        } else {
            input[i].checked = false;
        }
    }

}
// End checkbox all check function

// Print
function printable(area) {
    var printContents = document.getElementById(area).innerHTML, // get printable content
        originalContents = document.body.innerHTML; // get document content
    // make a temporary document for printable content
    document.body.innerHTML = printContents;
    window.print(); // print the current document

    // restore the original document
    document.body.innerHTML = originalContents;
}

// Show password
function show(event, password) {
    let type = password.getAttribute("type");
    let eye = event.currentTarget.childNodes[0];
    if (type === "password") {
        password.type = "text";
        eye.classList.add("bi-eye-slash-fill");
        eye.classList.remove("bi-eye-fill");
    } else {
        password.type = "password";
        eye.classList.remove("bi-eye-slash-fill");
        eye.classList.add("bi-eye-fill");
    }
}
// CapsLock
function capsLock(event) {
    if (event.getModifierState("CapsLock")) {
        document.getElementById("capsLockText").classList.add("d-block")
        document.getElementById("capsLockText").classList.remove("d-none")
    } else {
        document.getElementById("capsLockText").classList.add("d-none")
        document.getElementById("capsLockText").classList.remove("d-block")
    }
}

</script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

{{-- <script src="{{Vite::asset("resources/template/js/aside.js")}}"></script> --}}
{{-- <script src="{{Vite::asset("resources/template/js/chart.js")}}"></script> --}}
{{-- <script src="{{Vite::asset("resources/template/js/form.js")}}"></script> --}}
{{-- <script src="{{Vite::asset("resources/template/js/navigation.js")}}"></script> --}}
{{-- <script src="{{Vite::asset("resources/template/js/table.js")}}"></script> --}}
{{-- <script src="{{Vite::asset("resources/template/js/utilities.js")}}"></script> --}}

