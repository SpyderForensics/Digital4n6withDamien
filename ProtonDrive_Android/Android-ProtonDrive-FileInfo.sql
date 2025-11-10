-- App: Android Proton Drive
-- App Version: 2.29.0
-- Database Location: data\data\me.proton.android.drive\databases\db-drive
-- Parse Proton Drive Stored File Information
-- Author: Damien Attoe

SELECT
    LinkEntity.id,
    LinkEntity.share_id,
    LinkEntity.user_id,
    LinkEntity.parent_id,
    CASE LinkEntity.type
        WHEN 1 THEN 'Folder'
        WHEN 2 THEN 'File'
        ELSE LinkEntity.type
    END AS type,
    LinkEntity.name,
    CASE LinkEntity.state
        WHEN 1 THEN 'Active'
        WHEN 2 THEN 'Trashed'
        ELSE LinkEntity.state
    END AS state,
    datetime(LinkEntity.creation_time, 'unixepoch') AS creation_time,
    datetime(LinkEntity.last_modified, 'unixepoch') AS last_modified,
	datetime(LinkEntity.trashed_time, 'unixepoch') AS trashed_time,
    LinkEntity.size,
    LinkEntity.mime_type,
    CASE LinkEntity.is_shared
		WHEN 1 THEN 'YES'
		WHEN 0 THEN 'NO'
		ELSE LinkEntity.is_shared
	END AS is_shared,
    LinkEntity.number_of_accesses
FROM LinkEntity;
