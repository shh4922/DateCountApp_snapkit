import Foundation

struct TestData {
    let email : String
    var password : String
    
    //사용자가 확인한 명언
    var deleveredData : Array<[String:String]>? = nil
    
    //사용자가 저장한 명언
    var subscribeData : Array<[String:String]>? = nil
    
    init(email: String, password: String, deleveredData: Array<[String : String]>? = nil, subscribeData: Array<[String : String]>? = nil) {
        self.email = email
        self.password = password
        self.deleveredData = deleveredData
        self.subscribeData = subscribeData
    }
}
