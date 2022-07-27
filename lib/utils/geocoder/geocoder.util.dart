class GeocoderUtil {
  String removeTag(String raw) {
    if (!raw.contains("+")) {
      return raw;
    }

    var noPref = raw.substring(raw.indexOf("+"));
    bool shouldIngest = false;
    String address = "";

    for (int i = 0; i < noPref.length; i++) {
      if (shouldIngest) {
        address += noPref[i];
      }

      if (noPref[i] == " ") {
        shouldIngest = true;
      }
    }

    return address;
  }
}
