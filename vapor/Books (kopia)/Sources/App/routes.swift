import Fluent
import Vapor

func routes(_ app: Application) throws {

    let bookController = BookController()

    app.get("books", use: bookController.index)

    app.post("book", "create", use: bookController.create)
    app.post("book", "update", ":id", use: bookController.update)
    app.post("book", "delete", ":id", use: bookController.delete)

    let authorController = AuthorController()

    app.get("authors", use: authorController.index)

    app.post("author", "create", use: authorController.create)
    app.post("author", "update", ":id", use: authorController.update)
    app.post("author", "delete", ":id", use: authorController.delete)

    let ownerController = OwnerController()

    app.get("owners", use: ownerController.index)

    app.post("owner", "create", use: ownerController.create)
    app.post("owner", "update", ":id", use: ownerController.update)
    app.post("owner", "delete", ":id", use: ownerController.delete)

}
