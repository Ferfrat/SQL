1. Создать таблицу поставка (supply), которая имеет такую структуру:
supply_id - INT PRIMARY KEY AUTO_INCREMENT
title - VARCHAR(50)
author - VARCHAR(30)
price -	DECIMAL(8, 2)
amount- INT


CREATE TABLE supply
(
    supply_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8,2),
    amount INT
)
;


2. Занесите в таблицу supply четыре записи, чтобы получилась следующая таблица:

supply_id	title	          author	    price	amount
1	        Лирика	          Пастернак Б.Л.    518.99	2
2	        Черный человек 	  Есенин С.А.	    570.20	6
3	        Белая гвардия	  Булгаков М.А.	    540.50	7
4	        Идиот	          Достоевский Ф.М.  360.80	3


INSERT INTO supply (title, author, price, amount) 
VALUES 
    ('Лирика','Пастернак Б.Л.', 518.99, 2),
    ('Черный человек', 'Есенин С.А.', 570.20, 6),
    ('Белая гвардия', 'Булгаков М.А.', 540.50, 7),
    ('Идиот', 'Достоевский Ф.М.', 360.80, 3)
;


3.Добавить из таблицы supply в таблицу book, все книги, кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.

INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount
FROM supply
WHERE author <> 'Булгаков М.А.' AND author <> 'Достоевский Ф.М.'
;


4. Занести из таблицы supply в таблицу book только те книги, авторов которых нет в  book.

INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount 
FROM supply
WHERE author NOT IN (
        SELECT author
        FROM book
      );


5. Для тех книг в таблице book , которые есть в таблице supply, не только увеличить их количество в таблице book 
(увеличить их количество на значение столбца amount таблицы supply), но и пересчитать их цену 
(для каждой книги найти сумму цен из таблиц book и supply и разделить на 2).

UPDATE book, supply 
SET book.amount = book.amount + supply.amount, book.price = (book.price + supply.price)/2
WHERE book.title = supply.title AND book.author = supply.author;


6. Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10

DELETE FROM supply 
WHERE author IN 
(
        SELECT author
        FROM book
        WHERE amount >= 10
)
