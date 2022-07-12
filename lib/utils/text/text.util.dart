class TextUtil {
  String removeSymbols(String value) =>
      value.replaceAll(RegExp(r'[^\w\s]+'), '');

  String removeNumbers(String value) => value.replaceAll(RegExp(r'[\d-]'), '');
}
