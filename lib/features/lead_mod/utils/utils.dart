import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<DateTime> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null) {
    return picked;
  }
  return DateTime.now();
}

Future<TimeOfDay> selectTime(BuildContext context) async {
  final TimeOfDay? picked =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (picked != null) {
    return picked;
  }
  return TimeOfDay.now();
}

TextFormField searchBarTitle() {
  return TextFormField(
    decoration: const InputDecoration(
      prefixIcon: Icon(
        Icons.search,
        color: Colors.white,
      ),
      prefixStyle: TextStyle(color: Colors.white),
      labelText: 'Search...',
      labelStyle: TextStyle(color: Colors.white),
    ),
    validator: (val) {
      if (val!.isEmpty) {
        return 'Input the name';
      }
      return null;
    },
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.amber),
  );
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> launchInWebViewOrVC(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: const WebViewConfiguration(
        headers: <String, String>{'my_header_key': 'my_header_value'}),
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> launchInWebViewWithoutJavaScript(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> launchInWebViewWithoutDomStorage(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.inAppWebView,
    webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
  )) {
    throw 'Could not launch $url';
  }
}

Future<void> launchUniversalLinkIos(Uri url) async {
  final bool nativeAppLaunchSucceeded = await launchUrl(
    url,
    mode: LaunchMode.externalNonBrowserApplication,
  );
  if (!nativeAppLaunchSucceeded) {
    await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    );
  }
}

Widget launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
  if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
  } else {
    return const Text('');
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> mailTo(String email) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    query:
        encodeQueryParameters(<String, String>{'subject': 'Contacting for '}),
  );

  await launchUrl(emailLaunchUri);
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
