abstract class ResponseResult<T> {}

class SuccessResponse<T> extends ResponseResult<T> {
  T data;

  SuccessResponse(this.data);
}

class FailureResponse<T> extends ResponseResult<T> {
  String error;
  StackTrace stackTrace;

  FailureResponse(this.error, this.stackTrace);
}
