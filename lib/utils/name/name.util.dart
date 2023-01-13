class NameUtil {
  String genInitials(String name) {
    if (name.isEmpty) return "";

    if (!name.contains(" ")) return name[0].toUpperCase();

    List<String> components = name.split(" ");

    if (components.length == 1) return name[0].toUpperCase();

    if (components.length == 2 &&
        name.replaceAll(components.first, "") == " ") {
      return name[0].toUpperCase();
    }

    return "${name[0]}${name[name.indexOf(" ") + 1]}".toUpperCase();
  }

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
