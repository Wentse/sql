# Въведение в SQL

## Основни понятия

* SQL - език за  съставяне на заявки към сървъри за бази данни (БД)
* всяка БД се състои от множество таблици, в които се намират даните
* всяка таблица съответства на определен обект от модела на БД
* обект в модела на БД е нещо, за което събираме данни: Продукти, Коментари,
      Потребители, Плащания и т.н.

* **първичен ключ** (PK - Primary Key) e уникалният за дадена таблица 
идентификатор на редовете

  (pk)  user                   (pk)     posts
+-----+-----------+           +----+----------------+
| UID | UserName  |           | PID| Post           |
+-----+-----------+           +----+----------------+
|  1  |  John     |           | 1  |Hello ...       |
+-----+-----------+           +----+----------------+
|  2  |  Maria    |           | 2  |MySQL is...     |
+-----+-----------+           +----+----------------+
|  3  |  Peter    |           | 3  |SQL query...    |
+-----+-----------+           +----+----------------+
|  4  |  Anna     |           | 4  |Oracle driver...|
+-----+-----------+           +----+----------------+

* **външен ключ** (FK - Foreign Key) e идентификатор, който задава съответствието
на редовете от една таблица към друга таблица

  (pk)  user                   (pk)     posts        (fk)
+-----+-----------+           +----+----------------+------+
| UID | UserName  |           | PID| Post           | UID  |
+-----+-----------+           +----+----------------+------+
|  1  |  John     |           | 1  |Hello ...       |  1   |
+-----+-----------+           +----+----------------+------+
|  2  |  Maria    |           | 2  |MySQL is...     |  2   |
+-----+-----------+----------<-----+----------------+------+
|  3  |  Peter    |           | 3  |SQL query...    |  1   |
+-----+-----------+           +----+----------------+------+
|  4  |  Anna     |           | 4  |Oracle driver...|  2   |
+-----+-----------+           +----+----------------+------+


### Връзки между таблиците 

* 1:М -> на един ред от А съответстват един или повече реда от B
* 1:1 -> на един ред от А съответства точно един ред от B
* M:N -> на един ред от А съответстват един или повече реда от B, обратното 
             също е вярно; обикновено се преработва до 1:M и N:1
 


### Референциална цялост на БД (интегритет)

С данните могат да бъдат извършвани четири основни опрации:

* ЧЕТЕНЕ на **данни**
* ДОБАВЯНЕ на **редове** 
* ПРОМЯНА на **данни** (рестриктивно/каскадно)
* ИЗТРИВАНЕ на **редове** (рестриктивно/каскадно)

ЧЕТЕНЕТО на данни няма отношение към референциалната цялост, тъй като при тази 
операция не се променя съдържанието на таблиците

При ДОБАВЯНЕ определя последователността на действията (1. добавя се ред от 
страната 1; 2. добавя се ред от страната М).

За ПРОМЯНА/ИЗТРИВАНЕ интегритета може да се поддържа по два начина: рестриктивно
или каскадно.

  (pk)  user                   (pk)     posts        (fk)
+-----+-----------+           +----+----------------+------+
| UID | UserName  |           | PID| Post           | UID  |
+-----+-----------+           +----+----------------+------+
|  1  |  John     |           | 1  |Hello ...       |  1   |
+-----+-----------+           +----+----------------+------+
|  2  |  Maria    |           | 2  |MySQL is...     |  2   |
+-----+-----------+----------<+----+----------------+------+
|  3  |  Peter    |           | 3  |SQL query...    |  1   |
+-----+-----------+           +----+----------------+------+
|  4  |  Anna     |           | 4  |Oracle driver...|  2   |
+-----+-----------+           +----+----------------+------+


## Модел на базата данни Northwind

```
1. https://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/xe-prior-releases-5172097.html
2. http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html
 ако се наложи 
 2.1. http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

3. https://notepad-plus-plus.org/download/v7.7.1.html

```

## SQL - Structured Query Language

* езикът SQL се състои от две групи изрази: DDL и DML.

### DDL - Data Definition Language 

