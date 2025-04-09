USE [AccountManagementSystem]


/*
	created date :
	Created By:

	To insert procedure user
*/
CREATE PROCEDURE AMS.Proc_User_Insert
as begin
	insert into AMS.[User] (UserName, DOB, DOJ, Balance, AccountNo, MobileNo, CreatedBy) VALUES
	('somel sol', '1967-03-12' , '1979-05-04', 4000.0, 56, 89367284, 'god'),
	('gary uml', '1987-02-21' , '1993-04-04', 4000.0, 33, 89367284, 'god')
end

exec AMS.Proc_User_Insert

SELECT * FROM AMS.[User];

ALTER PROCEDURE AMS.Proc_User_Insert
  @UserName NVarchar(250),
  @DOB DateTime,
  @DOJ DateTime,
  @Balance Decimal(10,6),
  @AccountNo Int,
  @MobileNo Int,
  @CreatedBy Varchar(250) = 'defaultuser'
as begin
	insert into AMS.[User] (UserName, DOB, DOJ, Balance, AccountNo, MobileNo, CreatedBy) VALUES
	(@UserName, @DOB, @DOJ, @Balance, @AccountNo, @MobileNo, @CreatedBy) 
end

exec AMS.Proc_User_Insert 'testing', '2025-02-02', '2025-02-02', 500, 123, 9876

	

/*DELETE FROM AMS.[User]
WHERE UserID BETWEEN 39 AND 70;
DELETE FROM AMS.[User]
WHERE UserID=8;*/

CREATE PROCEDURE AMS.Proc_UserAndAddress_Insert
  @UserName NVarchar(250),
  @DOB DateTime,
  @DOJ DateTime,
  @Balance Decimal(10,6),
  @AccountNo Int,
  @MobileNo Int,
  @AddressDetail NVARCHAR(MAX),
  @CreatedBy Varchar(250) = 'defaultuser'
as begin

	DECLARE @UserID BIGINT

	insert into AMS.[User] (UserName, DOB, DOJ, Balance, AccountNo, MobileNo, CreatedBy) VALUES
	(@UserName, @DOB, @DOJ, @Balance, @AccountNo, @MobileNo, @CreatedBy) 

	set @UserID = SCOPE_IDENTITY()

	Insert INTO AMS.[Address](UserID, AddressDetail, CreatedBy)
	VALUES (@UserID, @AddressDetail, @CreatedBy)
end


SELECT * FROM AMS.[User];
SELECT * FROM AMS.[Address];

exec AMS.Proc_UserAndAddress_Insert 'testing', '2025-02-02', '2025-02-02', 500, 123, 9876, 'gseigfik'


---------------------
CREATE PROCEDURE AMS.Proc_UserAndAccount_Insert
  @UserName NVarchar(250),
  @DOB DateTime,
  @DOJ DateTime,
  @Balance Decimal(10,6),
  @AccountNo Int,
  @MobileNo Int,
  @IsSaving BIT,
  @CreatedBy Varchar(250) = 'defaultuser'
as begin

	DECLARE @UserID BIGINT

	insert into AMS.[User] (UserName, DOB, DOJ, Balance, AccountNo, MobileNo, CreatedBy) VALUES
	(@UserName, @DOB, @DOJ, @Balance, @AccountNo, @MobileNo, @CreatedBy) 

	set @UserID = SCOPE_IDENTITY()

	Insert INTO AMS.[Address](UserID, AddressDetail, CreatedBy)
	VALUES (@UserID, @AddressDetail, @CreatedBy)
end


SELECT * FROM AMS.[User];
SELECT * FROM AMS.[Address];

exec AMS.Proc_UserAndAddress_Insert 'testing', '2025-02-02', '2025-02-02', 500, 123, 9876, 'gseigfik'

-------------------------------------------------------------

create procedure AMS.Proc_UserAndAll_Insert
 @UserName	nvarchar(250),
 @DOB	datetime,
 @DOJ	datetime,
 @Balance	decimal(10, 6),
 @AccountNo	int,
 @MobileNo	int,
 @AddressDetail nvarchar(max),
 @IsSaving bit,
 @Amount decimal(20,2),
 @IsDebit bit,
 @CreatedBy	varchar(250) = 'defaultuser'
as begin
    
   declare @UserID bigint
   declare @AccountID bigint

   insert into AMS.[User] (UserName, DOB, DOJ, Balance, AccountNo, MobileNo, CreatedBy) values
   (@UserName, @DOB, @DOJ, @Balance, @AccountNo, @MobileNo, @CreatedBy)

   set @UserId = scope_identity()

   insert into AMS.[Address](UserId, AddressDetail, CreatedBy) 
   values (@UserId, @AddressDetail, @CreatedBy)

   INSERT INTO AMS.[Account](AccountNo, IsSaving, CreatedBy)
   VALUES(@AccountNo, @IsSaving, @CreatedBy)

   set @AccountID = SCOPE_IDENTITY()

   INSERT INTO AMS.UserAccountMapping(UserID, AccountID, CreatedBy)
   VALUES(@UserID, @AccountID, @CreatedBy)
   
   INSERT INTO AMS.AccountTransaction(AccountID, Amount, IsDebit, CreatedBy)
   VALUES(@AccountID, @Amount, @IsDebit, @CreatedBy)
end

exec AMS.Proc_UserAndAll_Insert 'ahfc', '2002-02-25', '2020-05-23', 1560.0, 12345543, 87673621, 'jahangir', 1, 5640.0, 0

SELECT * FROM AMS.[User];
SELECT * FROM AMS.[Address];
SELECT * FROM AMS.Account;
SELECT * FROM AMS.UserAccountMapping;
SELECT * FROM AMS.AccountTransaction;