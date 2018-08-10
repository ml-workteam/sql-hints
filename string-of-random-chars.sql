
DECLARE @counter int,@r varchar(10),@p int,@i int

SET @i=0
SET @p=1

WHILE @i<100
BEGIN

	SET @i=@i+1
	SET @r=''
	SET @counter = 0
	SET @p=@p+1

	WHILE @counter <= 5
	   BEGIN
	      SET @counter = @counter + 1
	      SET @p=@p+1
	      SET @r=@r+char(9*rand(10000*@p)+48)
	      SET @r=@r+char(25*rand(10000*@p)+65)
	   END

	print @r
	print @p
END


