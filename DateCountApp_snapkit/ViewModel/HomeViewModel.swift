import Foundation
import Firebase


class HomeViewModel {
    let decoder = JSONDecoder()
    
    func loadTestData(completion : @escaping ([DateModel]) -> Void){
        var userDataAry = [DateModel]()
        guard let uid : String = Auth.auth().currentUser?.uid else{return}
        let db = Database.database().reference().child("Users").child(uid).child("MyTests")
        
        let group = DispatchGroup()
        
        group.enter()
        db.observeSingleEvent(of: .value){snapshot  in
            //여기서 이미 없으면 함수종료.
            guard let snapData = snapshot.value as? [String:[String:String]] else {return}
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            do {
                let dataList = try self.decoder.decode([DateModel].self, from: data)
                let data = dataList.sorted(by: { $0.selectedDate < $1.selectedDate })
                completion(data)
            }catch{
                print("에러")
            }
        }
        group.leave()
        
        group.notify(queue: .main){
            
        }
    }
    
    
}
