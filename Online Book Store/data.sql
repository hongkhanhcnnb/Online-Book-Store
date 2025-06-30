-- drop database onlinebookstore;
CREATE DATABASE onlinebookstore;
USE onlinebookstore;
SHOW TABLES;


CREATE TABLE Customers(
	customerID VARCHAR(30) PRIMARY KEY,
	firstName VARCHAR(20),
	lastName VARCHAR(20),
	emailID VARCHAR(50),
	password VARCHAR(30),
	phone VARCHAR(10),
	country VARCHAR(25),
	state VARCHAR(25),
	pincode INT,
	address VARCHAR(50),
    Debt DECIMAL(10,2) DEFAULT 0.00 -- Thêm cột này để tương thích với triggers
);

CREATE TABLE Admins(
	adminID VARCHAR(30) PRIMARY KEY,
	firstName VARCHAR(20),
	lastName VARCHAR(20),
	emailID VARCHAR(50),
	password VARCHAR(30),
	phone VARCHAR(10)
);


-- Thêm cột cho Books theo yêu cầu đoạn trên:
-- ID_Book sẽ tương ứng bookID
-- Thêm Category, Author, Quantity, Purchase_Price, Selling_Price, Current_Stock
CREATE TABLE Books(
	bookID INT PRIMARY KEY,
	authorID INT,
	publisherID INT,
	title VARCHAR(50),
	genre VARCHAR(15),
	publicationYear INT,
	price INT,
    Category VARCHAR(50),
    Author VARCHAR(100),
    Quantity INT,
    Purchase_Price DECIMAL(10,2),
    Selling_Price DECIMAL(10,2),
    Current_Stock INT
);

CREATE TABLE Authors(
  authorID INT PRIMARY KEY AUTO_INCREMENT,
  firstName VARCHAR(20),
  lastName VARCHAR(20)
);

CREATE TABLE Publishers(
  publisherID INT PRIMARY KEY AUTO_INCREMENT,
  country VARCHAR(25)
);

CREATE TABLE Inventory(
   bookID INT PRIMARY KEY,
   totalStock INT,
   soldStock INT,
   

   FOREIGN KEY (bookID) REFERENCES Books(bookID)
);

CREATE TABLE Orders(
  orderID INT AUTO_INCREMENT,
  customerID VARCHAR(30),
  bookID INT,
  quantity INT NOT NULL,
  total INT,
  timestamp DATETIME,
  PRIMARY KEY(orderID,customerID,timestamp,bookID),
  FOREIGN KEY (customerID) REFERENCES Customers(customerID),
  FOREIGN KEY (bookID) REFERENCES Books(bookID)
);

CREATE TABLE Payment(
  paymentID INT PRIMARY KEY AUTO_INCREMENT,
  customerID VARCHAR(30),
  paymentInfo INT NOT NULL,
  FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);

CREATE TABLE ContactUs(
  id INT PRIMARY KEY AUTO_INCREMENT,
  firstName VARCHAR(20),
  lastName VARCHAR(20),
  emailID VARCHAR(50),
  message VARCHAR(1000),
  timestamp DATETIME
);

-- -----------------------------------------------------AUTO_INCREMENT ---------------------------------------------------------------------------
ALTER TABLE Authors AUTO_INCREMENT=101;
ALTER TABLE Publishers AUTO_INCREMENT=201;

-- -----------------------------------------------------FOREIGN KEYS-----------------------------------------------------------------------------
ALTER TABLE Books ADD FOREIGN KEY (authorID) REFERENCES Authors(authorID);
ALTER TABLE Books ADD FOREIGN KEY (publisherID) REFERENCES Publishers(publisherID);

-- -----------------------------------------------------INSERT DATA------------------------------------------------------------------------------
INSERT INTO Admins(adminID,firstName,lastName,emailID,password,phone) VALUES('admin1','Sam','Jones','sam@gmail.com','abc123','1234567892');
INSERT INTO Admins(adminID,firstName,lastName,emailID,password,phone) VALUES('admin2','Anu','Sharma','anu@gmail.com','abc1','3454567892');
INSERT INTO Admins(adminID,firstName,lastName,emailID,password,phone) VALUES('euphoria','Huỳnh','Đạt','22520211@gm.uit.edu.vn','26092004','3454567892');

INSERT INTO Customers (
    customerID, firstName, lastName, emailID, password, phone, country, state, pincode, address, Debt
)
VALUES
    ('KH001', 'Nguyễn', 'Văn A', 'nguyenvana@example.com', 'pass123', '0901234567', 'Việt Nam', 'Hà Nội', 100000, '123 Phố Lý Thái Tổ', 100.00),
    ('KH002', 'Trần', 'Thị B', 'tranthib@example.com', '123456', '0912345678', 'Việt Nam', 'Hồ Chí Minh', 700000, '45 Nguyễn Huệ', 200.00),
    ('KH003', 'Lê', 'Minh C', 'leminhc@example.com', 'leminhc123', '0923456789', 'Việt Nam', 'Đà Nẵng', 500000, '12 Trần Phú', 150.50),
    ('KH004', 'Phạm', 'Văn D', 'phamvand@example.com', '123phamvan', '0934567890', 'Việt Nam', 'Cần Thơ', 900000, '78 Hùng Vương', 0.00),
    ('KH005', 'Hoàng', 'Thị E', 'hoangthie@example.com', 'password', '0945678901', 'Việt Nam', 'Huế', 530000, '34 Bà Triệu', 50.75),
    ('KH006', 'Đặng', 'Ngọc F', 'dangngocf@example.com', 'ngocf123', '0956789012', 'Việt Nam', 'Hải Phòng', 180000, '56 Lạch Tray', 75.00);


-- Thêm dữ liệu vào bảng Publishers
INSERT INTO Publishers (publisherID, country)
VALUES
(201, 'Vietnam'),
(202, 'USA'),
(203, 'UK'),
(204, 'France'),
(205, 'Japan'),
(206, 'Germany');

