package main

import (
	"html/template"
	"net/http"
)

// func handler(w http.ResponseWriter, r *http.Request) {
// 	fmt.Fprintln(w, "Hello World!")
// }

func renderTemplate(w http.ResponseWriter, tmpl string, data interface{}) {
	t, err := template.ParseFiles("templates/" + tmpl + ".html")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	t.Execute(w, data)
}

func main() {
	// Serve static files
	http.Handle("/static/",
		http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

	// Home page
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		data := map[string]interface{}{
			"Title":   "Home Page",
			"Message": "Welcome to my Go website!",
		}
		renderTemplate(w, "index", data)
	})

	// About page
	http.HandleFunc("/about", func(w http.ResponseWriter, r *http.Request) {
		facts := []string{
			"Go is fast 🚀",
			"Go is strongly typed 📘",
			"Go is great for web servers 🌐",
		}
		data := map[string]interface{}{
			"Title": "About Page",
			"Facts": facts,
		}
		renderTemplate(w, "about", data)
	})

	println("Server running at http://localhost:8080")
	http.ListenAndServe(":8080", nil)
}
