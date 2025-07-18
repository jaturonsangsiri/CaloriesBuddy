import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  Future<void> launchLink(String uri) async {
    try {
      await launchUrl(Uri.parse(uri), mode: LaunchMode.inAppBrowserView);
    } catch (e) {
      if (kDebugMode) print('Error Launching Url: $e');
    }
  }
}
