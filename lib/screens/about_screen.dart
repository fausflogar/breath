import 'package:breathe/constants/ui.dart';
import 'package:breathe/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchEmailClient() async {
    const String url = 'mailto:$devEmail?subject=Breathe';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      if (kDebugMode) {
        print('Could not launch $url');
      }
    }
  }

  Future<void> _launchWebsite() async {
    const String url = 'https://$productSite';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      if (kDebugMode) {
        print('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: IconButton(
          icon: const Icon(Icons.arrow_downward),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                appTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                S.of(context)!.aboutBlurb,
                textAlign: TextAlign.center,
              ),
              TextButton(
                child: Text(S.of(context)!.websiteButton),
                onPressed: () async => _launchWebsite(),
              ),
              const SizedBox(height: 12),
              Wrap(
                children: <Widget>[
                  TextButton(
                    child: Text(S.of(context)!.attributonButton),
                    onPressed: () => showLicensePage(context: context),
                  ),
                  TextButton(
                    child: Text(S.of(context)!.contactButton),
                    onPressed: () async => _launchEmailClient(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
