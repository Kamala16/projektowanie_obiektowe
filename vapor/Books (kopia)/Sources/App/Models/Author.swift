import Fluent
import Vapor

final class Author: Model, Content {
    static let schema = "authors"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "Name")
    var name: String

    init() {
        //pass
    }

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
