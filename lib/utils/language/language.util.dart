import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/services/analytics/analytics.service.dart';
import 'package:safe/utils/credit/credit.util.dart';
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
      "firebase_errors": {
        "no-phone-number": {
          "header": "Hold up! You forgot to add your phone number",
          "desc": "This will be used to verify your account later on",
        },
        "invalid-phone-number": {
          "header": "Hold up! You're phone number is invalid",
          "desc": "Check your phone number before continuing",
        },
        "invalid-verification-code": {
          "header": "Hold up! The verification code you entered is invalid",
          "desc": "Check your messages for the latest OTP code"
        },
        "user_disabled": {
          "header": "Your account has been desabled",
          "desc": "Tap here to reach out to Safe's support team"
        },
        "default": {
          "header": "Oops, we've run into a problem signing you in",
          "desc": "Try signing {action} again later"
        },
      },
      "name_input": {
        "error-emptyField/title": "Hold up! You forgot to add your name",
        "error-emptyField/desc": "Please provide your full real name",
        "error-lastName/title": "Hold up! You forgot to add your last name",
        "error-lastName/desc": "Please provide your full real name",
        "hintName": "Your name",
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
        "desc": "We'll send you a SMS code to verify your\n account",
        "buttonText": "Send SMS",
        "terms":
            "By creating an account, you agree to Safe's terms of service. Click here to read them.",
        "smsSentMsg": {
          "header": "SMS sent to {PHONE}",
          "body": "Check your SMS messages.",
        },
        "loader": "Creating account"
      }
    },
    "widgets": {
      "emergency_contacts_popup": {"no_name_hint_text": "Your contact name"}
    },
    "country_code_selector": {
      "search_hint": "Search",
      "header": "Country Codes",
      "load_error": "Unable to load",
      "country_not_found": {
        "header": "Country Not Found",
        "desc": ["No worries! Request a country ", "here", " 🙂"]
      }
    },
    "otp_input_panel": {
      "attempts_error": "Run out of SMS attempts. Try again later",
      "header": "Enter Code",
      "desc": "Please enter the code sent to\n {phone}",
      "secured_by_stamp": "Secured by Google",
      "next_code": "Next code available in {time}s",
      "resend_code": "Tap to resend code",
    },
    "home": {
      "header": "Tap to Safe",
      "header_disabled": "Safe Disabled",
      "incident_recorded_header": {
        true: "Error Capturing Incident",
        false: "Incident Captured",
      },
      "acc_created": {
        "header": "Account Created",
        "subheader": "Try activating Safe",
        "desc":
            "This way, you'll know what to expect in an incident. PS, we won't notify anyone. ",
      },
      "incident_limit": {
        "header": {
          LimitErrorState.emergency: "Incident Limit Reached",
          LimitErrorState.permissions: "Missing Permissions",
          LimitErrorState.maxed: "Incident Limit Reached",
          LimitErrorState.missingContacts: "Missing Contacts",
          LimitErrorState.noConnection: "No Connection",
          null: "",
        },
        "body": {
          LimitErrorState.emergency:
              "You have one incident credit left. Spare it for an emergency. Tap here to activate Safe.",
          LimitErrorState.noConnection:
              "We cannot capture an incident without an internet connection. Try checking your connection.",
          LimitErrorState.maxed:
              "No worries, simply delete a previous incident to gain back the ability to capture one.",
          LimitErrorState.missingContacts:
              "Without contacts, no one will be notified when you activate Safe.",
          LimitErrorState.permissions:
              "Enable the {permission} in Settings. Without them, we won't be able to capture incidents.",
          null: ""
        },
        "button": {
          LimitErrorState.emergency: "Emergency Activate",
          LimitErrorState.maxed: "Delete an Incident",
          LimitErrorState.missingContacts: "Add Contacts",
          LimitErrorState.permissions: "Go to Settings",
          LimitErrorState.noConnection: "Go to Settings",
          null: ""
        },
      }
    },
    "contacts": {
      "types": {
        MessageType.start: "Incident Started ✅",
        MessageType.end: "Incident Ended ✅",
        MessageType.batteryCrit: "Battery Low Alert ✅",
      },
      "notified_msg": "{CONTACT} was notified at {TIME}",
    },
    "tutorial": {"button": "Add a Contact"},
    "incident_log": {
      "header": "Incident Log",
      "counter": "{count} Incidents",
      "subheader": "All Incidents",
      "contacts_button": "Contacts",
      "settings_button": "Settings",
      "empty": {
        "header": "No Incidents",
        "desc":
            "There are no inicdents tied to this account. Tap on the Safe button to document one.",
      }
    },
    "play": {
      "errors": {"load_failed": "Unable to load location."},
      "data_box": {
        "battery": {
          "header": "Battery",
          "state": {
            "critical": "CRITICAL",
            "low": "LOW",
            "normal": "NORMAL",
            "high": "HIGH",
          }
        },
        "speed": {
          "header": "Speed",
        },
      }
    },
    "incident_card": {
      "secured": "Secured",
    },
    "settings": {
      "message":
          '"Our lives begin to end the day we become silent about things that matter" -MLK',
      "header": "Settings",
      "version": "Version {VERSION} - Production",
      "preferences": {
        "header": "Preferences",
        "change_phone": {
          "header": "Change Phone Number",
          "popup": {
            "header": "Change Phone",
            "body":
                "Changing your phone number is currently unavailable through the app. Notify the team and we'll help you out through SMS ({PHONE})!",
            "cancel": "Cancel",
            "notify_success": "The team has been notified!",
            "notify": "Notify",
          }
        },
        "quality": {
          "header": "Capped Video Quality",
          "loading": "Loading quality...",
          "template": "High ({DIMENSION}p)"
        },
        "biometrics": {
          "header": "Enable Face ID",
          "failed_msg": "Face ID failed. Try again",
          "unavailable": "Face ID is unavailable",
          "enable_reason": "Authenticate to enable service",
          "disable_reason": "Authenticate to disable service",
        }
      },
      "support": {
        "header": "Support",
        "about": {
          "header": "About",
          "terms": "Terms of Service",
          "privacy": "Privacy Policy",
          "collaborators": "Collaborators",
          "media_kit": "Media Kit",
        },
        "help": "Help",
        "feedback": "Give feedback"
      },
      "danger": {
        "header": "Danger Zone",
        "sign_out": {
          "header": "Sign Out",
          "modal": {
            "header": "Sign Out",
            "desc": "Are you sure you want to sign out?",
            "button": "Sign Out",
            "cancel": "Cancel",
          },
          "overlay": "Signing out",
        },
        "delete_acc": {
          "header": "Delete Account",
          "modal": {
            "header": "Delete Account",
            "desc":
                "Deleting an account is currently unavailable due to the highly sensitive nature of Safe accounts and the information they store. We're actively working on finding a secure way make this possible.",
            "button": "Ok",
          },
        },
      },
      "story": {
        "header": "The Safe Story",
        "body":
            "The Safe App is a social impact venture developed by Mark Music (a high school student). Tap here to learn more.",
      },
      "reach_out": {
        "header": "Reach Out",
        "rate": "❤️\tRate the app",
        "twitter": "🐦\tFollow on Twitter",
        "github": "💫\tStar on GitHub",
        "email": "📧\tShoot us an email",
      },
    },
    "incident": {
      "auth": {
        "reason": "Authenticate to view incident",
        "error": "Unable to authenticate. Try again.",
      },
      "loading": "Loading incident",
      "downloading_loader": "Exporting incident",
      "downloading_failed": "Exporting failed",
      "tutorial_contact_warning": {
        "header": "⚠️ NOTE",
        "desc":
            "These contacts were not notified as the incident was a tutorial. They would have been notified if it weren't.",
      },
      "contacts": {
        "header": "Notified Contacts",
        "notify_tag": "Notified",
      },
      "processing_loader": {
        "header": "Processing Incident",
        "description": {
          true:
              "The team has been notified! We'll get back to you shortly through SMS ({PHONE}).",
          false:
              "This usually takes between {MIN} to {MAX} minutes.\nBeen a while? Let us know by tapping here and we'll get back to you with an update through SMS.",
        }
      },
      "play_button": {
        "timeline": "Play Timeline",
        "video": "Play Video",
        "map_view": "Play Map View",
      },
      "location_opt": {"copy": "Copy"},
      "recorded_data": {
        "download": "Download",
        "header": "Recorded Data",
        "location": {
          "key": "Location",
          "clipboard_msg":
              "Address: {address}\nLatitude: {lat}\nLongitude:{long}",
          "copied_msg": {
            "success": "Copied address",
          }
        },
        "date": {
          "key": "Date & Time",
          "clipboard_msg":
              "Date: {DATE}\nIncident began at {TIME_START} \nIncident ended at {TIME_END}",
          "copied_msg": {
            "err": "Unable to copy time",
            "success": "Copied time",
          },
        },
        "backup": {
          "key": "BACKUPS",
          "header": "Fully Secure",
          "subheader": "Powered by Google"
        },
      },
    },
    "contact": {
      "input": {
        "errors": {
          "load": "Unable to load contact.",
        },
        "header": "Import Contacts",
        "desc": "To import, press on the contact's phone number",
        "buttons": {
          "import": "Import",
          "manual": "Add manually",
        }
      },
      "header": "Contacts",
      "errors": {
        "capped": "Sorry! Contacts are capped at {AMMOUNT} per person.",
        "min": "You must have at least one contact.",
      },
      "add_button": "Add contact",
      "edit_button": {
        "done": "Done",
        "edit": "Edit",
      },
      "editor": {
        "auth_reason": "Authenticate to add contact",
        "auth_failed": "FaceID failed. Try again",
        "phone_invalid": "Phone number is invalid",
        "success": "Contact saved!",
        "contact_errors": {
          "error-emptyField": "To save, name your contact.",
          "error-lastName": "To save, add a last name.",
        },
        "primary_button": {
          "save": "Save",
          "add": "Add Contact",
        },
        "cancel": "Cancel",
      },
      "action_sheet": {
        "auth_reason": "Authenticate to remove contact",
        "auth_unavailable": "Unable to authenticate. Try again",
        "edit": "Edit Info",
        "remove": "Remove",
        "cancel": "Cancel"
      }
    },
    "capture": {
      "hint": [
        "Swipe down to hide the controls",
        "Tap on camera feed to enlarge it",
        "Safe has activated. Stay safe",
      ],
      "errors": {
        ErrorLogType.rtcFailed:
            "The video stream could not be initialized. Check your internet connection and try capturing again.",
        ErrorLogType.mediaServerFailed:
            "The video stream ended abruptly. Check your internet connection and try capturing again.",
        ErrorLogType.twilioFailed:
            "Your contacts could not be notified. Check your internet connection and try capturing again.",
      },
      "controls": {
        "flip_camera": {"header": "Flip Camera"},
        "flash": {"header": "Flashlight {STATE}"},
        "stop": {"header": "Stop Recording"},
        "stop_alert": {
          "header": "Stop Recording",
          "content":
              "This will stop location and camera streams and upload data to the cloud",
          "cancel": "Cancel",
          "confirm": "Confirm"
        }
      },
      "loader": "Uploading content",
    }
  };
}
