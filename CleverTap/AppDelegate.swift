
import UIKit
import CleverTapSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        CleverTap.autoIntegrate()
        if #available(iOS 10.0, *) {
                    let center  = UNUserNotificationCenter.current()
            center.delegate = self
                    center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                        if error == nil{
                            DispatchQueue.main.async {
                              UIApplication.shared.registerForRemoteNotifications()
                            }
                        }
                    }

                }
                else {
                    UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
                    UIApplication.shared.registerForRemoteNotifications()
                }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let deviceTokenString = deviceToken.hexString
        print(deviceToken)
        print("deviceToken", deviceToken)
        CleverTap.sharedInstance()?.setPushToken(deviceToken as Data)
    }
    
    
   
    
    /** For iOS 10 and above - Background **/
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            
        CleverTap.sharedInstance()?.handleNotification(withData: response.notification.request.content.userInfo)
        completionHandler()
            
    }
    
    
    /** For iOS 10 and above - Foreground**/

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           CleverTap.sharedInstance()?.handleNotification(withData: notification.request.content.userInfo, openDeepLinksInForeground: true)
           completionHandler([.banner, .list, .sound])
       }
    
    
    func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
        print("Push Notification Tapped with Custom Extras: \(String(describing: customExtras))")
        
    }
    

    
}

