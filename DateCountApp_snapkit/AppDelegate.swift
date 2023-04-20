
import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // 알림 권한 요청
        let center = UNUserNotificationCenter.current()
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
        // 매일 00시00분에 알림 발송
           let content = UNMutableNotificationContent()
           content.title = "알림"
           content.body = "오늘의 명언이 도착하였습니다! \n 확인해주세요!"
           content.sound = .default
           
           var dateComponents = DateComponents()
           dateComponents.hour = 3
           dateComponents.minute = 11
           
           let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
           let request = UNNotificationRequest(identifier: "dailyAlarm", content: content, trigger: trigger)
           center.add(request) { error in
               if let error = error {
                   print(error.localizedDescription)
               }
               let notificationCenter = NotificationCenter.default
                   notificationCenter.post(name: Notification.Name("getTextOnFirebase"), object: nil)
               print("AppDelegate 실행!!")
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
    
    
}


