import 'package:in_tallinn_content/license/license.dart';

class CcBySa20License extends License {
  LicenseType get type => LicenseType.LICENSE_CC_BY_SA_20;
  String getAttribution(String author) => "Photo by $author";
  bool get attributionRequired => true; 
}