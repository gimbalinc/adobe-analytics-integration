import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GimbalAdobeAnalyticsAdapter.sharedInstance.startGimbalAndLogEvents("PUT_YOUR_GIMBAL_API_KEY_HERE", debugLoggingEnabled: true)
        self.localNotificationPermission()
        return true
    }
    
    func localNotificationPermission() -> Void {
        let types : UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound]
        let settings : UIUserNotificationSettings = UIUserNotificationSettings(types: types, categories:nil)
        let app = UIApplication.shared
        app.registerUserNotificationSettings(settings)
    }
}

