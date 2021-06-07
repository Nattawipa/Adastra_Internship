USE AdventureWorks2019

-- exercise 1

-- 1.1 Create a table with SELECT INTO

SELECT * INTO stu_Document
from Production.Document 

SELECT * 
FROM stu_Document

-- 1.2 DELETE command

DELETE FROM stu_Document
WHERE Revision > 3

SELECT * 
FROM stu_Document

-- 1.3 UPDATE Command

UPDATE stu_Document
SET Title = 'Training Wheels 1' , FileName = 'Training Wheels 1.doc' 
WHERE Title = 'Training Wheels 2'

SELECT * 
FROM stu_Document

-- exercise 2

SELECT [BusinessEntityID],
	   [PersonType],
	   [NameStyle],
	   [Title],
	   [FirstName],
	   [MiddleName],
	   [LastName],
	   [Suffix]
 INTO stu_Person
 FROM [Person].[Person]
 WHERE 1 = 0;

 INSERT INTO stu_Person (BusinessEntityID, PersonType, NameStyle, Title, FirstName, LastName) 
 VALUES (1, 'TR', 0, 'Ms.','Nattawipa', 'Saetae'),
		(2, 'TR', 0, 'Mr.','Kittikorn', 'Keeratikriengkrai')

SELECT * 
FROM stu_Person  

-- Additional Task

INSERT INTO stu_Person (BusinessEntityID, PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix)
SELECT BusinessEntityID, PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix
FROM Person.Person
WHERE BusinessEntityID BETWEEN 200 AND 250

SELECT * 
FROM stu_Person 






