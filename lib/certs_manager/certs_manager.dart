import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class CertificateManager {
  static String _rootCA = "";
  static List<int> _clientCert = [];
  static List<int> _privateKey = [];

  static Future<void> init() async {
    _rootCA =
        await rootBundle.load('assets/certs/AmazonRootCA1.pem').then((value) {
      return value.buffer.asUint8List().toString();
    });

    _clientCert = await rootBundle
        .load(
            'assets/certs/8a16158fe9fa767e45b9cd649866cd808e40ae769085bc7a2257b42e001f2ff5-certificate.pem.crt')
        .then((value) => value.buffer.asUint8List());

    _privateKey = await rootBundle
        .load(
            'assets/certs/8a16158fe9fa767e45b9cd649866cd808e40ae769085bc7a2257b42e001f2ff5-private.pem.key')
        .then((value) => value.buffer.asUint8List());
  }

  static String get rootCA => _rootCA;
  static List<int> get clientCert => _clientCert;
  static List<int> get privateKey => _privateKey;
}
