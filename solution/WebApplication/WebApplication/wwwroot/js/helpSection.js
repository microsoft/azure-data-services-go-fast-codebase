
function toggleHelpVisibility() {

    const help = document.getElementById("helpSection");
    const body = document.getElementById("mainBody");
    
    if (help.classList.contains('dismiss')) {
        help.classList.replace("dismiss", "selected");
        body.classList.replace("col-12", "col-9");
        help.style.display = "block";
    } else {        
        help.classList.replace("selected", "dismiss");    
        
        setTimeout(() => {
            body.classList.replace("col-9", "col-12");
            help.style.display = "none";
        }, 300)
    }
    
}
