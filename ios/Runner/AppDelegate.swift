import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    GMSServices.provideAPIKey("AIzaSyDn5Hi2hO8QBH-jdjAHPjbZbE_RB6T0_oA")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