* CREATE ... ->създава обект (таблица, изглед, процедура, индекс и т.н.) 
* ALTER ...  ->променя съществуващ обект
* DROP ....  ->премахва обект 

### DML - Data Manipulation Language 

* SELECT ... ->чете данни от таблиците
* INSERT ... ->добавя редове към таблица
* UPDATE ... ->променя данни от таблица 
* DELETE ... ->изтрива редове от таблица

## SELECT заявки

```sql
SELECT * | col1, col2,...
FROM  table(s)
[WHERE col1 operator value1 ... ]
```

```sql
SELECT *
FROM customers
---
SELECT country
, company_name
, contact_name
, phone
FROM customers

```

### WHERE клауза

* филтрира данните от таблиците включени в заявката
* при повече от едно условие, отделните условия се свързват с AND или OR

+=======================+=====================================================+
| WHERE                 | Действие                                            |
+=======================+=====================================================+
| [1] AND [2]           | трябва да са изпълнени  [1]  и [2]                  |
+-----------------------+-----------------------------------------------------+
| [1] OR  [2]           | може да са изпълнени [1] или [2] или и двете заедно |
+-----------------------+-----------------------------------------------------+
| [1] OR  [2]  AND [3]  | [1] или [2],[3]  (2 и 3 са едно цяло)               |
+-----------------------+-----------------------------------------------------+
| ([1] OR [2] ) AND [3] | [1],[2]- едно от двете или двете заедно, [3]-винаги |
+-----------------------+-----------------------------------------------------+


**Кои редове ще се върнат в резултата?**

```sql
WHERE (1) OR (2) AND (3)  -- по подобие на 5 + 6 * 3
--     a      b       c
```

+----+---+---+---+
| a  | b | c | v |
+----+---+---+---+
| d  | b | c | v |
+----+---+---+---+
| d  | e | c | x |
+----+---+---+---+
| g  | b | c | v |
+----+---+---+---+
| a  | b | f | v |
+----+---+---+---+

```sql
WHERE ( (1) OR (2) ) AND (3)  -- по подобие на ( 5 + 6 ) * 3 => 5 * 3 + 6 * 3
--       a      b         c   -- или ((1) OR (2) ) AND (3) е като 
                              --     (1) AND (3) OR (2) AND (3)
```

+----+---+---+---+
| a  | b | c | v |
+----+---+---+---+
| d  | b | c | v |
+----+---+---+---+
| d  | e | c | x |
+----+---+---+---+
| g  | b | c | v |
+----+---+---+---+
| a  | b | f | x |
+----+---+---+---+



* оператори за филтриране на числа, дати и символи (char - ЕГН,Банкова сметка,..)

+---------------------------------+-------------------------------------------+
| Оператори                       | Пример                                    |
+---------------------------------+-------------------------------------------+
| >, <, >=, <=, =, <>             | WHERE price > 20 AND price <> 50          |
+---------------------------------+-------------------------------------------+
| [NOT] IN ('val1','val2',....)   | WHERE itemID IN ('AA123','AB456','BD213') |
+---------------------------------+-------------------------------------------+
| [NOT] BETWEEN 'val1' AND 'val2' | WHERE price BETWEEN 5 AND 30              |
+---------------------------------+-------------------------------------------+


```sql
SELECT order_id
, order_date
, ship_country
, ship_city
FROM orders
WHERE order_date >= '2015-07-01' AND order_date <= '2015-07-19'
-----
SELECT customer_id
, order_id
, order_date
, ship_country
FROM orders
WHERE customer_id IN (1,8,57)
---
SELECT customer_id
, customer_code
, company_name
, country
, city
FROM customers
WHERE customer_code IN ('ALFKI','BOLID','PARIS') --AND ...
-----
-- Същото като
SELECT customer_id
, customer_code
, company_name
, country
, city
FROM customers
WHERE customer_code = 'ALFKI' OR customer_code = 'BOLID' OR customer_code = 'PARIS' --AND ...
----
SELECT product_name
, quantity_per_unit
, unit_price
FROM products
WHERE unit_price BETWEEN 10 AND 20 
---
SELECT product_name
, quantity_per_unit
, unit_price
FROM products
WHERE unit_price NOT BETWEEN 10 AND 20
---
-- Същото като
SELECT product_name
, quantity_per_unit
, unit_price
FROM products
WHERE unit_price >= 10 AND unit_price <= 20  
---
-- заместване на NOT BETWEEN
SELECT product_name
, quantity_per_unit
, unit_price
FROM products
WHERE unit_price < 10 OR unit_price > 20  
```

