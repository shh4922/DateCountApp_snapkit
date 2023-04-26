import Foundation
import Firebase

class ListViewModel {
    
    func returnRandomQuote(_ allQuote:[Quote],_ showedQuote:[Quote]) -> Quote?{
        let allQuote_ = Set(allQuote)
        let showedQuote_ = Set(showedQuote)
        let result = allQuote_.subtracting(showedQuote_).randomElement()
        return result
    }
    
    func loadQuoteData(competition : @escaping ([Quote],[Quote])->Void){
        guard let uid : String = Auth.auth().currentUser?.uid else { return}
        let DeleveredDB = Database.database().reference().child("Users").child(uid).child("info").child("deleveredData")
        let TextDB = Database.database().reference().child("textdata")
        
        
        //전체명언 데이터를 받아서 담을 곳
        var fullData : [Quote] = []
        //이미봤던 명언 데이터를 받아서 담을곳
        var showedData : [Quote] = []
        
        //비동기처리할 애들을 그룹으로묶어서 마지막에  두 데이터를 비교하기위해
        let group = DispatchGroup()
        
        group.enter()
        //AllData
        TextDB.observeSingleEvent(of: .value){ snapshot in
            for child in snapshot.children {
                
                guard let snap = child as? DataSnapshot else { return }
                guard let quote = snap.childSnapshot(forPath: "quote").value as? String else { return }
                guard let author = snap.childSnapshot(forPath: "author").value as? String else { return }
                
                let data1 = Quote(author: author, quote: quote)
                
                fullData.append(data1)
            }
            
            group.leave()
        }
        
        group.enter()
        //showedData
        DeleveredDB.observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children{
                guard let snap = child as? DataSnapshot else { return }
                
                guard let text = snap.childSnapshot(forPath: "quote").value as? String else { return }
                guard let author = snap.childSnapshot(forPath: "author").value as? String else { return }
                let data2 = Quote(author: author, quote: text)
                showedData.append(data2)
                
            }
            group.leave()
            
        }
        
        group.notify(queue: .main) { competition(fullData,showedData) }
        
    }
    
    
    func saveToFirebase(quoteData : Quote){
        guard let uid : String = Auth.auth().currentUser?.uid else { return }
        let DeleveredDB = Database.database().reference().child("Users").child(uid).child("info").child("deleveredData")
        
        DeleveredDB.childByAutoId().setValue([
            "quote" : quoteData.quote,
            "author" : quoteData.author
        ])
        print("파베에 저장할 명언은 \(quoteData)")
    }
    
    func saveToLoacl(quoteData : Quote){
        UserDefaults.standard.set(
            [
                "text" : quoteData.quote,
                "author" : quoteData.author
            ],
            forKey: "myDictionary"
        )
        print("로컬에 저장할 명언은 \(quoteData)")
    }
    
    
}



