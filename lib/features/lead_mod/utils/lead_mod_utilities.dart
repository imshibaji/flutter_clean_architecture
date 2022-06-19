import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dbobj/dbobjs.dart';

const leadStatuses = [
  'New',
  'Pending',
  'Interested',
  'Success',
  'Rejected',
  'Expired',
];

const leadSources = [
  'Official Website',
  'Social Media',
  'Contact List',
  'Phone Call',
  'Friends',
  'Others'
];

List getFilterDatas(List list, [String status = 'All']) {
  if ((status != 'All')) {
    return list
        .where(
            (element) => element?.status.toLowerCase() == status.toLowerCase())
        .toList();
  } else {
    return list;
  }
}

extension StringParse on double {
  String toK() {
    if (this > 1000000000) {
      return (toInt() / 1000000000).toStringAsFixed(2) + 'B';
    }
    if (this > 1000000) {
      return (toInt() / 1000000).toStringAsFixed(2) + 'M';
    }
    if (this > 1000) {
      return (toInt() / 1000).toStringAsFixed(2) + 'K';
    }
    return toString();
  }

  String toM() {
    if (this > 1000000000) {
      return (toInt() / 1000000000).toStringAsFixed(4) + 'B';
    }
    if (this > 1000000) {
      return (toInt() / 1000000).toStringAsFixed(4) + 'M';
    }
    // if (this > 1000) {
    //   return (toInt() / 1000).toStringAsFixed(2) + 'K';
    // }
    return toStringAsFixed(2);
  }
}

double getBalance(List<Payment> payments) {
  double balance = getTotalIncome(payments) - getTotalExpense(payments);
  return balance;
}

double getTotalIncome(List<Payment> payments) {
  var incomes = payments
      .where((element) => element.type!.toLowerCase() == 'income')
      .toList()
      .map((e) => e.amount);

  var totalIncome = incomes.fold<double>(0.0, (a, b) => a + b!);

  return totalIncome;
}

double getTotalExpense(List<Payment> payments) {
  var expenses = payments
      .where((element) => element.type!.toLowerCase() == 'expense')
      .toList()
      .map((e) => e.amount);

  var totalExpenses = expenses.fold<double>(0.0, (a, b) => a + b!);
  return totalExpenses;
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

Container searchBar() {
  return Container(
    color: Colors.tealAccent.withOpacity(0.4),
    child: TextFormField(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(
          Icons.search,
        ),
        labelText: 'Search...',
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Input the name';
        }
        return null;
      },
    ),
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

Future<void> mailTo(String email, {String? subject, String? content}) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    query: encodeQueryParameters({
      'subject': subject ?? 'Contacting for ',
      'content': content ?? 'Contact For'
    }),
  );

  await launchUrl(emailLaunchUri);
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
