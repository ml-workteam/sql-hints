CREATE PROCEDURE up_DeleteUser @ID int = NULL, @Email varchar(100) = NULL, @Option varchar(10) = NULL
AS

-- ***************************************************************************************************************************
-- USAGE: up_DeleteUser {@ID = Number | @Email = 'email@email.com'} [, @Option = 'OptionTitle']
-- WHERE: Number is UserID, email@email.com is user email. You can use @ID or @Email but not @ID and @Email at the same time.
--               Option is string(max 10 chars) used to track deletion initiator. 
-- ***************************************************************************************************************************

-- IF ID OR EMAIL are not present,
IF (@ID IS NULL) AND (@Email IS NULL)
BEGIN
	SELECT -1 err, '@ID or @Email must be specified.' errdescr
	RETURN -1 -- then EXIT
END

-- IF ID AND EMAIL present, 
IF (@ID IS NOT NULL) AND (@Email IS NOT NULL)
BEGIN
	SELECT -2 err, 'You cannot use @ID and @Email at the same time. Use @ID or @Email' errdescr
	RETURN -2 -- then EXIT
END


DECLARE @UserID int
SET @UserID = NULL

--IF ID presents
IF (@ID IS NOT NULL)
BEGIN
	IF EXISTS(SELECT UserID FROM Users WHERE UserID = @ID)
	BEGIN
		UPDATE Users SET UserOption = @Option WHERE UserID = @ID
		DELETE FROM Users WHERE UserID = @ID
		SELECT 0 err, 'User deleted by ID' errdescr
	END
	ELSE SELECT -3 err, 'User with ID = ' + CONVERT(varchar(10), @ID) + ' does not exists.' errdescr
	RETURN 0
END

IF (@Email IS NOT NULL)
BEGIN
	IF EXISTS (SELECT UserID FROM Users WHERE UserEmail = @Email)
	BEGIN
		SELECT @UserID = UserID FROM Users WHERE UserEmail = @Email
		UPDATE Users SET UserOption = @Option WHERE UserID = @UserID
		DELETE FROM Users WHERE UserID = @UserID
		SELECT 0 err, 'User deleted by Email' errdescr
	END
	ELSE SELECT -3 err, 'User with Email = ' + CONVERT(varchar(100), @Email) + ' does not exists.' errdescr
	RETURN 0
END
GO
