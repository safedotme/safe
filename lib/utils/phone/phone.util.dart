import 'package:phone_number/phone_number.dart';
import 'package:safe/utils/phone/codes.util.dart';

class PhoneUtil {
  final PhoneNumberUtil util = PhoneNumberUtil();

  Future<bool> validate(String phone, String code) async {
    bool valid = await util.validate(phone, code);
    return valid;
  }

  Map<String, dynamic> extractCountryCode(String phone) {
    Map<String, dynamic> res = {
      "contains": false,
      "containing": false,
      "phone": null,
      "code": null,
      "dial_code": null,
    };

    if (!phone.contains("+")) {
      res["phone"] = phone;
      return res;
    }

    String? code;
    String? dialCode;

    for (final country in kCountryCodes) {
      final contains = phone.contains(country["dial_code"]!);

      if (contains) {
        code = country["code"];
        dialCode = country["dial_code"];
      }
    }

    if (code == null) {
      res["containing"] = true;
      return res;
    }

    res["contains"] = true;
    res["code"] = code;
    res["phone"] = phone.replaceAll(dialCode!, "");
    res["dial_code"] = dialCode;

    return res;
  }

  Future<String> format(String phone, String code) async {
    String formatted = await util.format(phone, code);
    return formatted;
  }

  Future<PhoneNumber> parse(String phone, String code) async {
    PhoneNumber num = await util.parse(phone, regionCode: code);

    return num;
  }

  String generateHint(String code) {
    return code == "US" || code == "CA"
        ? "(999) 999-9999"
        : "9999 9999"; //TODO: Fix later on
  }

  List<Map<String, String>> searchCountryFromName(String query) {
    List<Map<String, String>> result = [];

    for (Map<String, String> country in kCountryCodes) {
      String lowecase = country["name"]!.toLowerCase().substring(
            0,
            country["name"]!.length < query.length
                ? country["name"]!.length
                : query.length,
          );

      if (lowecase.contains(query.toLowerCase())) {
        result.add(country);
      }
    }

    return result;
  }
}
