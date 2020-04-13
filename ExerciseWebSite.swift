import UIKit

/* Gaetano Carfì
 * Esercizio della lezione */

/* Un sito web di notizie online ti ha richiesto la creazione di un’applicazione per la visualizzazione nativa dei suoi articoli e feed delle notizie.
 • Tutte le notizie hanno un titolo, testo, data di pubblicazione; autore.
 • L’Autore è definito a partire da un nome, cognome e da un indirizzo web.
 Le notizie oltre ad essere di tipo testuale possono essere di tipo Video. Queste si differenziano perché posseggono un url del video e la durata del video (oltre alle proprietà classiche).
 Quello che devi creare è la struttura delle classi del progetto ed una sorta di gestore delle notizie. Il gestore delle notizie è in grado di:
 • Aggiungere un nuovo articolo o video ad una collezione.
 • Restituire la lista di articoli o video dato il nome di un autore.
 • Calcolare il numero di video e articoli presenti.
 • Restituire l’ultimo articolo o video pubblicato (cioè inserito nel gestore).
 Non ho inserito suggerimenti perché, a questo punto, dovresti essere in grado di risolvere l’esercizio utilizzando diversi strumenti. Ad ogni modo, nel caso avessi delle domande sull’esercizio, non esitare a scrivere un commento.*/

class Author {
    var name: String
    var surname: String
    var urlAuthor: String
    
    init(name: String, surname: String, urlAuthor: String) {
        self.name = name
        self.surname = surname
        self.urlAuthor = urlAuthor
    }
}

class News {
    var title: String
    var text: String
    private var publicationDate: Int
    private var author: Author
    
    init(title: String, text: String, publicationDate: Int, name: String, surname: String, urlAuthor: String) {
        self.title = title
        self.text = text
        self.publicationDate = publicationDate
        self.author = Author.init(name: name, surname: surname, urlAuthor: urlAuthor)
    }
    
    //get-set publicationDate
    var cpPublicationDate: Int {
        get {
            return self.publicationDate
        }
        set(publicationDate) {
            self.publicationDate = publicationDate
        }
    }
    
    // get-set author
    var cpAuthor: Author {
        get {
            return self.author
        }
        set(author) {
            self.author = author
        }
    }
}

class VideoNews: News {
    var urlVideo: String
    var duration: String
    
    init(urlVideo: String, duration: String, title: String, text: String, publicationDate: Int, name: String, surname: String, urlAuthor: String) {
        self.urlVideo = urlVideo
        self.duration = duration
        super.init(title: title, text: text, publicationDate: publicationDate, name: name, surname: surname, urlAuthor: urlAuthor)
    }
}

class Site {
    var authors: [Author]
    var news: [News]
    
    init() {
        self.authors = []
        self.news = []
    }
    
    func add(title: String, text: String, publicationDate: Int, name: String, surname: String, urlAuthor: String, urlVideo: String?, duration: String?) -> String {
        guard let urlVideo = urlVideo, let duration = duration else {
            self.news.append(News.init(title: title, text: text, publicationDate: publicationDate, name: name, surname: surname, urlAuthor: urlAuthor))
            return "Text news added!"
        }
        self.news.append(VideoNews.init(urlVideo: urlVideo, duration: duration, title: title, text: text, publicationDate: publicationDate, name: name, surname: surname, urlAuthor: urlAuthor))
        return "Video news added!"
    }
    
    func getNewsByAuthorName(name: String, surname: String) -> [News] {
        var support: [News] = []
        for info in self.news {
            if info.cpAuthor.name == name && info.cpAuthor.surname == surname {
                support.append(info)
            }
        }
        if support.count == 0 {
            print("Autore non presente")
        }
        return support
    }

    func getNumberOfArticles() -> String {
        var videoNewsCounter = 0
        
        for info in self.news {
            if info is VideoNews {
                videoNewsCounter += 1
            }
        }
        let newsCounter = news.count - videoNewsCounter
        return "Le news di testo sono: \(newsCounter);\n le news video sono: \(videoNewsCounter)."
    }

    func getLastArticle() -> String {
        return "L'ultimo articolo è: \(String(describing: news.last))"
    }
}

var siteOfNews = Site.init()

siteOfNews.add(title: "Steve Jobs", text: "Libro che tratta di Steve Jobs", publicationDate: 24, name: "Walter", surname: "Isaacson", urlAuthor: "w.isaa@abc.com", urlVideo: nil, duration: nil)

siteOfNews.add(title: "Christus Vivit", text: "Tratta i problemi affrontati durante il Sinodo dei Giovani", publicationDate: 28, name: "Papa Francesc", surname: "CEI", urlAuthor: "cei@chiesa.va", urlVideo: "hiuehfdehififhfuifhikjkhsdf", duration: "1h")

print(siteOfNews.getLastArticle() as Any)
print(siteOfNews.getNewsByAuthorName(name: "Papa Francesco", surname: "CEI"))
print(siteOfNews.getNumberOfArticles())
