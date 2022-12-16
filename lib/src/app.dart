import 'package:flutter/material.dart';
import '../public/routes/app_routes.dart';
import '../public/routes/navigation_service.dart';
import '../public/routes/route_observer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        locale: const Locale('vi', ''),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorObservers: [MyRouteObserver()],
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        onGenerateInitialRoutes: (_) =>
            AppRoutes.onGenerateInitialRoute(),
        navigatorKey: NavigationService.navigationKey,
      ),
    );
  }
}
