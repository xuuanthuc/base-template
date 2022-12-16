import 'package:template/initial_app.dart';
import 'package:template/public/flavor/app_flavor.dart';
import 'package:template/src/app.dart';

void main() {
  AppFlavor.appFlavor = Flavor.release;
  initialApp(() => const MyApp());
}