class DataState<T> {
  final T? data;
  final Object? exception;

  const DataState({this.data, this.exception});

  factory DataState.success(T data) {
    return DataSuccess(data);
  }

  factory DataState.error(Object exception) {
    return DataFailed(exception);
  }
}

class DataSuccess<T> extends DataState<T> {
  final T data;

  const DataSuccess(this.data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  final Object exception;

  const DataFailed(this.exception) : super(exception: exception);
}
