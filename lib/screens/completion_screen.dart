import 'package:breathe/generated/l10n.dart';
import 'package:breathe/model/quote.dart';
import 'package:breathe/pages_routes.dart';
import 'package:breathe/screens/main_screen.dart';
import 'package:breathe/widgets/big_button.dart';
import 'package:breathe/widgets/dark_mode_switcher.dart';
import 'package:flutter/material.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key, required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        actions: const <Widget>[
          DarkModeSwitcher(),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(image: AssetImage('assets/images/c1.png')),
              Text(
                '“${quote.body}”',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                quote.author,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 36),
              BigButton(
                text: S.of(context)!.homeButton.toUpperCase(),
                onPressed: () => Navigator.of(context).pushReplacement(
                  PageRoutes.fade(
                    () => const MainScreen(),
                    milliseconds: 800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
