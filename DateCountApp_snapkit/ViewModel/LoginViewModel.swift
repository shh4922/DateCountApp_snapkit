import Foundation
import FirebaseAuth
import FirebaseDatabase

class LoginViewModel{
    
    
    func loginAction(user:User, completion: @escaping (String) -> Void){
        guard let email = user.email else { return }
        guard let password = user.password else { return }
        //아이디 패스워드 비어있는값
        Auth.auth().signIn(withEmail: email, password: password){ authResult,error in
            if authResult != nil {
                completion("success")
            }else if error != nil{
                completion("NoAccount")
            }
            else {
                completion("NoAccount")
            }
        }
    }
    
    func loginNoAccount(){
        
        Auth.auth().signInAnonymously { result, error in
            //익명계정 생성
            guard let user = result?.user else { return }
            let isAnonymouse = user.isAnonymous
            let uid = user.uid
            
            //realtimeDB 에 저장
            let userDB = Database.database().reference().child("Users").child(uid)
            userDB.child("info").setValue([
                "key" : uid
            ])
            
            //자동로그인 true
            UserDefaults.standard.set(true, forKey: "isLogin")
            //혹여나를 위한 uid 로컬에 저장
            UserDefaults.standard.set(uid ,forKey: "userKey")
        }
      
    }
    
    
    
}
