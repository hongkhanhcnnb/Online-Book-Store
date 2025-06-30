def allBooks(mysql):
    cur = mysql.connection.cursor()
    cur.execute("SELECT b.bookID, b.authorID, b.publisherID, b.title, b.genre, b.publicationYear, b.Category, b.Author, b.Quantity, b.Purchase_Price, b.Selling_Price, b.Current_Stock FROM Books as b ORDER BY b.bookID")
    booksData = cur.fetchall()
    booksData = list(booksData)
    mysql.connection.commit()
    cur.close()
    return booksData

# function to get all genre
def allGenre(mysql):
    cur = mysql.connection.cursor()
    cur.execute("SELECT DISTINCT genre FROM Books")
    genreData = list(cur.fetchall())
    mysql.connection.commit()
    cur.close()
    return genreData