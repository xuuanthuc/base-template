import './../../public/flavor/app_flavor.dart';
import './../../src/app.dart';
import 'initial_app.dart';

void main() {
  AppFlavor.appFlavor = Flavor.development;
  initialApp(() => const MyApp());
}