-- Thêm dữ liệu vào bảng Authors
INSERT INTO Authors (authorID, firstName, lastName)
VALUES
(101, 'Nguyen', 'Du'),
(102, 'Victor', 'Hugo'),
(103, 'William', 'Shakespeare'),
(104, 'George', 'Orwell'),
(105, 'Gabriel', 'Garcia Marquez'),
(106, 'Lev', 'Tolstoy'),
(107, 'Haruki', 'Murakami'),
(108, 'J.K.', 'Rowling'),
(109, 'J.R.R.', 'Tolkien'),
(110, 'Nguyen', 'Nhat Anh'),
(111, 'Jane', 'Austen'),
(112, 'F. Scott', 'Fitzgerald'),
(113, 'Charles', 'Dickens'),
(114, 'Mark', 'Twain'),
(115, 'Leo', 'Tolstoy'),
(116, 'J.D.', 'Salinger'),
(117, 'Ernest', 'Hemingway'),
(118, 'Herman', 'Melville'),
(119, 'Mary', 'Shelley'),
(120, 'George', 'Eliot'),
(121, 'Franz', 'Kafka'),
(122, 'Jack', 'London'),
(123, 'Fyodor', 'Dostoevsky'),
(124, 'Emily', 'Bronte'),
(125, 'Virginia', 'Woolf'),
(126, 'To', 'Hoai'),
(127, 'Bao', 'Ninh'),
(128, 'Nam', 'Cao'),
(129, 'Vu', 'Trong Phung'),
(130, 'Nguyen', 'Huy Thiep');
INSERT INTO Authors (authorID, firstName, lastName)
VALUES
(131, 'Masashi', 'Kishimoto'),
(132, 'Eiichiro', 'Oda'),
(133, 'Gosho', 'Aoyama'),
(134, 'Hergé', NULL),
(135, 'René', 'Goscinny'),
(136, 'Rudyard', 'Kipling'),
(137, 'Wu', 'Cheng’en'),
(138, 'Rick', 'Riordan'),
(139, 'James', 'Dashner'),
(140, 'Robert', 'Louis Stevenson');

-- Thêm dữ liệu vào bảng Books
INSERT INTO Books (bookID, authorID, publisherID, title, genre, publicationYear, price, Category, Author, Quantity, Purchase_Price, Selling_Price, Current_Stock)
VALUES
(1, 101, 201, 'Truyen Kieu', 'Poetry', 1820, 130000, 'Classic', 'Nguyen Du', 100, 70000, 100000, 100),
(2, 126, 201, 'De Men Phieu Luu Ky', 'Children', 1941, 105000, 'Classic', 'To Hoai', 80, 60000, 90000, 80),
(3, 127, 201, 'The Sorrow of War', 'Novel', 1991, 125000, 'Vietnamese Literature', 'Bao Ninh', 70, 80000, 110000, 70),
(4, 128, 201, 'Chi Pheo', 'Novel', 1941, 105000, 'Classic', 'Nam Cao', 100, 70000, 95000, 100),
(5, 129, 201, 'So Do', 'Satire', 1936, 130000, 'Classic', 'Vu Trong Phung', 60, 75000, 100000, 60),
(6, 130, 201, 'Tuong Ve Huu', 'Short Stories', 1987, 115000, 'Vietnamese Literature', 'Nguyen Huy Thiep', 50, 60000, 85000, 50),
(7, 110, 201, 'Kinh Van Hoa', 'Children', 1988, 105000, 'Children', 'Nguyen Nhat Anh', 120, 70000, 95000, 120),
(8, 110, 201, 'Mat Biec', 'Romance', 1990, 115000, 'Vietnamese Literature', 'Nguyen Nhat Anh', 60, 75000, 105000, 60),
(9, 102, 204, 'Les Miserables', 'Novel', 1862, 180000, 'Classic', 'Victor Hugo', 50, 120000, 150000, 50),
(10, 103, 203, 'Hamlet', 'Drama', 1600, 150000, 'Classic', 'William Shakespeare', 70, 90000, 120000, 70),
(12, 105, 205, 'One Hundred Years of Solitude', 'Magical Realism', 1967, 170000, 'Fiction', 'Gabriel Garcia Marquez', 60, 110000, 140000, 60),
(13, 106, 206, 'War and Peace', 'Historical', 1869, 190000, 'Classic', 'Lev Tolstoy', 40, 130000, 160000, 40),
(14, 107, 205, 'Norwegian Wood', 'Fiction', 1987, 155000, 'Fiction', 'Haruki Murakami', 90, 100000, 125000, 90),
(15, 108, 202, 'Harry Potter and the Sorcerer''s Stone', 'Fantasy', 1997, 230000, 'Fantasy', 'J.K. Rowling', 100, 150000, 200000, 100),
(16, 109, 203, 'The Hobbit', 'Fantasy', 1937, 210000, 'Fantasy', 'J.R.R. Tolkien', 75, 140000, 180000, 75),
(17, 111, 202, 'Pride and Prejudice', 'Romance', 1813, 180000, 'Classic', 'Jane Austen', 50, 100000, 140000, 50),
(18, 112, 202, 'The Great Gatsby', 'Novel', 1925, 160000, 'Classic', 'F. Scott Fitzgerald', 60, 90000, 130000, 60),
(19, 113, 203, 'A Tale of Two Cities', 'Historical', 1859, 180000, 'Classic', 'Charles Dickens', 40, 110000, 150000, 40),
(20, 114, 202, 'The Adventures of Huckleberry Finn', 'Adventure', 1884, 155000, 'Classic', 'Mark Twain', 80, 100000, 125000, 80),
(21, 115, 206, 'Anna Karenina', 'Romance', 1877, 190000, 'Classic', 'Leo Tolstoy', 70, 130000, 160000, 70),
(22, 116, 203, 'The Catcher in the Rye', 'Novel', 1951, 160000, 'Fiction', 'J.D. Salinger', 90, 100000, 120000, 90),
(23, 117, 204, 'The Old Man and the Sea', 'Fiction', 1952, 140000, 'Classic', 'Ernest Hemingway', 100, 80000, 110000, 100),
(24, 118, 202, 'Moby Dick', 'Adventure', 1851, 170000, 'Classic', 'Herman Melville', 50, 100000, 140000, 50),
(25, 119, 203, 'Frankenstein', 'Horror', 1818, 150000, 'Classic', 'Mary Shelley', 70, 90000, 120000, 70),
(26, 120, 205, 'Middlemarch', 'Novel', 1871, 160000, 'Classic', 'George Eliot', 60, 100000, 130000, 60),
(27, 121, 204, 'The Metamorphosis', 'Fiction', 1915, 130000, 'Classic', 'Franz Kafka', 90, 80000, 100000, 90),
(28, 122, 205, 'White Fang', 'Adventure', 1906, 155000, 'Classic', 'Jack London', 80, 100000, 125000, 80),
(30, 124, 203, 'Wuthering Heights', 'Romance', 1847, 160000, 'Classic', 'Emily Bronte', 60, 100000, 130000, 60),
(31, 125, 204, 'Mrs. Dalloway', 'Novel', 1925, 130000, 'Classic', 'Virginia Woolf', 100, 90000, 110000, 100),
(32, 127, 201, 'Nhung dua con cua lang', 'Novel', 1957, 130000, 'Classic', 'Bao Ninh', 70, 80000, 100000, 70),
(33, 128, 201, 'Lang', 'Short Stories', 1942, 120000, 'Vietnamese Literature', 'Nam Cao', 60, 90000, 110000, 60),
(34, 126, 201, 'Cuoc doi cua ong Nam', 'Novel', 1955, 105000, 'Biography', 'To Hoai', 50, 60000, 85000, 50),
(35, 129, 201, 'Hoang Le Nhat Thong Chi', 'Historical', 1800, 110000, 'Historical', 'Vu Trong Phung', 40, 70000, 95000, 40),
(36, 127, 201, 'Dat Rung Phuong Nam', 'Novel', 1957, 110000, 'Vietnamese Literature', 'Doan Gioi', 60, 70000, 90000, 60),
(37, 128, 201, 'Nguoi me cam sung', 'Novel', 1945, 120000, 'Vietnamese Literature', 'Nguyen Thi', 70, 75000, 100000, 70);

