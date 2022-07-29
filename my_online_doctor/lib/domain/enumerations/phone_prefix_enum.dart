///PhonePrefix: Tipo enumerado encargado de manejar los prefijos de los telefonos.
enum PhonePrefix{
  phone412,
  phone414,
  phone416,
  phone424,
  phone426
}

extension Prefix on PhonePrefix {
  String get phoneType {
    switch (this) {
      case PhonePrefix.phone412:
        return '0412';
      case PhonePrefix.phone414:
        return '0414';
      case PhonePrefix.phone416:
        return '0416';
      case PhonePrefix.phone424:
        return '0424';
      case PhonePrefix.phone426:
        return '0426';
      default:
        return '';
    }
  }
}