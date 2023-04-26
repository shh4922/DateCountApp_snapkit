import Foundation
import Firebase

class HomeViewModel {
    
    let decoder = JSONDecoder()
    var userDataAry = [DateModel]()
    
    func loadTestData(completion : @escaping ([DateModel]) -> Void){
        guard let uid : String = Auth.auth().currentUser?.uid else{return}
        let db = Database.database().reference().child("Users").child(uid).child("MyTests")
        
        
        db.observeSingleEvent(of: .value){snapshot  in
            guard let test = snapshot.key as? String else {return}
            print(test)
            guard let snapData = snapshot.value as? [String:[String:String]] else {return}
            guard let data = try? JSONSerialization.data(withJSONObject: Array(snapData.values), options: []) else { return }
            do {
                
                self.userDataAry = try self.decoder.decode([DateModel].self, from: data)
                self.userDataAry = self.userDataAry.sorted(by: { $0.selectedDate < $1.selectedDate })
                completion(self.userDataAry)
            }catch{
                return
            }
        }
    }
    
    func returnCellCount() -> Int{
        return userDataAry.count
    }
    
    
    func removeFromFirebase(){
//        let rootRef = Database.database().reference().child("Users").child(uid).child("MyTests")
        
    }
}


