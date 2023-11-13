function nameValidation(){
	var name = document.photoCompForm.name.value;
    var namePartition = name.split(" ");
    var partition = namePartition.length;
    
    if(partition == 2){
    } else if(partition == 3){
    } else {
        alert(" Please provide a valid name.");
        document.photoCompForm.name.value = "";
    }
}

function emailValidation(){
	var emailId = document.photoCompForm.email.value;
    var atpos = emailId.indexOf("@");
    var dotpos = emailId.lastIndexOf(".");
    if (atpos < 1 || dotpos < atpos+2 || dotpos+2 >= emailId.length) {
        alert("Not a valid e-mail address");
        document.photoCompForm.email.value = "";
        return false;
    }
}

function passwordValidation(){
	var password = document.photoCompForm.password.value;
	var confirmPassword = document.photoCompForm.confirmPassword.value;
	if(!(password === confirmPassword)){
		alert("Both password are not same!");
        document.photoCompForm.password.value = "";
        document.photoCompForm.confirmPassword.value = "";
    }
}
