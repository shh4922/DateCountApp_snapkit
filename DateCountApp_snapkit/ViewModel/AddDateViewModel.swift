import Foundation
import FirebaseAuth
import FirebaseDatabase

class AddDateViewModel {
    
    //새로운 데이터 추가.
    func saveDateToFirebase(selectedDate:String, testName:String){
        guard let uid : String = Auth.auth().currentUser?.uid else{return}
        let ref = Database.database().reference().child("Users").child(uid).child("MyTests").childByAutoId()
            
        let data = [
            "testName": testName,
            "selectedDate": selectedDate,
            "key": ref.key
        ]
        ref.setValue(data)
        //노티로, ListViewController에 요청
        NotificationCenter.default.post(name: Notification.Name("newDataAdded"), object: nil)
    }
    
}
