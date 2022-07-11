import 'package:safe/utils/country_codes/codes.util.dart';

class CountryCodeUtil {
  List<Map<String, String>> search(String query) {
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
