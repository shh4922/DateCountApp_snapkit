import Foundation
import Firebase

class LoginViewModel{
    
    
    func loginAction(user:User, completion: @escaping (String) -> Void){
        guard let email = user.email else { return }
        guard let password = user.password else { return }
        //아이디 패스워드 비어있는값
        Auth.auth().signIn(withEmail: email, password: password){ authResult,error in
            if let e = error{
                completion("NoAccount")
            }else{
                completion("success")
            }
        }
    }
    
    
    
}
