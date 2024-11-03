CREATE DATABASE IF NOT EXISTS BookStore;
USE BookStore;
CREATE TABLE author
(
    author_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE DEFAULT NULL,
    PRIMARY KEY (author_id)
);
CREATE TABLE language
(
  language_id INT AUTO_INCREMENT,
  language_name VARCHAR(50) UNIQUE NOT NULL,
  PRIMARY KEY (language_id)
);
CREATE TABLE book
(
    isbn CHAR(13) PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    language_id INT,
    author_id INT,
    price DECIMAL(5,2) NOT NULL,
    publication_date DATE,
    FOREIGN KEY (language_id) REFERENCES language(language_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
CREATE TABLE bookstore
(
    bookstore_id INT AUTO_INCREMENT,
    store_name VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    PRIMARY KEY (bookstore_id)
);
CREATE TABLE inventory
(
    store_id INT,
    isbn CHAR(13),
    amount INT NOT NULL,
    PRIMARY KEY (store_id, isbn),
    FOREIGN KEY (store_id) REFERENCES bookstore(bookstore_id),
    FOREIGN KEY (isbn) REFERENCES book(isbn)
);

-- Lägg till författare
INSERT INTO author (author_id, first_name, last_name, birth_date) VALUES
    (1, 'Dav', 'Pilkey', '1966-03-04'),
    (2, 'Camilla', 'Brinck', '1974-05-24'),
    (3, 'Heather', 'Amery', NULL);

-- Lägg till språk
INSERT INTO language (language_id, language_name) VALUES
(1,'Swedish'),
(2,'English');

-- Lägg till böcker
INSERT INTO book (isbn, title, language_id, price, publication_date, author_id) VALUES
     ('9789178033638', 'Hundmannen', 1, 199.00, '2020-02-28', 1),
     ('9789132210631', 'Musse & Helium. Äventyret i Lindrizia', 1, 219.00, '2019-11-01', 2),
     ('9789179756123', 'Musse & Helium. Den sista kampen', 1, 219.00, '2020-10-28', 2),
     ('9781409562894', 'First Thousand Words in English', 2, 159.00, '2013-08-01', 3);

-- Lägg till butiker
INSERT INTO bookstore (store_name, city) VALUES
    ('Bokbok - en barnbokhandel', 'Stockholm'),
    ('Akademibokhandeln', 'Stockholm');

-- Lägg till inventarieposter
INSERT INTO inventory (store_id, isbn, amount) VALUES
          (1, '9789178033638', 10),
          (1, '9789132210631', 5),
          (1, '9789179756123', 5),
          (2, '9789178033638', 3),
          (2, '9781409562894', 5);

CREATE VIEW total_author_book_value AS
SELECT
    CONCAT(a.first_name, ' ', a.last_name) AS name,
    TIMESTAMPDIFF(YEAR, a.birth_date, CURDATE()) AS age,
    COUNT(b.isbn) AS book_title_count,
    COALESCE(SUM(i.amount * b.price), 0) AS inventory_value
FROM
    author a
        LEFT JOIN
    book b ON a.author_id = b.author_id
        LEFT JOIN
    inventory i ON b.isbn = i.isbn
GROUP BY
    a.author_id;

