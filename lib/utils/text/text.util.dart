class TextUtil {
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
}
