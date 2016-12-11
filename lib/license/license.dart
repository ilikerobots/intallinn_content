import 'package:in_tallinn_content/license/cc_by_sa_20.dart';
import 'package:in_tallinn_content/license/cc_by_sa_40.dart';
import 'package:in_tallinn_content/license/cc_by_sa_30.dart';
import 'package:in_tallinn_content/license/gfdl.dart';
import 'package:in_tallinn_content/license/public_domain_license.dart';
import 'package:in_tallinn_content/license/unspecified_license.dart';


class LicenseFactory {
  static final LicenseFactory _factory = new LicenseFactory._internal();

  static const Map<String, LicenseType> LICENSE_TYPE_BY_NAME = const {
    "CC_BY_SA_40" : LicenseType.LICENSE_CC_BY_SA_40,
    "CC_BY_SA_30" : LicenseType.LICENSE_CC_BY_SA_30,
    "CC_BY_SA_20" : LicenseType.LICENSE_CC_BY_SA_20,
    "GFDL" : LicenseType.LICENSE_GFDL,
    "PUBLIC_DOMAIN" : LicenseType.LICENSE_PUBLIC_DOMAIN,
    "UNSPECIFIED" : LicenseType.LICENSE_UNSPECIFIED,

  };

  factory LicenseFactory() {
    return _factory;
  }


  LicenseFactory._internal();


  License getLicenseFromString(String type) {
    if (LICENSE_TYPE_BY_NAME.containsKey(type)) {
      return getLicense(LICENSE_TYPE_BY_NAME[type]);
    } else {
      return new UnspecifiedLicense();
    }
  }


  License getLicense(LicenseType type) {
    switch (type) {
      case LicenseType.LICENSE_CC_BY_SA_40:
      case LicenseType.LICENSE_CC_BY_SA_40:
        return new CcBySa40License();
        break;
      case LicenseType.LICENSE_CC_BY_SA_30:
        return new CcBySa30License();
        break;
      case LicenseType.LICENSE_CC_BY_SA_20:
        return new CcBySa20License();
        break;
      case LicenseType.LICENSE_GFDL:
        return new Gfdl();
        break;
      case LicenseType.LICENSE_UNSPECIFIED:
        return new UnspecifiedLicense();
        break;
      case LicenseType.LICENSE_PUBLIC_DOMAIN:
        return new PublicDomainLicense();
        break;
      default:
        return new UnspecifiedLicense();
    }
  }
}

abstract class License {
  LicenseType get type;

  String getAttribution(String author);

  bool get attributionRequired => true;
}


enum LicenseType {
  LICENSE_PUBLIC_DOMAIN,
  LICENSE_UNSPECIFIED,
  LICENSE_CC_BY_SA_40,
  LICENSE_CC_BY_SA_30,
  LICENSE_CC_BY_SA_20,
  LICENSE_GFDL,
}

