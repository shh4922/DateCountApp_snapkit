import Foundation
import FirebaseAuth

class SettingViewModel {
    
    func onClickLogout() -> Bool{
        let auth = Auth.auth()
        do {
            try auth.signOut()
            UserDefaults.standard.set(false, forKey: "isLogin")
            return true
            
            
        }catch let signOutError {
            return false

        }
    }
}
