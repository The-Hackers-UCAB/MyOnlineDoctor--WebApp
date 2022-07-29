// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/model/request_value_response_model.dart';
import 'package:my_online_doctor/infrastructure/providers/local_storage/local_storage_provider.dart';
import 'context_manager.dart';
import 'flavor_manager.dart';
import 'injection_manager.dart';


// Project imports:
import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dialog_component.dart';
import 'package:my_online_doctor/infrastructure/ui/login/login_page.dart';
import 'package:my_online_doctor/infrastructure/utils/app_util.dart';
import 'package:my_online_doctor/infrastructure/model/request_responde_model.dart';


///RepositoryManager: This class is used to manage the repository main connection.
class RepositoryManager {



  Future<BaseOptions> _dioBaseOptions() async {

    

    var repositoryHeader = <String, dynamic>{}; 
    var url=FlavorManager.baseURL();
    var options = BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: 30).inMilliseconds,
        receiveTimeout: const Duration(seconds: 30).inMilliseconds,
        responseType: ResponseType.plain,
        headers: repositoryHeader,
        contentType: RepositoryConstant.contentType.key);
    return options;
  }

  void _validateCertificate(Dio dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<dynamic> request({required String operation, required String endpoint, Map<String,dynamic>? body, bool wompi=false}) async {
    

    endpoint = FlavorManager.baseURL() + endpoint;
    
    var setDioOptions = await _dioBaseOptions();

    setDioOptions.headers['cookie'] = await LocalStorageProvider.readData(RepositoryPathConstant.cookie.path) as String;

    var dio = Dio(setDioOptions);



    _validateCertificate(dio);

    Response? response;

    try {
      if (operation == RepositoryConstant.operationGet.key) {
        response = await dio.get(endpoint);
      } else if (operation == RepositoryConstant.operationPost.key) {
        response = await dio.post(endpoint, data: body);

        if(endpoint == FlavorManager.baseURL() + RepositoryPathConstant.login.path){
          for (var element in response.headers['set-cookie']!) {
            LocalStorageProvider.saveData(RepositoryPathConstant.cookie.path, element);
          }
        }

      } else if (operation == RepositoryConstant.operationPut.key) {
        if (body != null) {
          response = await dio.put(endpoint, data: body);
        } else {
          response = await dio.put(endpoint);
        }
      } else if (operation == RepositoryConstant.operationDelete.key) {
        if (body != null) {
          response = await dio.delete(endpoint, data: body);
        } else {
          response = await dio.delete(endpoint);
        }
      }

      dio.close();

      var data = requestValueResponseModelFromJson(response?.data);


      return data;
      // return response?.data;
    } on DioError catch (e) {
      _errorRequest(e);
    }
    return null;
  }

  void _errorRequest(DioError e) async {
    var error = requestResponseModelFromJson(e.response!.data);

    if (DioErrorType.receiveTimeout == e.type || DioErrorType.connectTimeout == e.type) {
      AppUtil.showDialogUtil(context: getIt<ContextManager>().context, title: TextConstant.errorTitle.text, message:error.message ?? TextConstant.errorTimeoutConnection.text);
      throw 600;
    } else if (e.message.contains('SocketException')) {
      AppUtil.showDialogUtil(context: getIt<ContextManager>().context, title: TextConstant.errorTitle.text, message:error.message ?? TextConstant.errorInternetConnection.text);
      throw 600;
    } else {
      switch (e.response!.statusCode!) {
        case 401:
          AppUtil.showDialogUtil(context: getIt<ContextManager>().context, title: TextConstant.errorTitle.text, message:error.message ?? TextConstant.errorUnauthorized.text);
          throw 401;
        case 404:
          AppUtil.showDialogUtil(context: getIt<ContextManager>().context, title: TextConstant.errorTitle.text, message:error.message ?? TextConstant.errorServer.text);
          throw 404;

        case 403:
          // AppUtil.showDialogUtil(context: getIt<ContextManager>().context, title: TextConstant.sorry.text, message: TextConstant.expiredCookie.text);

          // await showDialog(
          //   context: getIt<ContextManager>().context,
          //     builder: (BuildContext superContext) => DialogComponent(
          //         textTitle: TextConstant.sorry.text,
          //         textQuestion: TextConstant.expiredCookie.text,
          //       )
          //   );
          // Navigator.of(getIt<ContextManager>().context).pushNamedAndRemoveUntil(LoginPage.routeName, (Route<dynamic> route) => false);


          break;

        case 500:
        
          AppUtil.showDialogUtil(context: getIt<ContextManager>().context, title: TextConstant.errorTitle.text, message: error.message ?? TextConstant.errorServer.text);
          throw 500;
        default:
          AppUtil.showDialogUtil(context: getIt<ContextManager>().context, title: TextConstant.errorTitle.text, message: error.message ?? TextConstant.errorServer.text);
          throw e.response!.statusCode!;
      }
    }
  }


}
