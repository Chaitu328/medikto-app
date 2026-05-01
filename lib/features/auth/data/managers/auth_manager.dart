

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medikto/core/constants/api_urls.dart';
import 'package:medikto/core/network/base_response.dart';
import 'package:medikto/core/network/dio_client.dart';
import 'package:medikto/core/utils/storage_keys.dart';
import 'package:medikto/features/auth/login_view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthManager {
factory AuthManager() {
  return _singleton;
}

AuthManager._internal();

static final AuthManager _singleton = AuthManager._internal();

Future<String> get token async {
  final prefs = await SharedPreferences.getInstance();
  final t = prefs.getString(StorageKeys.token);
  if (t == null || t.isEmpty) {
    throw Exception("Not authenticated – no token in storage");
  }
  return t;
}

Future<ResponseData> performLogin(String phone) async {
  final formData = FormData.fromMap({
    "mobile_number": phone,
  });

  Response response;
  try {
    response = await dioClient.tokenRef!
        .post<dynamic>(ApiUrls.login, data: formData);

    if(response.statusCode == 200) {
      return ResponseData(response.data['message'], ResponseStatus.SUCCESS);
    } else {
      var message = "Unknown error";
      if(response.data?.containsKey("message") == true){
        message = response.data['message'];
      }
      return ResponseData(message, ResponseStatus.FAILED);
    }
  } on Exception {
    return ResponseData<dynamic>( 'Please check your internet', ResponseStatus.FAILED);
  }
}


// Inside lib/features/auth/data/managers/auth_manager.dart

Future<ResponseData> registerProfile(Map<String, dynamic> registrationData) async {
  try {
    // We use .ref! because registration usually requires the Auth Token 
    // from the OTP verification step
    final response = await dioClient.ref!.post(
      ApiUrls.register,
      data: registrationData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ResponseData("Account created successfully", ResponseStatus.SUCCESS);
    } else {
      final message = response.data?["message"] ?? "Registration failed";
      return ResponseData(message, ResponseStatus.FAILED);
    }
  } on DioException catch (e) {
    return ResponseData(e.response?.data?["message"] ?? "Server Error", ResponseStatus.FAILED);
  } catch (e) {
    return ResponseData("An unexpected error occurred", ResponseStatus.FAILED);
  }
}

// Future<ResponseData> verifyOTP(String phone, String otp) async {
//   final formData = FormData.fromMap({
//     "mobile_number": phone,
//     "otp": otp,
//   });
//   final sharedPreferences = await SharedPreferences.getInstance();

//   try {
//     final response = await dioClient.tokenRef!.post<dynamic>(
//       URLS.verify_otp,
//       data: formData,
//     );

//     if (response.statusCode == 200) {
//       // Log the response data
//       print("Response Data: ${response.data}");

//       // Save the token to shared preferences
//       await sharedPreferences.setString(
//         StorageKeys.token,
//         response.data["access"],
//       );

//       // *********  Include the ENTIRE response.data as the data  ************
//       return ResponseData(
//           "OTP Verified Successfully", ResponseStatus.SUCCESS,
//           data: response.data); // <---  Include the data!
//     } else {
//       // Handle server errors
//       final message = response.data?["message"] ?? "Invalid OTP";
//       return ResponseData(message, ResponseStatus.FAILED);
//     }
//   } on DioException catch (dioError) {
//     // Log Dio errors
//     print("DioError: ${dioError.message}");
//     final errorMessage = dioError.response?.data?["message"] ?? "Server error occurred";
//     return ResponseData(errorMessage, ResponseStatus.FAILED);
//   } on Exception catch (err) {
//     // Log generic exceptions
//     print("Exception: $err");
//     return ResponseData('Please check your internet connection', ResponseStatus.FAILED);
//   }
// }

// Future<ResponseData> registerProfile(Map<String, dynamic> data) async {
//   try {
//     // Retrieve the token from SharedPreferences
//     final sharedPreferences = await SharedPreferences.getInstance();
//     final token = sharedPreferences.getString(StorageKeys.token);

//     if (token == null) {
//       return ResponseData("Authentication token not found. Please log in again.", ResponseStatus.FAILED);
//     }

//     // Make the API request with the Authorization header
//     final response = await dioClient.ref!.post(
//       URLS.registerProfile,
//       data: data,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token', // Add the token to the Authorization header
//           'Content-Type': 'application/json',
//         },
//       ),
//     );

//     print("API Response: ${response.data}"); // Log the API response

//     if (response.statusCode == 200) {
//       return ResponseData("Profile registered successfully", ResponseStatus.SUCCESS);
//     } else {
//       final message = response.data?["message"] ?? "Unknown error occurred";
//       return ResponseData(message, ResponseStatus.FAILED);
//     }
//   } on DioException catch (dioError) {
//     print("DioError: ${dioError.response?.data ?? dioError.message}");
//     return ResponseData("Failed to register profile", ResponseStatus.FAILED);
//   }
// }


// Future<ResponseData> refreshToken() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   String refresh = sharedPreferences.getString(StorageKeys.refreshToken) ?? "";
//   final formData = FormData.fromMap({
//     "refresh": refresh,
//   });

//   Response response;
//   try {
//     response = await dioClient.tokenRef!
//         .post<dynamic>(URLS.tokenRefresh, data: formData);

//     if(response.statusCode == 200) {
//       sharedPreferences.setString(StorageKeys.refreshToken, response.data["data"]["refresh"]);
//       return ResponseData("", ResponseStatus.SUCCESS);
//     } else {
//       var message = "Unknown error";
//       // if(response.data?.containsKey("message") == true){
//       //   message = response.data['message'];
//       // }
//       return ResponseData(message, ResponseStatus.FAILED);
//     }
//   } on Exception catch (err) {
//     return ResponseData<dynamic>( err.toString(), ResponseStatus.FAILED);
//   }
// }

