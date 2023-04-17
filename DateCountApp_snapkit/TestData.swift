import Foundation

struct TestData {
    let email : String
    var password : String
    
    //사용자가 확인한 명언
    var deleveredData : Array<[Int:String]>? = nil
    
    //사용자가 저장한 명언
    var subscribeData : Array<[Int:String]>? = nil
     
    //사용자가 등록한 시험
//    var tests : [Test]? = nil
}