INSERT INTO Books (bookID, authorID, publisherID, title, genre, publicationYear, price, Category, Author, Quantity, Purchase_Price, Selling_Price, Current_Stock)
VALUES 
(38, 131, 202, 'Naruto', 'Manga', 1999, 150000, 'Comics', 'Masashi Kishimoto', 150, 100000, 120000, 150),
(39, 132, 203, 'One Piece', 'Manga', 1997, 160000, 'Comics', 'Eiichiro Oda', 200, 110000, 130000, 180),
(40, 133, 204, 'Detective Conan', 'Manga', 1994, 140000, 'Comics', 'Gosho Aoyama', 170, 95000, 110000, 160),
(41, 134, 201, 'The Adventures of Tintin', 'Adventure', 1929, 150000, 'Comics', 'Hergé', 100, 120000, 140000, 90),
(42, 135, 202, 'Asterix', 'Adventure', 1959, 160000, 'Comics', 'René Goscinny', 120, 110000, 130000, 110),
(43, 136, 203, 'The Jungle Book', 'Adventure', 1894, 160000, 'Classic', 'Rudyard Kipling', 150, 85000, 100000, 140),
(44, 137, 204, 'Journey to the West', 'Adventure', 1592, 190000, 'Classic', 'Wu Cheng’en', 80, 120000, 150000, 70),
(45, 138, 205, 'Percy Jackson & the Olympians', 'Fantasy', 2005, 210000, 'Fantasy', 'Rick Riordan', 130, 150000, 180000, 120),
(47, 140, 201, 'Treasure Island', 'Adventure', 1883, 170000, 'Classic', 'Robert Louis Stevenson', 120, 90000, 110000, 100);

-- Thêm 20 sách của tác giả Việt Nam
INSERT INTO Books (bookID, authorID, publisherID, title, genre, publicationYear, price, Category, Author, Quantity, Purchase_Price, Selling_Price, Current_Stock)
VALUES
(50, 110, 201, 'Những Người Bạn Của Tôi', 'Truyện Ngắn', 2022, 180000, 'Short Stories', 'Nguyễn Nhật Ánh', 150, 80000, 120000, 60),
(51, 126, 202, 'Mảnh Ghép Tình Yêu', 'Ngôn Tình', 2021, 220000, 'Novel', 'Tô Hoài', 120, 100000, 150000, 50),
(52, 110, 203, 'Áo Lụa Hà Đông', 'Truyện Ngắn', 2020, 200000, 'Short Stories', 'Nguyễn Nhật Ánh', 130, 90000, 140000, 70),
(53, 127, 204, 'Nỗi Buồn Hoa Phượng', 'Ngôn Tình', 2022, 250000, 'Novel', 'Bảo Ninh', 140, 120000, 180000, 80),
(54, 128, 205, 'Dòng Sông Cũ', 'Tâm Lý', 2021, 270000, 'Self-help', 'Nam Cao', 110, 130000, 190000, 90),
(55, 130, 206, 'Chiều Cuối Tuần', 'Truyện Ngắn', 2023, 220000, 'Short Stories', 'Nguyễn Huy Thiệp', 140, 100000, 150000, 60),
(56, 126, 201, 'Đoạn Đường Màu Hồng', 'Ngôn Tình', 2020, 230000, 'Novel', 'Tô Hoài', 150, 110000, 160000, 85),
(57, 125, 202, 'Gió Lòng', 'Tâm Lý', 2023, 240000, 'Self-help', 'Virginia Woolf', 130, 120000, 170000, 50),
(58, 124, 203, 'Tháng Sáu Trở Lại', 'Truyện Ngắn', 2021, 210000, 'Short Stories', 'Emily Brontë', 100, 95000, 140000, 75),
(59, 130, 204, 'Lời Nói Dối', 'Truyện Ngắn', 2020, 240000, 'Short Stories', 'Nguyễn Huy Thiệp', 110, 100000, 150000, 90),
(60, 119, 205, 'Biển Sáng', 'Ngôn Tình', 2022, 250000, 'Novel', 'Mary Shelley', 120, 130000, 180000, 80),
(61, 127, 206, 'Những Con Số', 'Tâm Lý', 2021, 200000, 'Self-help', 'Bảo Ninh', 90, 110000, 150000, 65),
(62, 130, 201, 'Vòng Xoay Thời Gian', 'Truyện Ngắn', 2020, 230000, 'Short Stories', 'Nguyễn Huy Thiệp', 100, 95000, 140000, 70),
(63, 110, 202, 'Tình Yêu Và Mưa', 'Ngôn Tình', 2023, 270000, 'Novel', 'Nguyễn Nhật Ánh', 150, 130000, 200000, 60),
(64, 126, 203, 'Cuộc Sống Không Lời', 'Tâm Lý', 2022, 220000, 'Self-help', 'Tô Hoài', 110, 100000, 150000, 75),
(65, 125, 204, 'Thành Phố Của Những Người Đi Vắng', 'Tâm Lý', 2020, 230000, 'Self-help', 'Virginia Woolf', 100, 120000, 160000, 90),
(66, 124, 205, 'Hơi Ấm Thân Quen', 'Ngôn Tình', 2021, 260000, 'Novel', 'Emily Brontë', 120, 130000, 200000, 70),
(67, 128, 206, 'Ký Ức Đêm', 'Tâm Lý', 2023, 210000, 'Self-help', 'Nam Cao', 130, 110000, 150000, 80),
(68, 130, 201, 'Chuyến Đi Cuối Cùng', 'Truyện Ngắn', 2022, 240000, 'Short Stories', 'Nguyễn Huy Thiệp', 140, 120000, 170000, 95),
(69, 110, 202, 'Tình Yêu Mãi Mãi', 'Ngôn Tình', 2022, 300000, 'Novel', 'Nguyễn Nhật Ánh', 150, 160000, 240000, 80),
(70, 127, 203, 'Hương Vị Của Thời Gian', 'Ngôn Tình', 2021, 280000, 'Novel', 'Bảo Ninh', 130, 150000, 220000, 70),
(71, 124, 204, 'Những Mảnh Ghép Đời Tôi', 'Tâm Lý', 2020, 200000, 'Self-help', 'Emily Brontë', 110, 95000, 140000, 75),
(72, 126, 205, 'Ánh Sáng Trong Đêm', 'Ngôn Tình', 2023, 290000, 'Novel', 'Tô Hoài', 140, 160000, 230000, 85);


