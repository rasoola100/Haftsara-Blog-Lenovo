import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'package:get_storage/get_storage.dart';
import 'package:haftsara_blog/components/storage_const.dart';

class DioService {
  Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    return await dio
        .get(url,
            options: Options(
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
                method: 'GET'))
        .then((response) {
      log(response.toString());
      return response;
    });
  }

 Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {
  var token = GetStorage().read(StorageConst.token);
  if (token != null) {
    dio.options.headers['authorization'] = token.toString();
  }
  
  try {
    final response = await dio.post(
      url,
      data: FormData.fromMap(map),
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        method: 'POST',
      ),
    );
    
    // Uncomment for debugging purposes
    // log(response.headers.toString());
    // log(response.data.toString());
    // log(response.statusCode.toString());

    return response;
  } on DioException catch (e) {
    // Log the error details for better debugging
    print("DioException caught: ${e.message}");
    if (e.response != null) {
      print("Response data: ${e.response!.data}");
      print("Response status code: ${e.response!.statusCode}");
    }
    return e.response; // Return the error response
  } catch (e) {
    // Handle any other type of error
    print("Unhandled exception: $e");
    return null; // or you can create a custom error response
  }
}


}
