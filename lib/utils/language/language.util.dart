import 'package:safe/widgets/mutable_permission_card/mutable_permission_card.widget.dart';

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
    "auth": {
      "name_input": {
        "error-emptyField/title": "Hold up! You forgot to add your name",
        "error-emptyField/desc": "Please provide your full real name",
        "error-lastName/title": "Hold up! You forgot to add your last name",
        "error-lastName/desc": "Please provide your full real name",
        "hintNames": [
          "Chandler Bing",
          "Ted Mosby",
          "Eleven Hopper",
          "Elle Woods",
          "Regina George",
          "Merideth Grey",
          "Joe Goldberg",
          "Derek Shepard",
          "Daenerys Targaryen",
          "Erlich Bachman"
        ],
        "title": "What should we call you?",
        "desc":
            "Please provide your full real name. It's\nimportant for others to identify you.",
        "buttonText": "Next"
      },
      "permissions": {
        "title": "Enable Permissions",
        "desc": "We'll need you to allow a few permissions\nto get started",
        "buttonText": "Next",
        "cards": {
          PermissionType.camera: {
            "header": "Camera",
            "desc": "To record and stream your incidents",
          },
          PermissionType.microphone: {
            "header": "Microphone",
            "desc": "To record and stream your incidents",
          },
          PermissionType.location: {
            "header": "Location",
            "desc": "To keep track of your location in incidents",
          },
        },
        "errors": {
          PermissionType.location: {
            "limited": {
              "header": "Warning: you granted low accuracy location",
              "desc":
                  "Your exact location can be critical during an incident. Tap to change",
              "fatal": false,
            },
            "denied": {
              "header": "Hold up! You denied location access to Safe",
              "desc": "Learn more about why Safe needs location access",
              "fatal": true,
            },
            "default": {
              "header": "Hold up! You denied location access to Safe",
              "desc": "Change this through settings. Tap here to change",
              "fatal": true,
            }
          },
          PermissionType.microphone: {
            "denied": {
              "header": "Hold up! You denied microphone access to Safe",
              "desc": "Learn more about why Safe needs microphone access",
              "fatal": true,
            },
            "default": {
              "header": "Hold up! You denied microphone access to Safe",
              "desc": "Change this through settings. Tap here to change",
              "fatal": true,
            },
          },
          PermissionType.camera: {
            "denied": {
              "header": "Hold up! You denied camera access to Safe",
              "desc": "Learn more about why Safe needs camera access",
              "fatal": true,
            },
            "default": {
              "header": "Hold up! You denied camera access to Safe",
              "desc": "Change this through settings. Tap here to change",
              "fatal": true,
            }
          }
        }
      },
      "phone_verification": {
        "title": "Enter Phone Number",
        "desc": "We'll send you a magic link to verify your\n account",
        "buttonText": "Send Link",
      }
    },
    "country_code_selector": {
      "search_hint": "Search",
      "header": "Country Codes",
      "load_error": "Unable to load",
      "country_not_found": {
        "header": "Country Not Found",
        "desc": ["No worries! Request a country ", "here", " 🙂"]
      }
    }
  };
}