-- Thêm 20 sách thể loại manga và truyện tranh
INSERT INTO Books (bookID, authorID, publisherID, title, genre, publicationYear, price, Category, Author, Quantity, Purchase_Price, Selling_Price, Current_Stock)
VALUES
(73, 131, 205, 'Naruto', 'Manga', 1999, 350000, 'Manga', 'Masashi Kishimoto', 200, 150000, 250000, 100),
(74, 132, 206, 'One Piece', 'Manga', 1997, 400000, 'Manga', 'Eiichiro Oda', 250, 170000, 300000, 150),
(75, 133, 201, 'Detective Conan', 'Manga', 1994, 300000, 'Manga', 'Gosho Aoyama', 180, 120000, 250000, 120),
(76, 134, 202, 'Tintin', 'Truyện Tranh', 1929, 200000, 'Comic', 'Hergé', 160, 100000, 150000, 110),
(77, 135, 203, 'Asterix', 'Truyện Tranh', 1959, 220000, 'Comic', 'René Goscinny', 170, 110000, 170000, 130),
(78, 136, 204, 'The Jungle Book', 'Truyện Tranh', 1894, 210000, 'Comic', 'Rudyard Kipling', 140, 100000, 160000, 95),
(79, 137, 205, 'Journey to the West', 'Truyện Tranh', 1592, 250000, 'Comic', 'Wu Cheng’en', 190, 130000, 210000, 140),
(80, 138, 206, 'Percy Jackson', 'Truyện Tranh', 2005, 270000, 'Comic', 'Rick Riordan', 220, 140000, 230000, 150),
(81, 139, 201, 'Maze Runner', 'Truyện Tranh', 2009, 280000, 'Comic', 'James Dashner', 200, 150000, 240000, 140),
(82, 140, 202, 'Treasure Island', 'Truyện Tranh', 1883, 230000, 'Comic', 'Robert Louis Stevenson', 160, 120000, 180000, 110),
(83, 131, 203, 'Boruto', 'Manga', 2016, 360000, 'Manga', 'Masashi Kishimoto', 210, 160000, 280000, 90),
(84, 132, 204, 'Dragon Ball', 'Manga', 1984, 380000, 'Manga', 'Eiichiro Oda', 220, 170000, 290000, 120),
(85, 133, 205, 'Magic Kaito', 'Manga', 2010, 320000, 'Manga', 'Gosho Aoyama', 180, 130000, 240000, 100),
(86, 134, 206, 'The Adventures of Tintin', 'Truyện Tranh', 1930, 210000, 'Comic', 'Hergé', 140, 105000, 160000, 90),
(87, 135, 201, 'Iznogoud', 'Truyện Tranh', 1962, 200000, 'Comic', 'René Goscinny', 150, 110000, 170000, 80),
(88, 136, 202, 'Kimba the White Lion', 'Manga', 1950, 300000, 'Manga', 'Osamu Tezuka', 230, 140000, 250000, 110),
(89, 137, 203, 'The Monkey King', 'Truyện Tranh', 1961, 250000, 'Comic', 'Wu Cheng’en', 200, 130000, 210000, 95),
(90, 138, 204, 'Heroes of Olympus', 'Truyện Tranh', 2010, 280000, 'Comic', 'Rick Riordan', 210, 150000, 220000, 130),
(91, 139, 205, 'The Scorch Trials', 'Truyện Tranh', 2010, 260000, 'Comic', 'James Dashner', 190, 140000, 230000, 110),
(92, 140, 206, 'Kidnapped', 'Truyện Tranh', 1886, 220000, 'Comic', 'Robert Louis Stevenson', 160, 120000, 200000, 100);







insert into Inventory (bookID,totalStock,soldStock) values (1,100,0);
insert into Inventory (bookID,totalStock,soldStock) values (2,100,0);

INSERT INTO Inventory (bookID, totalStock, soldStock) VALUES 

