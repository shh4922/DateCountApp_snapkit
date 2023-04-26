import Foundation
import Firebase

class AddDateViewModel {
    
    func saveDateToFirebase(selectedDate:String, testName:String){
        guard let uid : String = Auth.auth().currentUser?.uid else{return}
        let ref = Database.database().reference().child("Users").child(uid).child("MyTests").childByAutoId()
        
        let data = [
            "testName": testName,
            "selectedDate": selectedDate
        ]
        ref.setValue(data)
        NotificationCenter.default.post(name: Notification.Name("newDataAdded"), object: nil)
    }
}
