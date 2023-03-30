import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class CertificateManager {
  static ByteData? _rootCa;
  static ByteData? _privateKey;
  static ByteData? _certificate;

  static Future<void> loadCertificates() async {
    _rootCa = await rootBundle.load('assets/certs/AmazonRootCA1.pem');
    _privateKey = await rootBundle.load(
        'assets/certs/8a16158fe9fa767e45b9cd649866cd808e40ae769085bc7a2257b42e001f2ff5-private.pem.key');
    _certificate = await rootBundle.load(
        'assets/certs/8a16158fe9fa767e45b9cd649866cd808e40ae769085bc7a2257b42e001f2ff5-certificate.pem.crt');
  }

  static ByteData get rootCa => _rootCa!;
  static ByteData get privateKey => _privateKey!;
  static ByteData get certificate => _certificate!;
}
