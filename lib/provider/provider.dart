import 'package:get/get.dart';

class Provider extends GetConnect {
  Future<dynamic> getCall(String url) async {
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}