class GeocoderUtil {
  String removeTag(String raw) {
    if (!raw.contains("+")) {
      return raw;
    }

    String untagged = "";
    bool shouldIngest = false;

    for (int i = 0; i < raw.length; i++) {
      if (shouldIngest) {
        untagged += raw[i];
      }

      if (raw[i] == ",") {
        shouldIngest = true;
      }
    }

    return untagged.replaceFirst(" ", "");
  }
}
