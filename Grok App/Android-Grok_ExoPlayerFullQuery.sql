-- App: Grok
-- App Version: Tested on version 1.0.71
-- Database Location: /ai.x.grok/databases/exoplayer_internal.db
-- Full query to parse information from the exoplayer_internal.db
-- Author: Damien Attoe

--Replace UUID in the table name to the UUID in the database

SELECT
  ExoPlayerCacheIndex7da76e256f7220c0.id AS 'Cache ID',
  ExoPlayerCacheFileMetadata7da76e256f7220c0.name AS 'Cached FileName',
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
  END AS 'User ID',
    DATETIME(
    CAST(
      substr(
        substr(
          ExoPlayerCacheFileMetadata7da76e256f7220c0.name,
          instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') + instr(substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') + 1), '.') + 1
        ),
        1,
        instr(
          substr(
            ExoPlayerCacheFileMetadata7da76e256f7220c0.name,
            instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') + instr(substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') + 1), '.') + 1
          ),
          '.'
        ) - 1
      )
      AS INTEGER
    ) / 1000,
    'unixepoch'
  ) AS "Filename Timestamp (UTC)",
  DATETIME(ExoPlayerCacheFileMetadata7da76e256f7220c0.last_touch_timestamp/1000,'unixepoch') AS 'Last Interaction',
  ExoPlayerCacheIndex7da76e256f7220c0.key,
  CAST(
    substr(
      substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') + 1),
      1,
      instr(substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') + 1), '.') - 1
    )
    AS INTEGER
  ) AS "Segment Index",
  substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.v') + 1, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.exo') - instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.v') - 1) AS "Cache Version",
  substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.exo')) AS "Extension",
  ExoPlayerCacheFileMetadata7da76e256f7220c0.length AS 'Cached Size (Bytes)'
FROM ExoPlayerCacheIndex7da76e256f7220c0
JOIN ExoPlayerCacheFileMetadata7da76e256f7220c0
  ON CAST(substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, 1, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') - 1) AS INTEGER) = ExoPlayerCacheIndex7da76e256f7220c0.id
ORDER BY ExoPlayerCacheIndex7da76e256f7220c0.id