package models

type Product struct {
	ID          int     `json:"id"`
	Title       string  `json:"title"`
	ImageURL    string  `json:"image_url"`
	Price       float64 `json:"price"`
	Description string  `json:"description"`
	Listen      string  `json:"listen"`
	Quantity    int     `json:"quantity"`
	IsFavorite  bool    `json:"is_favorite"`
	InCart      bool    `json:"in_cart"`
}
