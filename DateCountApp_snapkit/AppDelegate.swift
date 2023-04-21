
import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        setUpAlter()
        // 매일 00시00분에 알림 발송
        Alter()
        
        return true
    }
    
    func setUpAlter(){
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
    }
    func Alter(){
        let content = UNMutableNotificationContent()
        content.title = "알림"
        content.body = "오늘의 명언이 도착하였습니다! \n 확인해주세요!"
        content.sound = .default
        
        var components = DateComponents()
        components.hour = 0
        components.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        /*
         UNNotificationRequest 는 클라이언트에게 푸쉬알람을 주는 함수이다.
         identifier는 뭔지 모르겠지만 UserDefault처럼 따로 설정해주는게 아닐까 싶다. ->
         또한 content는 알람이다보니깐, 해당알람에 들어갈 title과 body를 만들어서 전달해준다. 그렇기때문에 위에서 지정해준것.
         trigger는 알람이 올 시간과, 반복여부를 담고있는 UNCalendarNotificationTrigger 이다!
         */
        let request = UNNotificationRequest(identifier: "DailyQuote", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding daily quote notification: \(error.localizedDescription)")
            } else {
                UserDefaults.standard.set(true, forKey: "isSendedText")
            }
        }
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