* оператори за филтриране на текст (varchar, text)

+---------------------------------------+----------------------------------------------------+
| Оператори                             | Пример                                             |
+---------------------------------------+----------------------------------------------------+
| [NOT] LIKE 'pattern'                  | ```WHERE title LIKE 'The blue %'```                |
+---------------------------------------+----------------------------------------------------+
| REGEXP_LIKE(column, pattern[, match]) | ```WHERE REGEXP_LIKE(company_name, '^A.*[ae]$')``` |
+---------------------------------------+----------------------------------------------------+

```sql
col = 'Maria'

'Mario'

col LIKE 'M%' => 'M', 'Ma', 'Mab', ...


col LIKE 'M_' => 'Ma', 'Mb', ..., 'M ', но не 'М' или 'Маb'
```

```sql
SELECT customer_code
, contact_name
FROM customers
WHERE contact_name LIKE 'M%'
----
SELECT customer_code
, contact_name
FROM customers
WHERE contact_name LIKE 'M_r%'
```

```sql
'Xyz Abcd'
'__% A___%'

' Асен Петров'
'Мария Петров а'

LIKE ''

1) A%
2) _% A%
3) __ A%
4) % A%
```

```sql
SELECT customer_code
, contact_name
FROM customers
WHERE contact_name LIKE '__% A___%'
```

* основни оператори за съставяне на регулярни изрази (pattern)

+----------+-------------------------------------+------------------+
| Оператор | Действие                            | Пример           |
+----------+-------------------------------------+------------------+
| ^        | редът да започва с                  | ```'^Maria'```   |
+----------+-------------------------------------+------------------+
| $        | редът да завършва с                 | ```'son$'```     |
+----------+-------------------------------------+------------------+
| .        | всеки символ                        | ```'.*'```       |
+----------+-------------------------------------+------------------+
| {n}      | n - пъти                            |                  |
| {n,m}    | поне n пъти, но не повече от m пъти | ```'^.n{1,2}'``` |
| {,m}     | не повече от m пъти                 |                  |
| {n,}     |                                     |                  |
+----------+-------------------------------------+------------------+
| [списък] | един от символите в списъка         | ```'^Mar[yt]'``` |
+----------+-------------------------------------+------------------+
| *        | нула или повече срещания            |                  |
+----------+-------------------------------------+------------------+
| ?        | нула или едно срещане               |                  |
+----------+-------------------------------------+------------------+
| +        | едно или повече срещания            |                  |
+----------+-------------------------------------+------------------+

* допълнителни настройки на процеса на търсене (match)

+-------+----------------------------------+
| match | действие                         |
+-------+----------------------------------+
| i     | да не е чувствително към аА      |
+-------+----------------------------------+
| c     | да е чувствително към аА         |
+-------+----------------------------------+
| n     | да третира . като част от текста |
+-------+----------------------------------+
| m     | текстът е многоредов             |
+-------+----------------------------------+

```sql
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, '^A')
---
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, '^A|^M')
---
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, '^(A|M)')
---
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, 'er$')
---
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, '^An.')
---
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, 'n{2}|a{2}|t{2}')
---
-- 'Xyz Bennett'
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, 'n{2}.t{2}$')
----
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, '^Mar[ity]')
----
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, '^Mar[a-zA-Z0-9 ]')
-----
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, '^Mar[^ty]')
----
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, ' A[a-z]+$')
----
SELECT contact_name
FROM customers
WHERE REGEXP_LIKE(contact_name, '^\w+\s\w+\s\w+$')
```

1. https://docs.oracle.com/cd/E11882_01/server.112/e41084/ap_posix003.htm#SQLRF55544
2. https://regexr.com/