(3, 70, 25),  -- Đã bán 25 quyển
(4, 100, 30), -- Đã bán 30 quyển
(5, 60, 10),  -- Đã bán 10 quyển
(6, 50, 5),   -- Đã bán 5 quyển
(7, 120, 50), -- Đã bán 50 quyển
(8, 60, 20),  -- Đã bán 20 quyển
(9, 50, 10);  -- Đã bán 10 quyển
INSERT INTO Inventory (bookID, totalStock, soldStock) VALUES 
(10, 70, 20),   -- Hamlet: đã bán 20 quyển
(12, 60, 15),   -- One Hundred Years of Solitude: đã bán 15 quyển
(13, 40, 10),   -- War and Peace: đã bán 10 quyển
(14, 90, 25),   -- Norwegian Wood: đã bán 25 quyển
(15, 100, 40),  -- Harry Potter: đã bán 40 quyển
(16, 75, 20),   -- The Hobbit: đã bán 20 quyển
(17, 50, 15),   -- Pride and Prejudice: đã bán 15 quyển
(18, 60, 25),   -- The Great Gatsby: đã bán 25 quyển
(19, 40, 10),   -- A Tale of Two Cities: đã bán 10 quyển
(20, 80, 30),   -- The Adventures of Huckleberry Finn: đã bán 30 quyển
(21, 70, 20),   -- Anna Karenina: đã bán 20 quyển
(22, 90, 30),   -- The Catcher in the Rye: đã bán 30 quyển
(23, 100, 40),  -- The Old Man and the Sea: đã bán 40 quyển
(24, 50, 15),   -- Moby Dick: đã bán 15 quyển
(25, 70, 25),   -- Frankenstein: đã bán 25 quyển
(26, 60, 20),   -- Middlemarch: đã bán 20 quyển
(27, 90, 35),   -- The Metamorphosis: đã bán 35 quyển
(28, 80, 20),   -- White Fang: đã bán 20 quyển
(30, 60, 15),   -- Wuthering Heights: đã bán 15 quyển
(31, 100, 50),  -- Mrs. Dalloway: đã bán 50 quyển
(32, 70, 30),   -- Những đứa con của làng: đã bán 30 quyển
(33, 60, 20),   -- Làng: đã bán 20 quyển
(34, 50, 15),   -- Cuộc đời của ông Nam: đã bán 15 quyển
(35, 40, 10),   -- Hoàng Lê Nhất Thống Chí: đã bán 10 quyển
(36, 60, 25),   -- Đất rừng phương Nam: đã bán 25 quyển
(37, 70, 20),   -- Người mẹ cầm súng: đã bán 20 quyển
(38, 150, 50),  -- Naruto: đã bán 50 quyển
(39, 180, 60),  -- One Piece: đã bán 60 quyển
(40, 160, 70),  -- Detective Conan: đã bán 70 quyển
(41, 90, 40),   -- The Adventures of Tintin: đã bán 40 quyển
(42, 110, 30),  -- Asterix: đã bán 30 quyển
(43, 150, 60),  -- The Jungle Book: đã bán 60 quyển
(44, 70, 20),   -- Journey to the West: đã bán 20 quyển
(45, 120, 50),  -- Percy Jackson: đã bán 50 quyển
(47, 100, 30),  -- Treasure Island: đã bán 30 quyển
(50, 60, 25);   -- Những Người Bạn Của Tôi: đã bán 25 quyển

INSERT INTO Inventory (bookID, totalStock, soldStock)
VALUES
(51, 50, 10),
(52, 70, 12),
(53, 80, 15),
(54, 90, 20),
(55, 60, 8),
(56, 85, 18),
(57, 50, 5),
(58, 75, 13),
(59, 90, 25),
(60, 80, 17),
(61, 65, 10),
(62, 70, 14),
(63, 60, 7),
(64, 75, 19),
(65, 90, 22),
(66, 70, 12),
(67, 80, 15),
(68, 95, 20),
(69, 80, 18),
(70, 70, 11),
(71, 75, 14);
INSERT INTO Inventory (bookID, totalStock, soldStock)
VALUES
(72, 85, 10),
(73, 100, 15),
(74, 150, 25),
(75, 120, 18),
(76, 110, 22),
(77, 130, 30),
(78, 95, 12),
(79, 140, 20),
(80, 150, 35),
(81, 140, 28),
(82, 110, 15),
(83, 90, 8),
(84, 120, 18),
(85, 100, 14),
(86, 90, 10),
(87, 80, 5),
(88, 110, 20),
(89, 95, 13),
(90, 130, 25),
(91, 110, 12),
(92, 100, 18);



UPDATE Inventory
SET soldStock = 3
WHERE bookID = 1;




-- Tạo bảng BookEntry
CREATE TABLE BookEntry (
    ID_Entry INT PRIMARY KEY,
    Entry_Date DATE
);

-- Tạo bảng EntryDetail
CREATE TABLE EntryDetail (
    ID_Entry INT,
    bookID INT,
    Quantity_Added INT,
    Purchase_Price DECIMAL(10, 2),
    PRIMARY KEY (ID_Entry, bookID),
    FOREIGN KEY (ID_Entry) REFERENCES BookEntry(ID_Entry),
    FOREIGN KEY (bookID) REFERENCES Books(bookID)
);


-- Tạo bảng Invoice
CREATE TABLE Invoice (
    ID_Invoice INT PRIMARY KEY,
    Date_Issued DATE,
    ID_Customer VARCHAR(30),
    Total_Amount DECIMAL(10, 2),
    FOREIGN KEY (ID_Customer) REFERENCES Customers(customerID) -- Chuyển sang khóa ngoại với Customers
);

-- Tạo bảng InvoiceDetail
-- Gốc: Selling_Price AS (SELECT ...) không hợp lệ tạo cột Selling_Price bình thường.
CREATE TABLE InvoiceDetail (
    ID_Invoice INT,
    bookID INT,
    Quantity_Sold INT,
    Selling_Price DECIMAL(10,2), 
    PRIMARY KEY (ID_Invoice, bookID),
    FOREIGN KEY (ID_Invoice) REFERENCES Invoice(ID_Invoice),
    FOREIGN KEY (bookID) REFERENCES Books(bookID)
);

-- Tạo bảng PaymentReceipt
CREATE TABLE PaymentReceipt (
    ID_Receipt INT PRIMARY KEY AUTO_INCREMENT,
    Receipt_Date DATE,
    ID_Customer VARCHAR(30),
    Amount_Collected DECIMAL(10, 2),
    customer_name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(100),
    note TEXT,
    FOREIGN KEY (ID_Customer) REFERENCES Customers(customerID)
);

CREATE TABLE InventoryReport (
    Month DATE,
    bookID INT,
    Opening_Stock INT,
    Transactions INT,
    Closing_Stock INT,
    PRIMARY KEY (Month, bookID),
    FOREIGN KEY (bookID) REFERENCES Books(bookID)
);

