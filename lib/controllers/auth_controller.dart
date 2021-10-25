import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/utils/dynamic_link_handler.dart';
import 'package:flutter_app/utils/network_client.dart';
import 'package:flutter_app/utils/snackbar_handler.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final storage = GetStorage();
  RxBool loggedIn = false.obs;
  RxBool premium = false.obs;
  RxBool onboarding = false.obs;
  RxString token = ''.obs;
  RxString referralCode = ''.obs;
  Rx<User> user = User(
    id: 0,
    name: "",
    email: "",
    myReferralCode: "",
    countryId: "",
    accountStatus: false,
    profilePicture: "",
    isSubscribed: false,
    isNewsletterSubscribed: false,
    trialExpire: false,
    isVerified: false,
  ).obs;
  RxBool loading = false.obs;

  init() {
    print("INIT");
    final storage = GetStorage();
    final userString = storage.read('user');
    final loggedInString = storage.read('loggedIn');
    final premiumString = storage.read('premium');
    final onboardingString = storage.read('onboarding');
    final tokenString = storage.read('token');

    onboarding.value = onboardingString == 'true';
    premium.value = premiumString == 'true';

    if (loggedInString == 'true') {
      loggedIn.value = loggedInString == 'true';
      if (userString != null) {
        user.value = User.fromJson(jsonDecode(userString));
      }
      if (tokenString != null) {
        token.value = jsonDecode(tokenString);
        getProfile();
        getSubscription();
      }
    }
    DynamicLinkHandler.initDynamicLinks();
  }

  getProfile() async {
    try {
      final response = await NetworkClient.get(
        '/getProfile',
      );
      var userData = response.data['data'];
      user.value = createUser(userData);
      persistAuth();
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    }
  }

  getSubscription() async {
    try {
      final response = await NetworkClient.get(
        '/check-subscription-status',
      );
      print(response);
      premium.value = true;
      storage.write('premium', jsonEncode(premium.value));
    } on DioError catch (e) {
      premium.value = false;
      NetworkClient.errorHandler(e);
    }
  }

  confirmSubscription(
    String productId,
    String purchaseToken,
    Function onSuccess,
  ) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post('/purchase/subscription', {
        "subscription_id": productId,
        "device_type": Platform.isAndroid ? "android" : "ios",
        "purchase_token": purchaseToken,
      });
      print(response);
      premium.value = true;
      storage.write('premium', jsonEncode(premium.value));
      onSuccess();
    } on DioError catch (e) {
      premium.value = false;
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  login({
    @required String email,
    @required String password,
    Function onSuccess,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/login',
        {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        onSuccessAuth(response, onSuccess);
      }
      // NetworkClient.successHandler(response);
      loading.value = false;
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  verifyOtp({
    @required String email,
    @required String otp,
    Function onSuccess,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/signupOtpVerification',
        {"email": email, "otp": otp},
      );
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          onSuccess();
        }
      }
      NetworkClient.successHandler(response);
      loading.value = false;
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  resendOtp({
    @required String email,
  }) async {
    try {
      final response = await NetworkClient.post(
        '/resendOtp',
        {"email": email},
      );
      if (response.statusCode == 200) {
        SnackbarHandler.normalToast("OTP sent to the Email address", ''
            //  "Verification Code", response.data['data']['otp'].toString()
            );
      }
      // NetworkClient.successHandler(response);
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    }
  }

  signup({
    @required String email,
    @required String password,
    @required String name,
    @required bool isNewsletterSubscribed,
    @required String countryId,
    String referralCode,
    Function onSuccess,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post('/signup', {
        "name": name,
        "email": email,
        "password": password,
        "referral_code": referralCode,
        "is_newsletter_subscribed": isNewsletterSubscribed ? "1" : "0",
        "country_id": countryId
      });
      if (response.statusCode == 201) {
        onSuccessAuth(response, onSuccess);
      }
      // NetworkClient.successHandler(response);
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  logout() {
    storage.remove('loggedIn');
    storage.remove('user');
    storage.remove('token');
    loggedIn.value = false;
    user.value = User(
      id: 0,
      name: "",
      email: "",
      myReferralCode: "",
      countryId: "",
      accountStatus: false,
      profilePicture: "",
      isSubscribed: false,
      isNewsletterSubscribed: false,
      trialExpire: false,
      isVerified: false,
    );
    token.value = '';
    NetworkClient.get(
      '/logout',
    );
  }

  onSuccessAuth(dynamic response, Function onSuccess) {
    if (response.data['data']['user']['is_verified'] == 1) {
      var userData = response.data['data']['user'];
      user.value = createUser(userData);
      var accessToken = response.data['data']['token']['access_tokens'];
      loggedIn.value = true;

      token.value = accessToken;
      persistAuth();
    } else {
      SnackbarHandler.normalToast(
        "OTP sent to the Email address", '',
        // "Verification Code",
        // response.data['data']['otp'].toString()
      );
      if (onSuccess != null) {
        onSuccess();
      }
    }
  }

  createUser(dynamic userData) {
    print(userData);
    return User(
      id: userData['id'],
      email: userData['email'],
      name: userData['name'],
      myReferralCode: userData['my_referral_code'],
      isNewsletterSubscribed: userData['is_newsletter_subscribed'] == 1,
      profilePicture: userData['profile_picture'],
      countryId: userData['country_id'],
      isVerified: userData['is_verified'] == 1,
      trialExpire: userData['trial_expire'] == 1,
      isSubscribed: userData['is_subscribed'] == 1,
      accountStatus: userData['account_status'] == 1,
    );
  }

  persistAuth() {
    storage.write('user', jsonEncode(user.value));
    storage.write('loggedIn', jsonEncode(loggedIn.value));
    storage.write('token', jsonEncode(token.value));
  }

  onBoarding() {
    onboarding.value = true;
    storage.write('onboarding', jsonEncode(onboarding.value));
  }

  forgotPassword({
    @required String email,
    Function onSuccess,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/forgotPassword',
        {"email": email},
      );
      print(response);
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          SnackbarHandler.normalToast("OTP sent to the Email address", ''

              ///  "Verification Code", response.data['data']['otp'].toString()
              );
          onSuccess();
        }
      }
      loading.value = false;
      // NetworkClient.successHandler(response);
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  passwordVerifyOtp({
    @required String email,
    @required String otp,
    Function(String token) onSuccess,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/otpVerify',
        {"email": email, "otp": otp},
      );
      print(response.data['data']['token']);
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          onSuccess(response.data['data']['token']);
        }
      }
      NetworkClient.successHandler(response);
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  resetPassword({
    @required String password,
    @required String token,
    Function onSuccess,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/resetPassword',
        {"password": password, "token": token, "new_password": password},
      );
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          onSuccess();
        }
      }
      NetworkClient.successHandler(response);
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  editProfile({
    @required String email,
    @required String name,
    @required bool isNewsletterSubscribed,
    String profilePicture,
    Function(bool navigateToOtp) onSuccess,
  }) async {
    try {
      loading.value = true;
      Response<dynamic> response;
      if (profilePicture != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
            '.' +
            profilePicture.split('.').last;
        FormData formData = FormData.fromMap({
          "name": name,
          ...(user.value.email != email ? {"email": email} : {}),
          "is_newsletter_subscribed": isNewsletterSubscribed ? "1" : "0",
          "profile_picture":
              await MultipartFile.fromFile(profilePicture, filename: fileName),
        });
        response = await NetworkClient.upload('/edit_profile', formData);
      } else {
        response = await NetworkClient.post('/edit_profile', {
          "name": name,
          ...(user.value.email != email ? {"email": email} : {}),
          "is_newsletter_subscribed": isNewsletterSubscribed ? "1" : "0",
        });
      }

      if (response.statusCode == 200) {
        var userData = response.data['data'];
        user.value = createUser(userData);
        persistAuth();
        if (onSuccess != null) {
          onSuccess(false);
        }
        print(response);
      } else if (response.statusCode == 201) {
        if (onSuccess != null) {
          SnackbarHandler.normalToast("OTP sent to the Email address", ''
              //"Verification Code", response.data['data']['otp'].toString()
              );
          onSuccess(true);
        }
      }
      // NetworkClient.successHandler(response);
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  profileVerifyOtp({
    @required String email,
    @required String name,
    @required String otp,
    @required bool isNewsletterSubscribed,
    String profilePicture,
    Function onSuccess,
  }) async {
    try {
      loading.value = true;
      Response<dynamic> response;
      if (profilePicture != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
            '.' +
            profilePicture.split('.').last;
        FormData formData = FormData.fromMap({
          "otp": otp,
          "name": name,
          ...(user.value.email != email ? {"email": email} : {}),
          "is_newsletter_subscribed": isNewsletterSubscribed ? "1" : "0",
          "profile_picture":
              await MultipartFile.fromFile(profilePicture, filename: fileName),
        });
        response = await NetworkClient.upload('/UpdateotpVerify', formData);
      } else {
        response = await NetworkClient.post('/UpdateotpVerify', {
          "name": name,
          ...(user.value.email != email ? {"email": email} : {}),
          "is_newsletter_subscribed": isNewsletterSubscribed ? "1" : "0",
          "otp": otp,
        });
      }
      if (response.statusCode == 200) {
        var userData = response.data['data']['user'];
        user.value = createUser(userData);
        persistAuth();
        if (onSuccess != null) {
          onSuccess();
        }
      }

      // NetworkClient.successHandler(response);
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }

  changePassword({
    @required String recentPassword,
    @required String newPassword,
    Function onSuccess,
  }) async {
    try {
      loading.value = true;
      final response = await NetworkClient.post(
        '/changePassword',
        {"recent_password": recentPassword, "new_password": newPassword},
      );
      if (response.statusCode == 200) {
        if (onSuccess != null) {
          onSuccess();
        }
      }
      //NetworkClient.successHandler(response);
    } on DioError catch (e) {
      NetworkClient.errorHandler(e);
    } finally {
      loading.value = false;
    }
  }
}
