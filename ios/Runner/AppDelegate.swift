import UIKit
import Flutter
import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    // Extra Stuff
    GMSServices.provideAPIKey("AIzaSyCzj49x2EaAt7T3G6fTQQU06m9bwAls2AA")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            let firebaseAuth = Auth.auth()
            firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
    }
}
