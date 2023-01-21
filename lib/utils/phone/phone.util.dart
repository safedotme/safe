import 'package:phone_number/phone_number.dart';
import 'package:safe/utils/phone/codes.util.dart';

class PhoneUtil {
  final PhoneNumberUtil util = PhoneNumberUtil();

  Future<bool> validate(String phone, String code) async {
    bool valid = await util.validate(phone, code);
    return valid;
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
