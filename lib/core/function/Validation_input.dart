String? validInput(String val, String field) {
  // List of dangerous characters
  final dangerousCharacters = r'[<>/\"%#$!()&+{}|~]';

  if (val.isEmpty) {
    return "$field can't be empty";
  } else if (field == 'Email') {
    if (val.length > 100) {
      return 'Email must be less than or equal to 100 characters';
    } else if (!val.contains('@')) {
      return 'A valid email address is required';
    } else if (RegExp(dangerousCharacters).hasMatch(val)) {
      return "Email contains dangerous characters";
    }
  } else if (field == 'Username') {
    if (val.length < 6 || val.length > 100) {
      return 'Username must be between 6 and 100 characters long';
    } else if (RegExp(dangerousCharacters).hasMatch(val)) {
      return "Username contains dangerous characters";
    }
  } else if (field == 'Password') {
    if (val.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (val.length > 100) {
      return 'Password must be less than or equal to 100 characters';
    } else if (!RegExp(r'(?=.*[a-z])').hasMatch(val)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(val)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'(?=.*\d)').hasMatch(val)) {
      return 'Password must contain at least one digit';
    } else if (!RegExp(r'(?=.*[!@#$%^&*()_+=|<>?{}[\]~-])').hasMatch(val)) {
      return 'Password must contain at least one special character';
    } else if (RegExp(dangerousCharacters).hasMatch(val)) {
      return "Password contains dangerous characters";
    }
  }

  return null;
}
