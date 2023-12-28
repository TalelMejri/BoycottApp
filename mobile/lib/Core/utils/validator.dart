String? validateName(value){
  if (value!.isEmpty) {
    return 'Please enter your name';
  }else if (!RegExp(
    r"(?=.{4,})",
  ).hasMatch(value)) {
    return "Name must be at least 4 characters long";
  } 
  return null;
}


String? validateDescription(value){
  if (value!.isEmpty) {
    return 'Please enter your Description';
  }else if (!RegExp(
    r"(?=.{7,})",
  ).hasMatch(value)) {
    return "Name must be at least 7 characters long";
  } 
  return null;
}