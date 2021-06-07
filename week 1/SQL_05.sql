USE AdventureWorks2019

CREATE TABLE Member 
(
	MemberID	INT				PRIMARY KEY IDENTITY (1,1),
	Username	VARCHAR(100)	NOT NULL,
	Password	VARCHAR(100)	NOT NULL,
	Email		VARCHAR(100)	NOT NULL,
	Fullname	VARCHAR(100)	NOT NULL,
	Address		VARCHAR(100)	NOT NULL,
	Phone		VARCHAR(100)	NOT NULL,
	Gender		VARCHAR(8)		NOT NULL,
	BirthDate	VARCHAR(12)		NOT NULL
);

CREATE TABLE Product 
(
	ProductID		INT				PRIMARY KEY IDENTITY (1,1),
	ProductName		VARCHAR(100)	NOT NULL,
	ProductType		VARCHAR(20)		NOT NULL,
	Description		VARCHAR(100)	NOT NULL,
	Stock			INT				NOT NULL,
	Price			INT				NOT NULL,
	ImageSource		VARCHAR(50)		NOT NULL
);

CREATE TABLE Rating 
(
	RatingID		INT		PRIMARY KEY IDENTITY (1,1),
	MemberID		INT		NOT NULL,
	ProductID		INT		NOT NULL,
	Value			INT		NOT NULL,
	FOREIGN KEY (MemberID) REFERENCES Member (MemberID),
	FOREIGN KEY (ProductID) REFERENCES Product (ProductID)
);

CREATE TABLE Comment
(
	CommentID		INT				PRIMARY KEY IDENTITY (1,1),
	MemberID		INT				NOT NULL,
	ProductID		INT				NOT NULL,
	Message			VARCHAR(150)	NOT NULL,
	FOREIGN KEY (MemberID) REFERENCES Member (MemberID),
	FOREIGN KEY (ProductID) REFERENCES Product (ProductID)
);

CREATE TABLE nTransaction
(
	TransactionID	INT				PRIMARY KEY IDENTITY (1,1),
	MemberID		INT				NOT NULL,
	ProductID		INT				NOT NULL,
	Quantity		INT				DEFAULT 0,
	ApprovalStatus	VARCHAR(10)		NOT NULL,
	FOREIGN KEY (MemberID) REFERENCES Member (MemberID),
	FOREIGN KEY (ProductID) REFERENCES Product (ProductID)
);

CREATE TABLE Cart
(
	CartID			INT				PRIMARY KEY IDENTITY (1,1),
	MemberID		INT				NOT NULL,
	ProductID		INT				NOT NULL,
	Quantity		INT				DEFAULT 0,
	FOREIGN KEY (MemberID) REFERENCES Member (MemberID),
	FOREIGN KEY (ProductID) REFERENCES Product (ProductID)
);

