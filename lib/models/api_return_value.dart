class ApiReturnValue<T> {
  String? message;
  T? value;

  ApiReturnValue({this.value, this.message});
}