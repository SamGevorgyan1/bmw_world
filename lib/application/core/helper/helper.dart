
import 'dart:io';

import 'package:dio/dio.dart';

import '../resources/data_state/data_state.dart';

Future<DataState<T>> handleResponse<T>(Response response, T data) {
  if (response.statusCode! >= HttpStatus.ok || response.statusCode! <= HttpStatus.multipleChoices) {
    return Future.value(DataState.success(data));
  } else {
    return Future.value(DataState.error(response));
  }
}
