import Foundation
import FirebaseAuth
import FirebaseDatabase

class SettingViewModel {
    
    func onClickLogout() -> Bool{
        let auth = Auth.auth()
        do {
            try auth.signOut()
            UserDefaults.standard.set(false, forKey: "isLogin")
            return true
        }catch _ {
            return false
        }
    }
    
    func sendEmail() {
        guard let url = URL(string: "mailto:gusgh4922@gmail.com") else{ return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func deleteAccount() -> Bool {
        let user = Auth.auth().currentUser
        do{
            try
            deleteUserDefault()
            deleteRealtimeDB()
            user?.delete()
            return true
        }catch {
            return false
        }
    }
    
    private func deleteUserDefault(){
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
    private func deleteRealtimeDB(){
        guard let uid : String = Auth.auth().currentUser?.uid else{return}
        var db = Database.database().reference().child("Users").child(uid).child("info")
        db.removeValue()
        db = Database.database().reference().child("Users").child(uid).child("MyTests")
        db.removeValue()
        db = Database.database().reference().child("Users").child(uid).child("showedQuote")
        db.removeValue()
    }
}

   
