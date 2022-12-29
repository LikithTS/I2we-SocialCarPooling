class ApiConstant {
  static const int STATUS_CODE_SUCCESS = 200;
  static const int STATUS_CODE_SUCCESS_ONE = 201;
  static const int HTTP_UNAUTHORIZED_ERROR = 401;
  static const int SOCIAL_LOGIN_NEW_USER_ERROR = 503;
  static const int HTTP_INTERNAL_SERVER_ERROR = 500;

  static const String LOGIN_API_PATH = "user/login";
  static const String SOCIAL_API_PATH = "user/social-login";
  static const String LOGOUT_API_PATH = "user/logout";
  static const String HOME_API_PATH = "home";
  static const String SIGN_IN_API_PATH = "user/signup";
  static const String SEND_OTP_API_PATH = "user/send-otp";
  static const String VERIFY_OTP_API_PATH = "user/validate-otp";
  static const String QUESTIONARIE_API_PATH = "questionnarie";
  static const String CAR_API_PATH = "car/all";
  static const String CAR_DRVING_STATUS = "car/change-status";
  static const String ADD_NEW_CAR = "car/add";
  static const String DELETE_CAR = "car/del";
  static const String ALL_RIDE = "ride/all";
  static const String HISTORY = "ride/get-recent-rides";
  static const String NEW_RIDE = "ride/new-ride";
  static const String UPCOMING_RIDE = "ride/upcoming";
  static const String REFRESH = "auth/refresh-token";
  static const String CHANGE_PASSWORD_API_PATH = "user/change-password";
  static const String UPDATE_USER = "user/update-details";
  static const String GET_USER = "user";
  static const String GET_USER_PROFILE_URL = "/user/profile-upload-url";
  static const String GET_CAR_UPLOAD_URL = "/car/car-images-presigned-url/";
  static const String POST_UPDATE_PROFILE_PHOTO = "/user/update-profile-photo";
  static const String POST_UPDATE_DL_PHOTO =
      "/user/update-driver-license-photo";
  static const String GET_IDENTIFICATION_URL =
      "/user/identification-upload-url";
  static const String POST_UPDATE_IDENTIFICATION_PHOTO =
      "/user/update-identification-photo";
  static const String GET_DRIVING_LICENSE_URL =
      "/user/driving-license-upload-url";
  static const String FIREBASE_API_PATH = "/user/update-firebase-token";
  static const String AVAILABLE_RIDES = "ride/avaliable-rides";
  static const String PRESIGNED_CAR_IMAGES = "/user/car-images-presigned-url/";
  static const String RIDE_STATUS_PASSANGER = "ride/change-status-passenger";
  static const String RIDE_STATUS_DRIVER = "ride/change-status-driver";
  static const String INVITE_RIDE = "invite";
  static const String JOIN_RIDE = "invite/join";
  static const String CURRENT_RIDE = "ride/ride";
  static const String INVITE_CANCEL = "invite/cancel";

  static const String RC_UPLOAD_URL = "/user/rc-upload-url";
}
