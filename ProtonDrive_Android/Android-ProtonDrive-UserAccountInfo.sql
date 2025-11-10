-- App: Android Proton Drive
-- App Version: 2.29.0
-- Database Location: data\data\me.proton.android.drive\databases\db-drive
-- Parse Proton Drive Account Information
-- Author: Damien Attoe

SELECT
	UserEntity.userId AS 'User ID',
	UserEntity.email AS 'Email Address',
	UserEntity.name AS Username,
	DATETIME((UserEntity.createdAtUTC/1000),'unixepoch') AS 'Created Date (UTC)',
	UserEntity.usedspace/1024/1024 AS 'Used Space (MB)',
	UserEntity.Maxspace/1024/1024 AS 'Max Space (MB)'
FROM UserEntity
