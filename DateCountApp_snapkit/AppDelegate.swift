import UIKit
import FirebaseAuth
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        //앱을 처음 다운받고 처음 실행했을때
        if UserDefaults.standard.object(forKey: "isSendedText") == nil {
            UserDefaults.standard.set(true, forKey: "isSendedText")
            UserDefaults.standard.set("09", forKey: "hour")
            UserDefaults.standard.set("00", forKey: "minute")
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

            }
        }
    }
    func Alter(){
        let content = UNMutableNotificationContent()
        content.title = "매일 명언 알림"
        content.body = "새로운 명언이 도착했습니다."
        content.sound = .default
        
        var dateComponents = DateComponents()
        guard let hour = UserDefaults.standard.string(forKey: "hour") else { return }
        guard let minute = UserDefaults.standard.string(forKey: "minute") else { return }
        
        dateComponents.hour = Int(hour)
        dateComponents.minute = Int(minute)
        
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



