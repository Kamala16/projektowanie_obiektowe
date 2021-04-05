import Fluent

struct CreateBook: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("books")
            .id()
            .field("title", .string, .required)
            .field("author", .uuid, .required, .references("authors","id"))
            .foreignKey("author", references: "authors", "id", onDelete: .cascade)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("books").delete()
    }
}
