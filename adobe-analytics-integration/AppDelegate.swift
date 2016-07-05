import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        GimbalAdobeAnalyticsAdapter.sharedInstance.startGimbalAndLogEvents("PUT_YOUR_GIMBAL_API_KEY_HERE", debugLoggingEnabled: true)
        self.localNotificationPermission()
        return true
    }
    
    func localNotificationPermission() -> Void {
        let types : UIUserNotificationType = [UIUserNotificationType.Badge, UIUserNotificationType.Alert, UIUserNotificationType.Sound]
        let settings : UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories:nil)
        let app = UIApplication.sharedApplication()
        app.registerUserNotificationSettings(settings)
    }
}

