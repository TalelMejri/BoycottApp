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