// Aside expand function ==============================================>
function expandFunction() {
    let pageAside = document.getElementById("left-aside")
    let asideLayer = document.getElementById("aside-layer")
    let mainBar = document.getElementById("main-bar")

    pageAside.classList.toggle("expand")
    asideLayer.classList.toggle("show")
    mainBar.classList.toggle("main-bar-expand")
}


// aside menu active function ==============================================>
function asideMenuActiveFanction() {
    let activeMenu = document.getElementById('is-menu-active');
    if (activeMenu) {
        if (activeMenu && activeMenu.className == 'sigle-nav-link') {
            activeMenu.classList.add("active")
        } else if(activeMenu && activeMenu.className == 'nav-link'){

            activeMenu.classList.add("active")
            activeMenu.closest('.collapse').classList.add('show')
            activeMenu.closest('.collapse').previousElementSibling.classList.remove('collapsed')
        }
    } else {
        null
    }
}
asideMenuActiveFanction();
