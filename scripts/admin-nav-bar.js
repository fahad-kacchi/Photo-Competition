function showAdminNavBar(activeTabName){
    var dashboardTab = "";
    var addNewThemeTab = "";
    var adminThemeHomePageTab = "";
    var checkCompetitionResponseTab = "";
    
    switch(activeTabName){
        case "DASHBOARD":
            dashboardTab = "active";
            break;
        case "ADD_NEW_THEME":
            addNewThemeTab = "active";
            break;
        case "ADMIN_THEME_HOME_PAGE":
            adminThemeHomePageTab = "active";
            break;
        case "COMPETITION_RESPONSE":
            checkCompetitionResponseTab = "active";
            break;
    }
    
    var navBar = ""+
    "<nav class=\"navbar navbar-expand-lg navbar-dark navbar-dark unique-color\">"+
			"<button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#basicExampleNav\" aria-controls=\"basicExampleNav\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">"+
			"<span class=\"navbar-toggler-icon\">"+"</span>"+
			"</button>"+
			"<div class=\"collapse navbar-collapse\" id=\"basicExampleNav\">"+
				"<ul class=\"navbar-nav mr-auto\">"+
					"<li class=\"nav-item "+dashboardTab+"\">"+
                        "<a class=\"nav-link\" href=\"admin-dashboard.html\">Dashboard"+
                            "<span class=\"sr-only\">(current)</span>"+
                        "</a>"+
                    "</li>"+
                    "<li class=\"nav-item "+addNewThemeTab+"\">"+
                        "<a class=\"nav-link\" href=\"admin-add-theme.html\">Add New Theme</a>"+
                    "</li>"+
                    "<li class=\"nav-item "+adminThemeHomePageTab+"\">"+
                        "<a class=\"nav-link\" href=\"admin-theme-home-page.html\">Theme</a>"+
                    "</li>"+
                    "<li class=\"nav-item "+checkCompetitionResponseTab+"\">"+
                        "<a class=\"nav-link\" href=\"admin-check-competition-response.html\">Competition Response</a>"+
                    "</li>"+
				"</ul>"+
                "<span class=\"white-text\">"+
                    "<ul class=\"navbar-nav mr-auto\">"+
                        "<li class=\"nav-item\">"+
                            "<a class=\"nav-link\" href=\"index.html\">Logout</a>"+
                        "</li>"+
                    "</ul>"+
                "</span>"+
			"</div>"+
		"</nav>";
    document.getElementById("nav-bar-id").innerHTML = navBar;
}