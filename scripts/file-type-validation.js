function selectedFile(originalFile, adminOrUser) {
	if(checkTypeOfFile(originalFile.value)){
        if(adminOrUser == "ADMIN"){
            uploadPhoto();
        } else {
            registerCompetitorUploadPhoto();
        }
	} else {
		alert("Invalid file");
	}
}
     
function checkTypeOfFile(fileName) {
	var extension = fileName.split(".")[1];
	var flag = false;
	if(extension.toLowerCase() == "jpg" || extension.toLowerCase() == "png" || extension.toLowerCase() == "jpeg"){
		flag = true;
	}
	return flag;
}

function uploadPhoto(){
    xmlhttp = new XMLHttpRequest();
    var imageFile = document.photoCompForm.myPhoto.files[0];
    var fileName = imageFile.name;

    var formData = new FormData();
    formData.append("file", imageFile);
    xmlhttp.open("POST","/photo-competition/jsp-pages/upload-photo.jsp?fileName="+fileName,false);
    xmlhttp.send(formData);
    output = xmlhttp.responseText;
    document.getElementById("photoStatus").innerHTML = ""+output;
}

function registerCompetitorUploadPhoto(){
    xmlhttp = new XMLHttpRequest();
    var imageFile = document.photoCompForm.myPhoto.files[0];
    var fileName = imageFile.name;
    var loginId = getURL().split("=")[1];
    
    var formData = new FormData();
    formData.append("file", imageFile);
    xmlhttp.open("POST","/photo-competition/jsp-pages/register-competitor-upload-photo.jsp?loginId="+loginId+"&fileName="+fileName,false);
    xmlhttp.send(formData);
    output = xmlhttp.responseText;
    document.getElementById("photoStatus").innerHTML = ""+output;
}

function getURL(){
	var URL = window.location.href;
	var splitURLByQuestionMark = URL.split("?");
	return splitURLByQuestionMark[1];
}