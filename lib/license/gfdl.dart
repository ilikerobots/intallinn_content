import 'package:in_tallinn_content/license/license.dart';

class Gfdl extends License {
  LicenseType get type => LicenseType.LICENSE_GFDL;
  String getAttribution(String author) => "Photo by $author";
  bool get attributionRequired => true; 
}