// Future<ResponseData> resendOTP(String phone) async {
//   final formData = FormData.fromMap({
//     "mobile_number": phone,
//   });

//   try {
//     final response = await dioClient.tokenRef!.post<dynamic>(
//       URLS.resend_otp,
//       data: formData,
//     );

//     if (response.statusCode == 200) {
//       return ResponseData(
//         response.data["message"] ?? "OTP sent successfully",
//         ResponseStatus.SUCCESS,
//       );
//     } else {
//       final message = response.data?["message"] ?? "Failed to resend OTP";
//       return ResponseData(message, ResponseStatus.FAILED);
//     }
//   } catch (e) {
//     print("Resend OTP error: $e");
//     return ResponseData("An error occurred", ResponseStatus.FAILED);
//   }
// }

// Future<ResponseData> districtList() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   final token = sharedPreferences.getString(StorageKeys.token);

//   if (token == null) {
//     return ResponseData(
//       "Authentication token not found. Please log in again.",
//       ResponseStatus.FAILED,
//     );
//   }

//   try {
//     final response = await dioClient.ref!.get<dynamic>(
//       URLS.districts,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       // final districts = districtModelFromJson(jsonEncode(response.data));
//       final List<dynamic> rawList = response.data as List<dynamic>;
//       final districts = rawList
//           .map((json) => DistrictModel.fromJson(json))
//           .toList();
//       return ResponseData(
//         "success",
//         ResponseStatus.SUCCESS,
//         data: districts,
//       );
//     } else {
//       String message = "Unknown error";
//       if (response.data is Map<String, dynamic>) {
//         message = response.data['message'] ?? response.data['error'] ?? message;
//       }
//       return ResponseData(message, ResponseStatus.FAILED);
//     }
//   } on DioException catch (dioError) {
//     final msg = ParseError.parse(dioError);
//     return ResponseData<dynamic>(msg, ResponseStatus.FAILED);
//   } catch (err) {
//     final msg = ParseError.parse(err);
//     return ResponseData<dynamic>(msg, ResponseStatus.FAILED);
//   }
// }

// Future<ResponseData> districtDetails(int? districtId) async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   final token = sharedPreferences.getString(StorageKeys.token);

//   if (token == null) {
//     return ResponseData(
//       "Authentication token not found. Please log in again.",
//       ResponseStatus.FAILED,
//     );
//   }

//   try {
//     final response = await dioClient.ref!.get<dynamic>(
//       URLS.districtDetails(districtId),
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       final districtDetails =
//       districtDetailsModelFromJson(jsonEncode(response.data));
//       return ResponseData(
//         "success",
//         ResponseStatus.SUCCESS,
//         data: districtDetails,
//       );
//     } else {
//       String message = "Unknown error";
//       if (response.data is Map<String, dynamic>) {
//         message = response.data['message'] ?? response.data['error'] ?? message;
//       }
//       return ResponseData(message, ResponseStatus.FAILED);
//     }
//   } on DioException catch (dioError) {
//     final msg = ParseError.parse(dioError);
//     return ResponseData<dynamic>(msg, ResponseStatus.FAILED);
//   } catch (err) {
//     final msg = ParseError.parse(err);
//     return ResponseData<dynamic>(msg, ResponseStatus.FAILED);
//   }
// }

// Future<ResponseData> mandalsDetails(int? mandalId) async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   final token = sharedPreferences.getString(StorageKeys.token);

//   if (token == null) {
//     return ResponseData(
//       "Authentication token not found. Please log in again.",
//       ResponseStatus.FAILED,
//     );
//   }

//   try {
//     final response = await dioClient.ref!.get<dynamic>(
//       URLS.mandals(mandalId),
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       final mandalsDetails =
//       mandalDetailsModelFromJson(jsonEncode(response.data));
//       return ResponseData(
//         "success",
//         ResponseStatus.SUCCESS,
//         data: mandalsDetails,
//       );
//     } else {
//       String message = "Unknown error";
//       if (response.data is Map<String, dynamic>) {
//         message = response.data['message'] ?? response.data['error'] ?? message;
//       }
//       return ResponseData(message, ResponseStatus.FAILED);
//     }
//   } on DioException catch (dioError) {
//     final msg = ParseError.parse(dioError);
//     return ResponseData<dynamic>(msg, ResponseStatus.FAILED);
//   } catch (err) {
//     final msg = ParseError.parse(err);
//     return ResponseData<dynamic>(msg, ResponseStatus.FAILED);
//   }
// }

// Future<ResponseData> registerDevice({
//   required String token,
//   required String deviceType,
//   required String appVersion,
// }) async {
//   final authToken = await this.token;
//   final payload = {
//     "token": token,
//     "device_type": deviceType,
//     "app_version": appVersion,
//   };
//   try {
//     final response = await dioClient.tokenRef!.post(
//       URLS.notificationToken,
//       data: payload,
//       options: Options(headers: {
//         'Authorization': 'Bearer $authToken',
//         'Content-Type': 'application/json',
//       }),
//     );
//     if (response.statusCode == 200) {
//       return ResponseData("Device registered", ResponseStatus.SUCCESS);
//     } else {
//       final msg = response.data?['message'] ?? 'Registration failed';
//       return ResponseData(msg, ResponseStatus.FAILED);
//     }
//   } catch (e) {
//     return ResponseData(e.toString(), ResponseStatus.FAILED);
//   }
// }

Future<void> logout(BuildContext context) async {
  await (await SharedPreferences.getInstance()).clear();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const LoginScreen()),
    (route) => false,
  );
}
}

AuthManager authManager = AuthManager();