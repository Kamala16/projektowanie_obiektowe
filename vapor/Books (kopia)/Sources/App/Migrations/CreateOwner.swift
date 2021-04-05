import Fluent

struct CreateOwner: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("owners")
            .id()
            .field("Name", .string, .required)
            .field("City", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("owners").delete()
    }
}
