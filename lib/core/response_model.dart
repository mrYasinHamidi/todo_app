class ResponseModel {
  final String message;
  final int statusCode;
  final dynamic data;

  const ResponseModel({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      data: json['object'],
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}
