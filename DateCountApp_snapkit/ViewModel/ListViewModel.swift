import Foundation
import Firebase

class ListViewModel {
    var random : Quote? = nil
    
    //모든 명언을 가져오는 함수
    func getAllQuote() -> [Quote] {
        var fullData : [Quote] = []
        
        let TextDB = Database.database().reference().child("textdata")
        
        TextDB.observeSingleEvent(of: .value){ snapshot in
            var Data = Quote(author: nil, quote: nil)
            for child in snapshot.children {
                
                guard let snap = child as? DataSnapshot else { return }
                guard let text = snap.childSnapshot(forPath: "text").value as? String else { return }
                guard let author = snap.childSnapshot(forPath: "author").value as? String else { return }
                
                Data.quote = text.applyingTransform(.init("Any-Hex/Java"), reverse: true) ?? text
                Data.author = author.applyingTransform(.init("Any-Hex/Java"), reverse: true) ?? author
                
                fullData.append(Data)
            }
        }
        return fullData
    }
    
    func checkQouteData(fullData:[Quote],showedData : [Quote]) -> Bool {
        let firstSet = Set(fullData)
        let secondSet = Set(showedData)
        let randomData = firstSet.subtracting(secondSet).randomElement()
        
        guard let uid : String = Auth.auth().currentUser?.uid else{return false}
        let DeleveredDB = Database.database().reference().child("Users").child(uid).child("info").child("deleveredData")
        
        if randomData == nil{
            return false
        }else{
            random =  randomData
            return true
        }
    }
    
    func saveToFirebase(){
        guard let uid : String = Auth.auth().currentUser?.uid else { return }
        let DeleveredDB = Database.database().reference().child("Users").child(uid).child("info").child("deleveredData")
        
        DeleveredDB.childByAutoId().setValue([
            "text" : random?.quote,
            "author" : random?.author
        ])
    }
    
    func saveToLoacl(){
        UserDefaults.standard.set(
            [
                "text" : random?.quote,
                "author" : random?.author
            ],
            forKey: "myDictionary"
        )
    }
    
    //기존에 봤던 명언을 가져오는 함수
    func getShowedQuote() -> [Quote]{
        var Data = Quote(author: nil, quote: nil)
        guard let uid : String = Auth.auth().currentUser?.uid else { return []}
        
        let DeleveredDB = Database.database().reference().child("Users").child(uid).child("info").child("deleveredData")
        var showedData : [Quote] = []
        
        DeleveredDB.observeSingleEvent(of: .value) { snapshot in
           
            
            for child in snapshot.children{
                guard let snap = child as? DataSnapshot else { return }
                guard let text = snap.childSnapshot(forPath: "text").value as? String else { return }
                guard let author = snap.childSnapshot(forPath: "author").value as? String else { return }
                
                Data.quote = text.applyingTransform(.init("Any-Hex/Java"), reverse: true) ?? text
                Data.author = author.applyingTransform(.init("Any-Hex/Java"), reverse: true) ?? author
                showedData.append(Data)
            }
        }
        return showedData
    }
    
}


