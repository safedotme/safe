class NameUtil {
  String genInitials(String name) =>
      name.isEmpty ? "" : "${name[0]}${name[name.indexOf(" ") + 1]}";
}