CREATE TABLE DebtReport (
    Month DATE,
    ID_Customer VARCHAR(30),
    Opening_Debt DECIMAL(10, 2),
    Transactions DECIMAL(10, 2),
    Closing_Debt DECIMAL(10, 2),
    PRIMARY KEY (Month, ID_Customer),
    FOREIGN KEY (ID_Customer) REFERENCES Customers(customerID)
);
-- QD6
-- Tạo bảng RegulationSettings để lưu các quy định và giá trị có thể thay đổi
CREATE TABLE RegulationSettings (
    Regulation_ID INT PRIMARY KEY,
    Regulation_Name VARCHAR(100),
    Min_Entry_Quantity INT DEFAULT 150,
    Min_Stock_Before_Entry INT DEFAULT 300,
    Max_Debt DECIMAL(10, 2) DEFAULT 100000.00,
    Min_Stock_After_Sale INT DEFAULT 10,
    Use_Regulation_4 BOOLEAN DEFAULT TRUE
);

INSERT INTO RegulationSettings (Regulation_ID, Regulation_Name) VALUES (1, 'Default Regulations');


-- QĐ 1: 
DELIMITER //

CREATE TRIGGER trg_check_quantity_entry
BEFORE INSERT ON EntryDetail
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;
        -- Lấy lượng tồn kho hiện tại từ bảng Book
    SELECT Current_Stock INTO current_stock FROM Books WHERE bookID = NEW.bookID;
    -- Kiểm tra số lượng tồn kho hiện tại phải < 300
    IF current_stock >= 300 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot add entry. Current stock exceeds 300.';
    END IF;
    -- Kiểm tra số lượng nhập phải >= 150
    IF NEW.Quantity_Added < 150 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity added must be at least 150.';
    END IF;
END//
DELIMITER ;
-- QĐ 2: 
-- Trigger kiểm tra các điều kiện trước khi bán sách
DELIMITER //
CREATE TRIGGER trg_BeforeInvoiceDetailInsert
BEFORE INSERT ON InvoiceDetail
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;
    DECLARE current_debt DECIMAL(10, 2);
    -- Kiểm tra công nợ khách hàng
    SELECT Debt INTO current_debt FROM Customers WHERE customerID = (SELECT ID_Customer FROM Invoice WHERE ID_Invoice = NEW.ID_Invoice);
    IF current_debt > 1000000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể bán sách vì khách hàng nợ quá 1.000.000đ';
    END IF;
    -- Kiểm tra lượng tồn kho sau bán
    SELECT Current_Stock INTO current_stock FROM Books WHERE bookID = NEW.bookID;
    IF (current_stock - NEW.Quantity_Sold) < 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể bán sách vì lượng tồn kho sau bán ít hơn 20';
    END IF;
    -- Cập nhật tồn kho sau bán
    UPDATE Books
    SET Current_Stock = Current_Stock - NEW.Quantity_Sold
    WHERE bookID = NEW.bookID;
END//
DELIMITER ;

-- QD4
DELIMITER //
-- Tạo trigger để kiểm tra số tiền thu không vượt quá số tiền khách hàng đang nợ
CREATE TRIGGER trg_CheckAmountCollected
BEFORE INSERT ON PaymentReceipt
FOR EACH ROW
BEGIN
    DECLARE customerDebt DECIMAL(10, 2);
        -- Lấy số tiền nợ hiện tại của khách hàng
    SELECT Debt INTO customerDebt FROM Customers WHERE customerID = NEW.ID_Customer;
    -- Kiểm tra nếu số tiền thu vượt quá số tiền nợ
    IF NEW.Amount_Collected > customerDebt THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số tiền thu không được vượt quá số tiền khách hàng đang nợ';
    END IF;
END//
DELIMITER ;
-- Trigger kiểm tra QĐ1 khi thêm chi tiết nhập
DELIMITER //
CREATE TRIGGER trg_CheckEntryDetail
BEFORE INSERT ON EntryDetail
FOR EACH ROW
BEGIN
    DECLARE minEntryQuantity INT;
    DECLARE minStockBeforeEntry INT;
    DECLARE currentStock INT;

    SELECT Min_Entry_Quantity, Min_Stock_Before_Entry INTO minEntryQuantity, minStockBeforeEntry
    FROM RegulationSettings
    WHERE Regulation_ID = 1;

    SELECT Current_Stock INTO currentStock FROM Books WHERE bookID = NEW.bookID;

    IF NEW.Quantity_Added < minEntryQuantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng nhập không được nhỏ hơn số lượng tối thiểu theo quy định.';
    END IF;

    IF currentStock >= minStockBeforeEntry THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng tồn hiện tại lớn hơn lượng tồn tối thiểu cho phép trước khi nhập.';
    END IF;
END//
DELIMITER ;
-- Trigger kiểm tra QĐ2 khi thêm chi tiết hóa đơn
DELIMITER //
CREATE TRIGGER trg_CheckInvoiceDetail
BEFORE INSERT ON InvoiceDetail
FOR EACH ROW
BEGIN
    DECLARE maxDebt DECIMAL(10, 2);
    DECLARE minStockAfterSale INT;
    DECLARE currentStock INT;
    DECLARE currentDebt DECIMAL(10, 2);

    SELECT Max_Debt, Min_Stock_After_Sale INTO maxDebt, minStockAfterSale FROM RegulationSettings WHERE Regulation_ID = 1;

    SELECT Current_Stock INTO currentStock FROM Books WHERE bookID = NEW.bookID;

    SELECT Debt INTO currentDebt FROM Customers WHERE customerID = (SELECT ID_Customer FROM Invoice WHERE ID_Invoice = NEW.ID_Invoice);

    IF currentStock - NEW.Quantity_Sold < minStockAfterSale THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng tồn sau khi bán không được nhỏ hơn số lượng tồn tối thiểu theo quy định.';
    END IF;

    IF currentDebt > maxDebt THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số tiền nợ hiện tại của khách hàng đã vượt quá giới hạn nợ tối đa cho phép.';
    END IF;
END//
DELIMITER ;

-- Trigger kiểm tra QĐ4 khi thêm phiếu thu tiền
DELIMITER //
CREATE TRIGGER trg_CheckPaymentReceipt
BEFORE INSERT ON PaymentReceipt
FOR EACH ROW
BEGIN
    DECLARE useRegulation4 BOOLEAN;
    DECLARE currentDebt DECIMAL(10, 2);

    SELECT Use_Regulation_4 INTO useRegulation4 FROM RegulationSettings WHERE Regulation_ID = 1;

    IF useRegulation4 THEN
        SELECT Debt INTO currentDebt FROM Customers WHERE customerID = NEW.ID_Customer;

        IF NEW.Amount_Collected > currentDebt THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Số tiền thu không được vượt quá số tiền khách hàng đang nợ.';
        END IF;
    END IF;
