import Foundation

struct ShowedQuote :Hashable{
    var author : String?
    var quote : String?
    var isLike : Int?
    
    init(author: String?, quote: String?, isLike : Int) {
        self.author = author
        self.quote = quote
        self.isLike = isLike
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(quote)
        hasher.combine(author)
    }
    
    static func == (lhs: ShowedQuote, rhs: ShowedQuote) -> Bool {
        return lhs.quote == rhs.quote && lhs.author == rhs.author
    }
}
