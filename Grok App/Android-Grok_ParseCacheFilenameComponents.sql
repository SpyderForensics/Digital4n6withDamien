-- App: Grok
-- App Version: Tested on version 1.0.71
-- Database Location: /ai.x.grok/databases/exoplayer_internal.db
-- Parse information from Cache Filename 
-- Author: Damien Attoe

--Replace UUID in the table name to the UUID in the database
SELECT
  ExoPlayerCacheFileMetadata7da76e256f7220c0.name AS "Cache Filename",
  CAST(substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, 1, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') - 1) AS INTEGER) AS "Cache ID",
  CAST(
    substr(
      substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') + 1),
      1,
      instr(substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') + 1), '.') - 1
    )
    AS INTEGER
  ) AS "Segment Index",
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
  ) AS "Timestamp (UTC)",
  substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.v') + 1, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.exo') - instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.v') - 1) AS "Cache Version",
  substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.exo')) AS "Extension"
FROM ExoPlayerCacheFileMetadata7da76e256f7220c0
ORDER BY
  CAST(substr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, 1, instr(ExoPlayerCacheFileMetadata7da76e256f7220c0.name, '.') - 1) AS INTEGER)


