function showCompetitionResponse(loginId){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/photo-competition/jsp-pages/show-competition-response.jsp",false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    document.getElementById("show-competition-response-id").innerHTML = output;
}