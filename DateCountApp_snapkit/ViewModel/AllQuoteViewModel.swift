import Foundation
import FirebaseAuth
import FirebaseDatabase

class AllQuoteViewModel {
    
    var showedData = [Quote]()
    
    func loadQuoteData(competition : @escaping ([Quote])->Void){
        guard let uid : String = Auth.auth().currentUser?.uid else { return}
        let DeleveredDB = Database.database().reference().child("Users").child(uid).child("showedQuote")
        
        let group = DispatchGroup()
        group.enter()
        
        DeleveredDB.observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children{
                guard let snap = child as? DataSnapshot else { return }
                
                guard let text = snap.childSnapshot(forPath: "quote").value as? String else { return }
                guard let author = snap.childSnapshot(forPath: "author").value as? String else { return }
                let data2 = Quote(author: author, quote: text)
                self.showedData.append(data2)
                
            }
            group.leave()
            
        }
        
        group.notify(queue: .main) { competition(self.showedData) }
        
    }
    
    
    
    
}
