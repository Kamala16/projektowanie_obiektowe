import Fluent

struct CreateAuthor: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("authors")
            .id()
            .field("Name", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("authors").delete()
    }
}
