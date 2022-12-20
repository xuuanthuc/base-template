import '../../global/flavor/app_flavor.dart';

abstract class ApiEndpoint{
  static String get _baseUrl => AppFlavor.baseApi;

  static String get post => '${_baseUrl}/posts';
}