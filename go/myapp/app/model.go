package model

type Book struct{
	id	int	`json:"id"`
	Title	string	`json:"title"`
	Author	string	`json:"author"`
}
