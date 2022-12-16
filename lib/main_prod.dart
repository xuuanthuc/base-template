import './../../initial_app.dart';
import './../../public/flavor/app_flavor.dart';
import './../../src/app.dart';

void main() {
  AppFlavor.appFlavor = Flavor.release;
  initialApp(() => const MyApp());
}