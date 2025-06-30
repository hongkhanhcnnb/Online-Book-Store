# add book function
def addBook(mysql, bookID, title, genre, fname, lname, year, category, purchase_price, selling_price, country, stock):
    cur = mysql.connection.cursor()
    try:
        # if publisher country is not present in Publishers table then add record
        cur.execute("SELECT publisherID FROM Publishers WHERE country = %s", (country,))
        publisherID = cur.fetchone()
        if not publisherID:
            cur.execute("INSERT INTO Publishers(country) VALUES (%s)", (country,))
            cur.execute("SELECT publisherID FROM Publishers WHERE country = %s", (country,))
            publisherID = cur.fetchone()

        # if author name is not present in Authors table then add record
        cur.execute("SELECT authorID FROM Authors WHERE firstName = %s AND lastName = %s", (fname, lname))
        authorID = cur.fetchone()
        if not authorID:
            cur.execute("INSERT INTO Authors(firstName, lastName) VALUES (%s, %s)", (fname, lname))
            cur.execute("SELECT authorID FROM Authors WHERE firstName = %s AND lastName = %s", (fname, lname))
            authorID = cur.fetchone()

        # add book in Books table
        cur.execute(
            """
            INSERT INTO Books(
                bookID, authorID, publisherID, title, genre, publicationYear, 
                Category, Author, Quantity, Purchase_Price, Selling_Price, Current_Stock
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """,
            (bookID, authorID[0], publisherID[0], title, genre, year, category, f"{fname} {lname}", stock, purchase_price, selling_price, stock)
        )

        # add book stock in Inventory
        cur.execute("INSERT INTO Inventory (bookID, totalStock, soldStock) VALUES (%s, %s, %s)", (bookID, stock, 0))

        result = 1  # book added successfully

    except Exception as e:
        print("Error adding book:", e)
        result = 0  # book failed to add

    mysql.connection.commit()
    cur.close()

    return result

# update book function
def updateBook(mysql, bookID, new_selling_price):
    cur = mysql.connection.cursor()

    try:
        # Update the selling price for the book with the given bookID
        cur.execute(
            "UPDATE Books SET Selling_Price = %s WHERE bookID = %s",
            (new_selling_price, bookID)
        )
        
        # Check if the update was successful
        if cur.rowcount > 0:
            result = 1  # Book updated successfully
        else:
            result = 0  # No book found with the given ID

    except Exception as e:
        print("Error updating book:", e)
        result = 0  # Book failed to update

    mysql.connection.commit()
    cur.close()

    return result


# delete book function
def deleteBook(mysql, bookID):
    """
    Xóa một cuốn sách từ cơ sở dữ liệu và tất cả dữ liệu liên quan.
    
    Args:
        mysql: Đối tượng kết nối MySQL.
        bookID: ID của cuốn sách cần xóa.
    
    Returns:
        result: 1 nếu thành công, 0 nếu thất bại.
    """
    cur = mysql.connection.cursor()

    try:
        # Xóa dữ liệu liên quan trong InventoryReport
        cur.execute("DELETE FROM InventoryReport WHERE bookID = %s", (bookID,))
        
        # Xóa dữ liệu liên quan trong Inventory
        cur.execute("DELETE FROM Inventory WHERE bookID = %s", (bookID,))
        
        # Xóa sách trong bảng Books
        cur.execute("DELETE FROM Books WHERE bookID = %s", (bookID,))
        
        if cur.rowcount == 0:
            # Nếu không có dòng nào bị ảnh hưởng, nghĩa là bookID không tồn tại
            raise Exception("BookID not found")
        
        result = 1  # Thành công

    except Exception as e:
        print("Error deleting book:", e)
        result = 0  # Lỗi khi xóa

    mysql.connection.commit()
    cur.close()

    return result

# book stock function
def inventory(mysql):
    cur = mysql.connection.cursor()
    cur.execute(
        """
        SELECT b.bookID, b.title, b.genre, b.Author, b.Category, i.totalStock, i.soldStock 
        FROM Books b
        JOIN Inventory i ON b.bookID = i.bookID
        ORDER BY b.bookID
        """
    )
    bookData = list(cur.fetchall())
    mysql.connection.commit()
    cur.close()
    return bookData

# book details function
def bookDetail(mysql, subject):
    cur = mysql.connection.cursor()
    cur.execute(
        """
        SELECT b.bookID, b.title, b.genre, b.Purchase_Price, b.Selling_Price, b.publicationYear, b.Author, p.country,b.price 
        FROM Books b 
        JOIN Publishers p ON b.publisherID = p.publisherID 
        WHERE b.bookID = %s
        """,
        (subject,)
    )
    bookData = list(cur.fetchone())
    mysql.connection.commit()
    cur.close()
    return bookData

# calculate total cost of books
def totalBookPrice(mysql, bookID, quantity):
    cur = mysql.connection.cursor()
    cur.execute("SELECT bookID, Selling_Price, title FROM Books WHERE bookID = %s", (bookID,))
    bookData = list(cur.fetchone())
    mysql.connection.commit()
    cur.close()
    return bookData
