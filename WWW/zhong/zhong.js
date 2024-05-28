function toggleNavigation() {
    let nav = document.querySelector("nav");
    let nav_state = ("true"==nav.getAttribute("data-nav"));
    nav.setAttribute("data-nav",!nav_state);

    let main = document.querySelector("main");
    main.setAttribute("data-nav",!nav_state);
}