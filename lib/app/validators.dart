String? nameValidator(String? value) {
  if (value == null) {
    return null;
  }
  if (value.isNotEmpty && value.trim().length < 3) {
    return "minimum 3 characters required";
  } else if (value.isEmpty) {
    return 'required';
  } else {
    return null;
  }
}

String? emailValidator(String? value) {
  if (value == null) {
    return null;
  }
  if (value.isNotEmpty && value.trim().length < 3) {
    return 'Enter a valid Email';
  } else if (value.isEmpty) {
    return 'required';
  } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
    return 'Not a valid email';
  } else {
    return null;
  }
}

String? phoneValidator(String? value){
  if(value == null){
    return null;
  }
  if(value.isEmpty){
    return 'required';
  }else if(!RegExp('^(?:[+0]9)?[0-9]{10}\$').hasMatch(value)){
    return 'Noa a valid Phone Number';
  }else{
    return null;
  }
}
String? dobValidator(String? value){
  if(value == null){
    return null;
  }if(value.isEmpty){
    return 'required';
  }else if(value == 'No date selected'){
    return 'date required';
  }else{
    return null;
  }
}