END//
DELIMITER ;


-- Sample data for testing PaymentReceipt
INSERT INTO PaymentReceipt (Receipt_Date, ID_Customer, Amount_Collected, customer_name, address, phone, email, note)
VALUES
('2023-10-01', 'KH001', 50.00, 'Nguyễn Văn A', '123 Phố Lý Thái Tổ', '0901234567', 'nguyenvana@example.com', 'Thanh toán lần 1'),
('2023-10-02', 'KH002', 100.00, 'Trần Thị B', '45 Nguyễn Huệ', '0912345678', 'tranthib@example.com', 'Thanh toán lần 2'),
('2023-10-03', 'KH003', 75.50, 'Lê Minh C', '12 Trần Phú', '0923456789', 'leminhc@example.com', 'Thanh toán lần 3'),
('2023-10-04', 'KH004', 0.00, 'Phạm Văn D', '78 Hùng Vương', '0934567890', 'phamvand@example.com', 'Thanh toán lần 4'),
('2023-10-05', 'KH005', 25.75, 'Hoàng Thị E', '34 Bà Triệu', '0945678901', 'hoangthie@example.com', 'Thanh toán lần 5'),
('2023-10-06', 'KH006', 50.00, 'Đặng Ngọc F', '56 Lạch Tray', '0956789012', 'dangngocf@example.com', 'Thanh toán lần 6'),
('2023-10-07', 'KH001', 30.00, 'Nguyễn Văn A', '123 Phố Lý Thái Tổ', '0901234567', 'nguyenvana@example.com', 'Thanh toán lần 7'),
('2023-10-08', 'KH002', 80.00, 'Trần Thị B', '45 Nguyễn Huệ', '0912345678', 'tranthib@example.com', 'Thanh toán lần 8'),
('2023-10-09', 'KH003', 60.50, 'Lê Minh C', '12 Trần Phú', '0923456789', 'leminhc@example.com', 'Thanh toán lần 9'),
('2023-10-10', 'KH004', 0.00, 'Phạm Văn D', '78 Hùng Vương', '0934567890', 'phamvand@example.com', 'Thanh toán lần 10'),
('2023-10-11', 'KH005', 20.75, 'Hoàng Thị E', '34 Bà Triệu', '0945678901', 'hoangthie@example.com', 'Thanh toán lần 11'),
('2023-10-12', 'KH006', 40.00, 'Đặng Ngọc F', '56 Lạch Tray', '0956789012', 'dangngocf@example.com', 'Thanh toán lần 12'),
('2023-10-13', 'KH001', 45.00, 'Nguyễn Văn A', '123 Phố Lý Thái Tổ', '0901234567', 'nguyenvana@example.com', 'Thanh toán lần 13'),
('2023-10-14', 'KH002', 90.00, 'Trần Thị B', '45 Nguyễn Huệ', '0912345678', 'tranthib@example.com', 'Thanh toán lần 14'),
('2023-10-15', 'KH003', 70.50, 'Lê Minh C', '12 Trần Phú', '0923456789', 'leminhc@example.com', 'Thanh toán lần 15'),
('2023-10-16', 'KH004', 0.00, 'Phạm Văn D', '78 Hùng Vương', '0934567890', 'phamvand@example.com', 'Thanh toán lần 16'),
('2023-10-17', 'KH005', 35.75, 'Hoàng Thị E', '34 Bà Triệu', '0945678901', 'hoangthie@example.com', 'Thanh toán lần 17'),
('2023-10-18', 'KH006', 55.00, 'Đặng Ngọc F', '56 Lạch Tray', '0956789012', 'dangngocf@example.com', 'Thanh toán lần 18');

-- Sample data for testing Invoice and InvoiceDetail
INSERT INTO Invoice (ID_Invoice, Date_Issued, ID_Customer, Total_Amount)
VALUES
(1, '2023-10-01', 'KH001', 200.00),
(2, '2023-10-02', 'KH002', 300.00),
(3, '2023-10-03', 'KH003', 150.00),
(4, '2023-10-04', 'KH004', 250.00),
(5, '2023-10-05', 'KH005', 100.00),
(6, '2023-10-06', 'KH006', 200.00),
(7, '2023-10-07', 'KH001', 180.00),
(8, '2023-10-08', 'KH002', 220.00),
(9, '2023-10-09', 'KH003', 160.00),
(10, '2023-10-10', 'KH004', 240.00),
(11, '2023-10-11', 'KH005', 120.00),
(12, '2023-10-12', 'KH006', 210.00),
(13, '2023-10-13', 'KH001', 190.00),
(14, '2023-10-14', 'KH002', 230.00),
(15, '2023-10-15', 'KH003', 170.00),
(16, '2023-10-16', 'KH004', 260.00),
(17, '2023-10-17', 'KH005', 130.00),
(18, '2023-10-18', 'KH006', 220.00);

INSERT INTO InvoiceDetail (ID_Invoice, bookID, Quantity_Sold, Selling_Price)
VALUES
(1, 1, 2, 100.00),
(1, 2, 1, 100.00),
(2, 3, 3, 100.00),
(2, 4, 2, 100.00),
(3, 5, 1, 100.00),
(3, 6, 1, 50.00),
(4, 7, 2, 100.00),
(4, 8, 1, 50.00),
(5, 9, 1, 100.00),
(6, 10, 2, 100.00),
(6, 11, 1, 100.00),
(7, 12, 3, 100.00),
(7, 13, 2, 100.00),
(8, 14, 1, 100.00),
(8, 15, 1, 50.00),
(9, 16, 2, 100.00),
(9, 17, 1, 50.00),
(10, 18, 1, 100.00),
(10, 19, 2, 100.00),
(11, 20, 3, 100.00),
(11, 21, 2, 100.00),
(12, 22, 1, 100.00),
(12, 23, 1, 50.00),
(13, 24, 2, 100.00),
(13, 25, 1, 50.00),
(14, 26, 1, 100.00),
(14, 27, 2, 100.00),
(15, 28, 3, 100.00),
(15, 29, 2, 100.00),
(16, 30, 1, 100.00),
(16, 31, 1, 50.00),
(17, 32, 2, 100.00),
(17, 33, 1, 50.00),
(18, 34, 1, 100.00),
(18, 35, 2, 100.00);

