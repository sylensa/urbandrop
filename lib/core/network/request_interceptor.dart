import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/helper/helper.dart';
import 'package:urbandrop/core/helper/hide.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/main.dart';
import 'package:urbandrop/models/user.dart';



 Map<String, String> requestHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer ${UserPreferences.accessToken}',
  'x-api-key': MERCHANT_API_KEY,
  'x-client' : 'mobile'
};

class HeadersInterceptor extends Interceptor {
  HeadersInterceptor(this._headers);

  final Map<String, String> _headers;

  @override
  Future onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey('Authorization')) {
      options.headers.addAll(_headers);
    }
    final token = await UserPreferences().getUserToken();
    print("null token:${options.headers}");
    if (token != null && options.headers.containsKey('Authorization')) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }



  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print("err.response?.statusCode:${err.response?.statusCode}");
    if (err.response?.statusCode == 401) {
      final refreshed = await _regenerateAccessToken();
      if (refreshed != null) {
        log("UserPreferences.accessToken:${UserPreferences.accessToken}");
        err.requestOptions.headers['Authorization'] =
            'Bearer ${UserPreferences.accessToken}';
        return handler.resolve(await _retry(err.requestOptions));
      }else{
        container.read(isAuthorizedProvider.notifier).state = false;
      }
    }
    return handler.next(err);
  }


  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    print("requestOptions.headers:${requestOptions.headers}");
      final options = Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType:ResponseType.json,
      );
      print("res:res${options.method}");
      print("res:res${options.headers}");
      final res =  await Dio().request<dynamic>(requestOptions.path, data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);

        return res;
  }

  Future<String?> _regenerateAccessToken() async {
    try {
      final refreshToken =  UserPreferences.refreshToken;
      if (refreshToken == null) {
        await UserPreferences().logout();
        return null;
      }
     final response = await refreshAccessToken(refreshToken: refreshToken);
      print("response new:${response}");
      return response;
    } on DioError {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> refreshAccessToken({required String refreshToken}) async {
    final HttpClientWrapper _http = HttpClientWrapper();

    //todo: refresh access token
    var body = {
      "id": userInstance!.id,
      "refresh_token" : UserPreferences.refreshToken
    };
   try{
     // var res = await doPost(AppUrl.refreshToken, body);
     var res  = await _http.postRequest('${AppUrl.refreshToken}', body);
     print("res object refreshToken:$res");
     if(res["status"] == AppResponseCodes.success){
       UserModel user = UserModel.fromJson(res['data']);
       await UserPreferences().setUser(res['data']);
       await UserPreferences().setToken(user.token!);
       await UserPreferences().setRefreshToken(user.refreshToken!);
       return user.token;
     }else{
       return null;
     }
   }catch(e){
     log("rtry error:${e.toString()}");
     return null;
   }
  }
}

final headersInterceptor =
    Provider<Interceptor>((ref) => HeadersInterceptor(requestHeaders));

final isAuthorizedProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});
final isLoggedInProvider = StateProvider<bool>((ref) {
  print("login later");
  return UserPreferences.isLoggedIn;
});
