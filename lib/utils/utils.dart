import 'dart:math';

import 'package:breathe/constants/quotes.dart';
import 'package:breathe/model/quote.dart';
import 'package:breathe/providers/settings_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Loads the licenses and attributions used by this project
void loadLicenses() {
  LicenseRegistry.addLicense(() async* {
    final String license = await rootBundle.loadString('google_fonts/v_OFL.txt');
    yield LicenseEntryWithLineBreaks(<String>['Varela Round Font'], license);

    final String license2 = await rootBundle.loadString('google_fonts/m_OFL.txt');
    yield LicenseEntryWithLineBreaks(<String>['Montserrat'], license2);

    const String license3 = 'https://icons8.com';
    yield const LicenseEntryWithLineBreaks(<String>['Illustration by Ouch.pics'], license3);
  });
}

/// Determine if its currently dark or light mode
bool isDark(BuildContext context, WidgetRef ref) {
  return ref.read(appStateProvider).isDarkMode;
}

/// A function that returns a random quote from [kDefaultQuotes]
Quote getQuote(BuildContext context) {
  final Random r = Random(DateTime.now().millisecondsSinceEpoch);
  final List<Quote> quotes = kDefaultQuotes(context);
  final int randInt = r.nextInt(quotes.length);
  return quotes[randInt];
}
