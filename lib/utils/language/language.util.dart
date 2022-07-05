enum Languages {
  english,
}

class LanguageUtil {
  late Map<Languages, Map> langMap;
  void initMap() => langMap = {
        Languages.english: english,
      };

  Map english = {
    "welcome": {
      "signupButton": "Create an account",
      "loginButton": "I already have one",
    },
  };
}
