import Foundation
import FirebaseAuth
import FirebaseDatabase

class AllQuoteViewModel {
    
    var showedData = [ShowedQuote]()
    
    func loadQuoteData(competition : @escaping ([ShowedQuote])->Void){
        guard let uid : String = Auth.auth().currentUser?.uid else { return}
        let DeleveredDB = Database.database().reference().child("Users").child(uid).child("showedQuote")
        
        let group = DispatchGroup()
        group.enter()
        
        DeleveredDB.observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children{
                
                guard let snap = child as? DataSnapshot else { return }
                
                guard let text = snap.childSnapshot(forPath: "quote").value as? String else { return }
                guard let author = snap.childSnapshot(forPath: "author").value as? String else { return }
                guard let isLike = snap.childSnapshot(forPath: "isLike").value as? Int else { return }
                
                let data2 = ShowedQuote(author: author, quote: text, isLike: isLike)
                self.showedData.append(data2)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.showedData = self.showedData.sorted(){
                $0.isLike! > $1.isLike!
            }
            competition(self.showedData)
        }
    }
    
    
    
    func onClickLike(cell:AllQuoteTableViewCell){
        guard let quote_ = cell.quoteLabel.text else {return}
        guard let uid : String = Auth.auth().currentUser?.uid else { return}
        
        let DeleveredDB = Database.database().reference().child("Users").child(uid).child("showedQuote")
        
        DeleveredDB.observeSingleEvent(of: .value){ result in
            for child in result.children{
                guard let snap = child as? DataSnapshot else { return }
                guard let text = snap.childSnapshot(forPath: "quote").value as? String else { return }
                guard let isLike = snap.childSnapshot(forPath: "isLike").value as? Int else { return }
                
             
                if text == quote_ {
                    if isLike == 1 {
                        let ref = DeleveredDB.child(snap.key)
                        ref.updateChildValues(["isLike" : 0])
                        
                    }else{
                        let ref = DeleveredDB.child(snap.key)
                        ref.updateChildValues(["isLike" : 1])
                        

                    }
                }
                
                
            }
        }
    }
    
    
}
