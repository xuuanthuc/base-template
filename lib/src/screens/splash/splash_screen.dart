import 'package:flutter/material.dart';
import 'package:template/public/routes/navigation_service.dart';
import 'package:template/public/routes/route_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
  }

  goToHome() async {
    await Future.delayed(const Duration(seconds: 1));
    navService.pushNamed(RouteKey.home);
  }

  @override
  void didChangeDependencies() {
    goToHome();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
