import 'package:template/public/flavor/app_flavor.dart';
import 'package:template/src/app.dart';
import 'initial_app.dart';

void main() {
  AppFlavor.appFlavor = Flavor.development;
  initialApp(() => const MyApp());
}