/// ImagesConstant: Enum for images.
enum ImagesConstant {
  logo,
  serverError,
  noInternet,
  noProfilePhoto,
  noDoctorFound,
  fullLogo,
}

const imageBase= 'assets/images/';

extension ImagesConstantExtension on ImagesConstant {
  String get image {
    switch (this) {
      case ImagesConstant.logo:
        return 'assets/icon/doctor_logo.png';

      case ImagesConstant.serverError:
        return '${imageBase}server_error.png';

      case ImagesConstant.noProfilePhoto:
        return '${imageBase}no_profile_photo.png';

      case ImagesConstant.noDoctorFound:
        return '${imageBase}no_doctor_found.png';

      case ImagesConstant.noInternet:
        return '${imageBase}no_internet.jpg';

      case ImagesConstant.fullLogo:
        return '${imageBase}my_online_doctor_full_logo.png';

    }
  }
}