```sql
ALTER SESSION SET NLS_COMP=LINGUISTIC;

ALTER SESSION SET NLS_SORT=BINARY_CI;
```


## Свързване на таблици в SELECT

* свързвайки таблици в SELECT можем да комбинираме редовете и колоните от 2 или 
повече таблици

### Видове свързвания

* INNER JOIN (Вътрешно съединение)

В резултата ще се върнат всички редове от таблица А и таблица В, за които е 
изпълнено **B.FK = A.PK** 


  (pk)  user                   (pk)     posts     (fk)
+-----+-----------+           +----+-------------+------+
| UID | UserName  |           | PID| Post        | UID  |
+-----+-----------+           +----+-------------+------+
|  1  |  John     |           | 1  |Hello ...    |  1   |
+-----+-----------+           +----+-------------+------+
|  2  |  Maria    |           | 2  |MySQL is...  |  2   |
+-----+-----------+---------< +----+-------------+------+
|  3  |  Peter    |           | 3  |SQL query... |  1   |
+-----+-----------+           +----+-------------+------+
|  4  |  Anna     |           | 4  |PHP driver...|  2   |
+-----+-----------+           +----+-------------+------+

Резултат:

+-----------+-------------+------+
| UserName  | Post        | UID  |
+-----------+-------------+------+
|  John     |Hello ...    |  1   |
+-----------+-------------+------+
|  Maria    |MySQL is...  |  2   |
+-----------+-------------+------+
|  John     |SQL query... |  1   |
+-----------+-------------+------+
|  Maria    |PHP driver...|  2   |
+-----------+-------------+------+

* псевдоними на таблици

```sql
SELECT table1.column1, table2.column2, table2.column5
FROM table1 
       INNER JOIN 
     table2 
     ON table2.fk_column = table1.pk_column
```

```sql
FROM BANKSTATEMENTLINEBANKDOCUMENTINFORMATION
```

```sql
SELECT t1.column1, t2.column2, t2.column5
FROM table1 t1 
       INNER JOIN 
     table2 t2
     ON t2.fk_column = t1.pk_column
```

```sql
SELECT t1.customer_code
, t1.company_name
, t2.order_id
, t2.order_date
, t2.ship_country
, t1.country
FROM customers t1
        INNER JOIN
     orders t2
        ON t2.customer_id = t1.customer_id
WHERE t1.customer_code IN ('ALFKI','BOLID','PARIS')
---
SELECT t1.customer_id
, t1.order_id
, t1.order_date
, t3.product_name
, t2.quantity
, t2.unit_price
FROM orders t1
        INNER JOIN
     order_details t2
        ON t2.order_id = t1.order_id
        INNER JOIN
     products t3
        ON t2.product_id = t3.product_id
WHERE t1.customer_id = 1 --ALFKI
ORDER BY t1.order_id
---
SELECT t1.customer_id
, t1.order_id invoiceNo
, t1.order_date
, t3.product_name
, t2.quantity
, t2.unit_price 
, t2.quantity * t2.unit_price total -- може и така: as total
, t2.quantity * t2.unit_price * 1.2 totalVAT
FROM orders t1
        INNER JOIN
     order_details t2
        ON t2.order_id = t1.order_id
        INNER JOIN
     products t3
        ON t2.product_id = t3.product_id
WHERE t1.customer_id = 1 --ALFKI
ORDER BY t1.order_id
---
SELECT t1.customer_id
, t1.order_id invoiceNo
, t1.order_date
, t3.product_name
, t2.quantity
, t2.unit_price 
, t2.quantity * t2.unit_price total -- може и така: as total
, t2.quantity * t2.unit_price * 1.2 totalVAT
FROM orders t1
        INNER JOIN
     order_details t2
        ON t2.order_id = t1.order_id
        INNER JOIN
     products t3
        ON t2.product_id = t3.product_id
WHERE t1.customer_id = 1 --ALFKI
        AND
      t2.quantity * t2.unit_price < 100
ORDER BY total DESC
```

```sql
ORDER BY col1 [ASC]|DESC, col2 [ASC]|DESC, ...
--или
ORDER BY 1 [ASC]|DESC, 2 [ASC]|DESC, ...
```
