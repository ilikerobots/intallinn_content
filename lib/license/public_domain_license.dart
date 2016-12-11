import 'package:in_tallinn_content/license/license.dart';

class PublicDomainLicense extends License {
  LicenseType get type => LicenseType.LICENSE_PUBLIC_DOMAIN;
  String getAttribution(String author) => "";
  bool get attributionRequired => false; 
}