import Foundation
import FirebaseAuth
import FirebaseDatabase


class SignUpViewModel {
    
    var ref : DatabaseReference!
    
    func signUpAction(userData : User, completion : @escaping (String)-> Void){
        guard let email = userData.email else {return}
        guard let password = userData.password else {return}

        Auth.auth().createUser(withEmail: email, password: password){ (user,error) in
            if user == nil{
                //입력을 하지 않은경우
                if email == "" || password == ""{
                    completion("nil")
                }
                //형식에 맞지않은경우... 중복여부 검사 어케하지...
                completion("SameAccount")
            }else{
                //성공
                guard let uid = user?.user.uid else { return }
                self.ref = Database.database().reference()
                self.ref.child("Users").child(uid).child("info").setValue([
                    "email" : userData.email
                ])
                completion("success")
            }
            
        }
    }
    
    
    

}
