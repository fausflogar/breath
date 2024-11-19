import 'package:breathe/constants/theme.dart';
import 'package:breathe/constants/ui.dart';
import 'package:breathe/generated/l10n.dart';
import 'package:breathe/model/settings.dart';
import 'package:breathe/pages_routes.dart';
import 'package:breathe/providers/settings_provider.dart';
import 'package:breathe/screens/main_screen.dart';
import 'package:breathe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  loadLicenses();
  // Ensure services are loaded before the widgets get loaded
  WidgetsFlutterBinding.ensureInitialized();
  // Restrict device orientiation to portraitUp
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final AppState appState = ref.watch(appStateProvider);
        return MaterialApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: (BuildContext context, Widget? widget) {
            return ResponsiveBreakpoints.builder(
              child: widget!,
              breakpoints: <Breakpoint>[
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1200, name: DESKTOP),
                const Breakpoint(start: 1201, end: 2460, name: '4K'),
              ],
            );
          },
          title: appTitle,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          // ignore: missing_return
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name == '/') {
              return PageRoutes.fade(
                () => const MainScreen(
                  startingAnimation: true,
                ),
              );
            }
            return null;
          },
        );
      },
    );
  }
}
