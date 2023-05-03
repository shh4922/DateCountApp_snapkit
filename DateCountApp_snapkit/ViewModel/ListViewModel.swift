import Foundation
import FirebaseDatabase
import FirebaseAuth

class ListViewModel {
    
    let decoder = JSONDecoder()
    var userDataAry = [Testmodel]()
    
    //DB에서 시험일정 데이터 받아오기.
    func loadTestData(completion : @escaping ([Testmodel]) -> Void){
        guard let uid : String = Auth.auth().currentUser?.uid else{return}
        let db = Database.database().reference().child("Users").child(uid).child("MyTests")
        
        db.observeSingleEvent(of: .value){snapshot  in
            guard let snapData = snapshot.value as? [String:[String:String]] else {return}
            guard let data = try? JSONSerialization.data(withJSONObject: Array(snapData.values), options: []) else { return }
            do {
                self.userDataAry = try self.decoder.decode([Testmodel].self, from: data)
                self.userDataAry = self.userDataAry.sorted(by: { $0.selectedDate < $1.selectedDate })
                completion(self.userDataAry)
            }catch{
                return
            }
        }
    }
    
    //셀의 개수 리턴
    func returnCellCount() -> Int{
        return userDataAry.count
    }
    
    // DB에서 해당데이터 삭제.
    func removeFromFirebase(index : IndexPath.ArrayLiteralElement){
        guard let key = userDataAry[index].key else { return }
        guard let uid : String = Auth.auth().currentUser?.uid else { return }
        let rootRef = Database.database().reference().child("Users").child(uid).child("MyTests").child(key)
        rootRef.removeValue()
    }
    
    //등록날짜 와 현재날짜를 비교하여, 남은날짜를 계산하는 함수.
    func countDate(selectedDate : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let selectedDate_ = dateFormatter.date(from: selectedDate) else{ return "" }
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        //아래코드는 시간차로 인한 날짜오류가 생겨서, 달력날짜를 기준으로 두 날의 차이를 계산하기위해 만들어줌.
        let stactOfselectedDate = calendar.startOfDay(for: selectedDate_)
        let stactOfcurrentDate = calendar.startOfDay(for: currentDate)
        
        let dateComponents = calendar.dateComponents([.day], from: stactOfcurrentDate, to: stactOfselectedDate)
        
        guard let dayDifference = dateComponents.day else { return ""}
        if dayDifference == 0{
            return " day"
        }else if dayDifference > 0 {
            return "\(dayDifference)"
        }else{
            return " 마감"
        }
        
    }
    
    
    
    
    
    
    
}



