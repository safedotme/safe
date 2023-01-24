class TextUtil {
  static const List<Map<String, String>> specialChars = [
    {"‘": "'"},
    {"`": "'"},
    {"“": "\""},
    {"”": "\""},
    {"~": "-"},
    {"¬": "-"},
    {"|": "I"},
    {"ñ": "n"},
    {"ń": "n"},
    {"à": "a"},
    {"á": "a"},
    {"â": "a"},
    {"ä": "a"},
    {"æ": "ae"},
    {"ã": "a"},
    {"å": "a"},
    {"ā": "a"},
    {"è": "e"},
    {"é": "e"},
    {"ê": "e"},
    {"ë": "e"},
    {"ē": "e"},
    {"ė": "e"},
    {"ę": "e"},
    {"ÿ": "y"},
    {"ß": "s"},
    {"ś": "s"},
    {"š": "s"},
    {"ł": "l"},
    {"ž": "z"},
    {"ź": "z"},
    {"ż": "z"},
    {"x": "x"},
    {"ç": "c"},
    {"ć": "c"},
    {"č": "c"},
    {"û": "u"},
    {"ü": "u"},
    {"ù": "u"},
    {"ú": "u"},
    {"ū": "u"},
    {"î": "i"},
    {"ï": "i"},
    {"í": "i"},
    {"ī": "i"},
    {"į": "i"},
    {"ì": "i"},
    {"ô": "o"},
    {"ö": "o"},
    {"ò": "o"},
    {"ó": "o"},
    {"œ": "oe"},
    {"ø": "o"},
    {"ō": "o"},
    {"õ": "o"},
  ];

  String removeSymbols(String value) =>
      value.replaceAll(RegExp(r'[^\w\s]+'), '');

  String removeSpaces(String value) => value.replaceAll(" ", "");

  String removeNumbers(String value) => value.replaceAll(RegExp(r'[\d-]'), '');

  String toCapitalized(String word) => word.isNotEmpty
      ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
      : '';

  String toTitle(String words) => words
      .replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => toCapitalized(str))
      .join(' ');

  static String removeNonUSCChars(String raw) {
    for (final char in specialChars) {
      raw = raw.replaceAll(char.keys.first, char[char.keys.first]!);
    }

    return raw;
  }
}
