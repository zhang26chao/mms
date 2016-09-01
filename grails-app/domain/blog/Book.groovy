package blog

class Book {
    String name
    float price

    static mapping = {
        cache(true)
    }

    static constraints = {
    }
}
