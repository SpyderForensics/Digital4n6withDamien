-- App: Grok
-- App Version: Tested on version 1.0.71
-- Database Location: /ai.x.grok/databases/exoplayer_internal.db
-- Parse Media information from the ExoPlayerCacheIndex Table
-- Author: Damien Attoe

--Replace UUID in the table name to the UUID in the database

SELECT
  ExoPlayerCacheIndex7da76e256f7220c0.id,
  ExoPlayerCacheIndex7da76e256f7220c0.key,
  CASE
    WHEN ExoPlayerCacheIndex7da76e256f7220c0.key LIKE 'https://assets.grok.com/users/%/generated/%' THEN 'User Generated'
    WHEN ExoPlayerCacheIndex7da76e256f7220c0.key LIKE 'https://imagine-public.x.ai/%' THEN 'Public'
    ELSE 'Other'
  END AS 'Content Type',
  CASE
    WHEN ExoPlayerCacheIndex7da76e256f7220c0.key LIKE 'https://assets.grok.com/users/%' THEN
      substr(
        ExoPlayerCacheIndex7da76e256f7220c0.key,
        length('https://assets.grok.com/users/') + 1,
        instr(substr(ExoPlayerCacheIndex7da76e256f7220c0.key, length('https://assets.grok.com/users/') + 1), '/') - 1
      )
  END AS 'User ID'
FROM ExoPlayerCacheIndex7da76e256f7220c0
