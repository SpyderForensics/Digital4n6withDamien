-- App: Grok
-- App Version: Tested on version 1.0.71
-- Database Location: /ai.x.grok/databases/exoplayer_internal.db
-- Parse Media Cache File information from the ExoPlayerCacheFileMetadata Table
-- Author: Damien Attoe

--Replace UUID in the table name to the UUID in the database
SELECT 
	ExoPlayerCacheFileMetadata7da76e256f7220c0.name AS 'Cached FileName',
	ExoPlayerCacheFileMetadata7da76e256f7220c0.length AS 'Cached Size (Bytes)',
	DATETIME(ExoPlayerCacheFileMetadata7da76e256f7220c0.last_touch_timestamp/1000,'unixepoch') AS 'Last Interaction'
FROM ExoPlayerCacheFileMetadata7da76e256f7220c0
