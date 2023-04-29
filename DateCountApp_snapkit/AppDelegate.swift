import UIKit
import Firebase
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        //         앱이 처음 실행될 때만 isSendedText를 true로 설정
        if UserDefaults.standard.object(forKey: "isSendedText") == nil {
            UserDefaults.standard.set(true, forKey: "isSendedText")
        }
        setUpAlter()
        Alter()
        
        return true
    }
    
    func setUpAlter(){
        // 알림 권한 요청
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if granted {
                print("알림 권한이 승인되었습니다.")
            } else {
                print("알림 권한이 거부되었습니다.")
            }
        }
    }
    func Alter(){
        let content = UNMutableNotificationContent()
        content.title = "매일 명언 알림"
        content.body = "새로운 명언이 도착했습니다."
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 10
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    //문제가 20초정도 딜레이가 있음.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "dailyNotification" {
            UserDefaults.standard.set(true, forKey: "isSendedText")
        }
        completionHandler()
    }
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    
}



