package main

import (
 "fmt"
 "strconv"
 "errors"
 "net/http"
 "database/sql"
 "github.com/labstack/echo/v4"
 _ "github.com/mattn/go-sqlite3"
)

//MODEL

type (
	book struct{
            Id      int     `json:"id"`
            Title   string  `json:"title"`
            Author  string  `json:"author"`
	}
)

//SINGLETON
type (
	singleton struct{
		db *sql.DB
	}
)

var (
	instance *singleton
)

func GetInstance() *singleton{
	if instance == nil {
		instance = &singleton{}
		instance.Open()
	}
	return instance
}

func (s *singleton) Open() {
	db, err := sql.Open("sqlite3", "./data.db")

	if err != nil {
		fmt.Println("Couldn't open database")
	}
	_, err = db.Exec("CREATE TABLE IF NOT EXISTS books (Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, Title TEXT NOT NULL, Author TEXT NOT NULL)")
	if err != nil {
		fmt.Println("Couldn't create table")
	}
	s.db = db
}

func (s *singleton) Close() {
	err := s.db.Close()
	if err != nil {
		fmt.Println("Couldn't close database")
	}
}

func (s *singleton) Search(query string)(*sql.Rows, error){
	rows, err := s.db.Query(query)
	if err != nil{
		return nil, err
	}
	return rows, err
}

func (s *singleton) Query(query string)(int64, error){
	temp, err := s.db.Prepare(query)
	if err != nil {
		return -1, err
	}

	res, err := temp.Exec()
	if err != nil{
		return -1, err
	}

	id, err := res.LastInsertId()

	if err != nil{
		return -1, err
	}

	return id, nil
}

//CRUD

func (s *singleton) getBook(id string) (*book, error){
	inst := GetInstance()
	rows, err := inst.Search(fmt.Sprintf("SELECT * FROM books WHERE Id=%v LIMIT 1", id))

	if err != nil {
		return nil, err
	}

	defer func() {
		err = rows.Close()
		if err != nil {
			fmt.Println("Couldn't close rows")
		}
	}()

	if rows.Next() {
		b := new(book)
		if err := rows.Scan(&b.Id, &b.Title, &b.Author); err != nil{
			return nil, err
		}
		return b, nil
	}

	return nil, errors.New("book doesn't exist")
} 

func createBook(c echo.Context) error {
	b := new(book)
	inst := GetInstance()

	if err := c.Bind(b); err != nil {
		return err
	}
	created, err := inst.Query(fmt.Sprintf("INSERT INTO books (Title, Author) values ('%v', '%v')", b.Title, b.Author))
	if err != nil {
		return  echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	books, err := inst.getBook(strconv.FormatInt(created, 10))
	if err != nil {
		return  echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	return c.JSON(http.StatusCreated, books)
}

func getBook(c echo.Context) error {
	id := c.Param("id")
	inst := GetInstance()
	books, err := inst.getBook(id)
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	return c.JSON(http.StatusOK, books)
}

func updateBook(c echo.Context) error {
	b := new(book)
	inst := GetInstance()
	if err := c.Bind(b); err != nil {
		return err
	}
	id := c.Param("id")

	old, err := inst.getBook(id)
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	if b.Title == ""{
		b.Title = old.Title
	}
	if b.Author == "" {
		b.Author = old.Author
	}

	_,err = inst.Query(fmt.Sprintf("UPDATE books SET Title='%v', Author='%v' WHERE Id=%v", b.Title, b.Author, b.Id))
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	return c.JSON(http.StatusOK, b)
}

func deleteBook(c echo.Context) error {
	id := c.Param("id")
	inst := GetInstance()

	deleted, err := inst.getBook(id)
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}
	_, err = inst.Query(fmt.Sprintf("DELETE FROM books WHERE Id=%v", id))
	if err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	return c.JSON(http.StatusOK, deleted)
}


func main() {
    e := echo.New()

	GetInstance().Open()

    e.POST("/books", createBook)
    e.GET("/books/:id", getBook)
    e.PUT("/books/:id", updateBook)
    e.DELETE("/books/:id", deleteBook)

    e.Logger.Fatal(e.Start(":5000"))
}
