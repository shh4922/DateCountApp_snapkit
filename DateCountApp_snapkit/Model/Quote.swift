import Foundation

struct Quote :Hashable{
    var author : String?
    var quote : String?
    
    init(author: String?, quote: String?) {
        self.author = author
        self.quote = quote
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(quote)
        hasher.combine(author)
    }
    
    static func == (lhs: Quote, rhs: Quote) -> Bool {
        return lhs.quote == rhs.quote && lhs.author == rhs.author
    }
}
