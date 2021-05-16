import Fluent
import Vapor

final class Book: Model, Content {
    static let schema = "books"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "author")
    var author: UUID 

    init() {
        //pass
    }

    init(id: UUID? = nil, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = UUID(uuidString: author)!
    }
}
