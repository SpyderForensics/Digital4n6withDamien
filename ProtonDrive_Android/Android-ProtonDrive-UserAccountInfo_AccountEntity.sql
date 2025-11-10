-- App: Android Proton Drive
-- App Version: 2.29.0
-- Database Location: data\data\me.proton.android.drive\databases\db-drive
-- Parse Proton Drive Account Information from AccountEntity Table
-- Author: Damien Attoe

SELECT
	AccountEntity.userId,
	AccountEntity.username,
	AccountEntity.email,
	AccountEntity.state,
	AccountEntity.sessionState
FROM AccountEntity
