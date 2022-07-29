class NameUtil {
  String genInitials(String name) =>
      name.isEmpty ? "" : "${name[0]}${name[name.indexOf(" ") + 1]}";

  List<String> divideName(String fullName) => fullName.split(" ");

  String genFirstName(String fullName, bool possessive) {
    var first = divideName(fullName)[0];

    if (!possessive) {
      return first;
    }

    if (first[first.length - 1].toUpperCase() == "S") {
      return "$first'";
    }

    return "$first's";
  }
}
