class ResponseEntity {
  final bool _isSuccess;
  final int _statusCode;
  final String _message;
  final String _responseJson;

  ResponseEntity(
      this._isSuccess, this._message, this._statusCode, this._responseJson);

  String get message => _message;

  String get responseJson => _responseJson;

  int get statusCode => _statusCode;

  bool get isSuccess => _isSuccess;
}
