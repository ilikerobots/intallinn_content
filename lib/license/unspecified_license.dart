import 'package:in_tallinn_content/license/license.dart';

class UnspecifiedLicense extends License {
  LicenseType get type => LicenseType.LICENSE_UNSPECIFIED;
  String getAttribution(String author) => "";
  bool get attributionRequired => false; 
}