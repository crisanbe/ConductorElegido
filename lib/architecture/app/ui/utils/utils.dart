

String? validatePassword(String? value) {
  RegExp regex = RegExp(r'^.{6,}$');
  if (value!.isEmpty) {
    return "La clave no puede estar vacía";
  }
  if (!regex.hasMatch(value)) {
    return "Introduzca una contraseña válida de 6 caracteres como mínimo";
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  if (value!.isEmpty) {
    return "El correo electrónico no puede estar vacío";
  }
  if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+$").hasMatch(value)) {
    return "Introduzca una dirección de correo electrónico válida";
  } else {
    return null;
  }
}

//mapa de traducciones de Firebase
final Map<String, String> firebaseAuthErrorTranslations = {
  "invalid-email": "La dirección de correo electrónico es inválida.",
  "user-not-found": "El usuario no existe.",
  "wrong-password": "La contraseña es incorrecta.",
  // Agrega más traducciones según sea necesario.
};
