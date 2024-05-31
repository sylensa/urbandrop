class AppResponseCodes {
  static const String success = 'SUCCESS';
  static const String WEAVR_MOBILE_VERIFICATION_PENDING = 'WEAVR_MOBILE_VERIFICATION_PENDING';
  static const String alreadyExist = 'ALREADY_EXISTS';
  static const String failed = 'FAILED';
  static const String verificationPending = 'VERIFICATION_PENDING';
  static const String invalidToken = 'INVALID_TOKEN';
  static const String unauthorized = 'UNAUTHORIZED';
  static const String invalidCode = 'INVALID_CODE';
  static const String stageNameSuccess = 'Stage name is safe to use';


}

class OrderStatus{
  static const pending = 'pending';
  static const accepted = 'accepted';
  static const declined = 'declined';
  static const delivering = 'delivering';
  static const cancelled =  'cancelled';
  static const completed = 'completed' ;
}