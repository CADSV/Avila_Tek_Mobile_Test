///TextConstant: Enum for texts. All the apps texts are here.
enum TextConstant {
  appName,
  errorTimeoutConnection,
  errorInternetConnection,
  errorServer,
  retry,
  acceptButton,
  cancelButton,
  successTitle,
  errorTitle,
  toBeContinued,
  pageInConstruction,
  sorry,
  saveChanges,
  errorOcurred,
}

extension TextConstantExtension on TextConstant {
  String get text {
    switch (this) {
      case TextConstant.appName:
        return 'Avila Tek Test';
      case TextConstant.errorTimeoutConnection:
        return 'The operation is taking too much time.\nPlease, verify your internet connection';

      case TextConstant.errorInternetConnection:
        return 'A problem has ocurred while trying to connect with the server.\nPlease, try again later';

      case TextConstant.errorServer:
        return 'Server Error.\nPlease, try again later';

      case TextConstant.retry:
        return 'Please try again';

      case TextConstant.acceptButton:
        return 'Accept';

      case TextConstant.cancelButton:
        return 'Cancel';

      case TextConstant.successTitle:
        return 'Success';

      case TextConstant.errorTitle:
        return 'Error';

      case TextConstant.toBeContinued:
        return 'In construction';

      case TextConstant.pageInConstruction:
        return 'Page in construction';

      case TextConstant.sorry:
        return 'Sorry';

      case TextConstant.saveChanges:
        return 'Save changes';

      case TextConstant.errorOcurred:
        return 'We have a litlle problem. Please try again later';
    }
  }
}
