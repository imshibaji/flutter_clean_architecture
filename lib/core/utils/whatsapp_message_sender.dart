import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

/// The WhatsAppUnilink class helps you create WhatsApp URLs.
///
/// It cleans the phone number input and encodes the text.
class WhatsAppMessageSender {
  /// Creates a [WhatsAppUnilink] instance.
  ///
  /// Call the [toString] method to get the WhatsApp URL.
  const WhatsAppMessageSender({
    this.phoneNumber,
    this.text,
    this.file,
  });

  /// Destination phone number.
  ///
  /// The [phoneNumber] string will be internally converted to a format that the
  /// WhatsApp API expect: any brackets, dashes, plus signs, and leading zeros
  /// or any other non-digit characters will be removed.
  final String? phoneNumber;

  /// The message to the user.
  ///
  /// WhatsApp will include your message in [text], and it will automatically
  /// appear in the text field of a chat.
  ///
  /// [text] is encoded using percent-encoding to make it safe for literal use
  /// as a URI component.
  final String? text;

  final File? file;

  /// Create a WhatsApp URL link.
  @override
  String toString() {
    final sb = StringBuffer('https://wa.me/');
    phoneNumber?.use(_formatPhoneNumber).use(sb.write);
    text?.use((s) => sb.write('?text=${Uri.encodeComponent(s)}'));
    return sb.toString();
  }

  /// Keep only the numbers and remove any leading zeros
  static String _formatPhoneNumber(String phoneNumber) {
    return phoneNumber
        .replaceAll(RegExp(r'\D'), '')
        .replaceAll(RegExp('^0+'), '');
  }

  sendTo() async {
    await launchUrl(
        Uri.parse('whatsapp://send/?phone=$phoneNumber&text=$text'));
  }

  Future<void> send() async {
    await launchUrl(Uri.parse(toString()));
  }
}

extension on String? {
  T? use<T>(T Function(String s) f) {
    if (this != null) return f(this!);
    return null;
  }
}
