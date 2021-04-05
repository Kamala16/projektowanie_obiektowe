import Fluent
import Vapor

final class Owner: Model, Content {
    static let schema = "owners"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "Name")
    var name: String 

    @Field(key: "City")
    var city: String 

    init() { }

    init(id: UUID? = nil, name: String, city: String) {
        self.id = id
        self.name = name
        self.city = city
    }
}