-- Sample data for testing BookEntry and EntryDetail
INSERT INTO BookEntry (ID_Entry, Entry_Date)
VALUES
(1, '2023-10-01'),
(2, '2023-10-02'),
(3, '2023-10-03'),
(4, '2023-10-04'),
(5, '2023-10-05'),
(6, '2023-10-06'),
(7, '2023-10-07'),
(8, '2023-10-08'),
(9, '2023-10-09'),
(10, '2023-10-10');

INSERT INTO EntryDetail (ID_Entry, bookID, Quantity_Added, Purchase_Price)
VALUES
(1, 1, 150, 70.00),
(1, 2, 150, 60.00),
(2, 3, 150, 80.00),
(2, 4, 150, 70.00),
(3, 5, 150, 75.00),
(3, 6, 150, 60.00),
(4, 7, 150, 70.00),
(4, 8, 150, 60.00),
(5, 9, 150, 80.00),
(5, 10, 150, 70.00),
(6, 11, 150, 75.00),
(6, 12, 150, 60.00),
(7, 13, 150, 70.00),
(7, 14, 150, 60.00),
(8, 15, 150, 80.00),
(8, 16, 150, 70.00),
(9, 17, 150, 75.00),
(9, 18, 150, 60.00),
(10, 19, 150, 70.00),
(10, 20, 150, 60.00);

-- Sample data for testing InventoryReport
INSERT INTO InventoryReport (Month, bookID, Opening_Stock, Transactions, Closing_Stock)
VALUES
('2023-10-01', 1, 100, 50, 50),
('2023-10-01', 2, 100, 30, 70),
('2023-10-01', 3, 100, 20, 80),
('2023-10-01', 4, 100, 40, 60),
('2023-10-01', 5, 100, 10, 90),
('2023-10-01', 6, 100, 50, 50),
('2023-10-01', 7, 100, 30, 70),
('2023-10-01', 8, 100, 20, 80),
('2023-10-01', 9, 100, 40, 60),
('2023-10-01', 10, 100, 10, 90),
('2023-10-01', 11, 100, 50, 50),
('2023-10-01', 12, 100, 30, 70),
('2023-10-01', 13, 100, 20, 80),
('2023-10-01', 14, 100, 40, 60),
('2023-10-01', 15, 100, 10, 90),
('2023-10-01', 16, 100, 50, 50),
('2023-10-01', 17, 100, 30, 70),
('2023-10-01', 18, 100, 20, 80),
('2023-10-01', 19, 100, 40, 60),
('2023-10-01', 20, 100, 10, 90);

-- Sample data for testing DebtReport
INSERT INTO DebtReport (Month, ID_Customer, Opening_Debt, Transactions, Closing_Debt)
VALUES
    ('2024-01-01', 'KH001', 100.00, 50.00, 150.00),
    ('2024-01-01', 'KH002', 200.00, -100.00, 100.00),
    ('2024-01-01', 'KH003', 150.50, 50.00, 200.50),
    ('2024-01-01', 'KH004', 0.00, 100.00, 100.00),
    ('2024-01-01', 'KH005', 50.75, -25.75, 25.00),
    ('2024-01-01', 'KH006', 75.00, 25.00, 100.00),
    ('2024-02-01', 'KH001', 150.00, -50.00, 100.00),
    ('2024-02-01', 'KH002', 100.00, 50.00, 150.00),
    ('2024-02-01', 'KH003', 200.50, -50.50, 150.00),
    ('2024-02-01', 'KH004', 100.00, 0.00, 100.00),
    ('2024-02-01', 'KH005', 25.00, 25.75, 50.75),
    ('2024-02-01', 'KH006', 100.00, -25.00, 75.00),
    ('2024-03-01', 'KH001', 100.00, 50.00, 150.00),
    ('2024-03-01', 'KH002', 150.00, -50.00, 100.00),
    ('2024-03-01', 'KH003', 150.00, 0.00, 150.00),
    ('2024-03-01', 'KH004', 100.00, 50.00, 150.00),
    ('2024-03-01', 'KH005', 50.75, -25.75, 25.00),
    ('2024-03-01', 'KH006', 75.00, 25.00, 100.00),
    ('2024-04-01', 'KH001', 150.00, -75.00, 75.00),
    ('2024-04-01', 'KH002', 100.00, 50.00, 150.00);

-- Sample data for testing Orders
INSERT INTO Orders (orderID, customerID, bookID, quantity, total, timestamp)
VALUES
(1, 'KH001', 1, 3, 300000, '2023-10-01 10:00:00'),
(2, 'KH002', 3, 3, 330000, '2023-10-02 11:00:00'),
(3, 'KH003', 3, 3, 335000, '2023-10-03 12:00:00'),
(4, 'KH004', 4, 1, 95000, '2023-10-04 13:00:00'),
(5, 'KH005', 5, 2, 200000, '2023-10-05 14:00:00'),
(6, 'KH006', 6, 1, 85000, '2023-10-06 15:00:00'),
(7, 'KH001', 7, 1, 95000, '2023-10-07 16:00:00'),
(8, 'KH002', 9, 2, 300000, '2023-10-08 17:00:00'),
(9, 'KH003', 9, 1, 150000, '2023-10-09 18:00:00'),
(10, 'KH004', 18, 1, 130000, '2023-10-10 19:00:00');


SELECT * FROM Admins;
SELECT * FROM Customers;
SELECT * FROM Authors;
SELECT * FROM Publishers;
SELECT * FROM Inventory;
SELECT * FROM Books;
SELECT * FROM Orders;
SELECT * FROM Payment;
SELECT * FROM ContactUs;

-- TRANSACTION
DELIMITER $$
CREATE PROCEDURE temp()
BEGIN
	DECLARE _rollback BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR 1051 SET _rollback=1;
    DECLARE CONTINUE HANDLER FOR 1048 SET _rollback=1;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET _rollback=1;
	START TRANSACTION;
		INSERT INTO Orders(customerID,bookID,quantity,total,timestamp) VALUES('','','','','');
        UPDATE Inventory SET soldStock = soldStock + '' WHERE bookID = '';
        UPDATE Inventory SET totalStock = totalStock + '' WHERE bookID = '';
        INSERT INTO Payment(customerID,paymentInfo) VALUES ('','');
		IF _rollback = 1 THEN
			ROLLBACK;
		ELSE
			COMMIT;
		END IF;
END $$
DELIMITER ;

