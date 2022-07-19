class NameUtil {
  String genInitials(String name) => "${name[0]}${name[name.indexOf(" ") + 1]}";
}
