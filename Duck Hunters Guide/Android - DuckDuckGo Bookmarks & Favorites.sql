-- App: Android DuckDuckGo
-- App Version: 5.228.0
-- Database Location: com.duckduckgo.mobile.android\databases\app.db
-- Parse Bookmark Information and Favorites 
-- Author: Damien Attoe

-- CTE to rebuild bookmark folder path
WITH RECURSIVE folder_paths AS (
    SELECT 
        entities.entityId AS folderId,
        entities.title AS path
    FROM entities
    WHERE entities.type = 'FOLDER'
      AND entities.entityId NOT IN (SELECT entityId FROM relations)

    UNION ALL
	
    SELECT 
        child.entityId AS folderId,
        folder_paths.path || ' > ' || child.title AS path
    FROM entities AS child
    JOIN relations ON child.entityId = relations.entityId
    JOIN folder_paths ON relations.folderId = folder_paths.folderId
    WHERE child.type = 'FOLDER'
),

-- CTE to identify favorites based on the bookmark being in the favorites folder
bookmark_favorites AS (
    SELECT entityId FROM relations WHERE folderId = 'favorites_root'
),

-- CTE to store bookmark and folder information
bookmark_locations AS (
    SELECT
        entities.rowid,
        entities.entityId,
		entities.type,
        entities.title,
        entities.url,
        entities.lastModified,
        entities.deleted,
        relations.folderId
    FROM entities
    LEFT JOIN relations ON entities.entityId = relations.entityId
)
-- Main Query
SELECT 
    MIN(bookmark_locations.rowid) AS rowid,
	bookmark_locations.entityId,
	bookmark_locations.type,
    CASE 
        WHEN bookmark_favorites.entityId IS NOT NULL THEN 'YES'
        ELSE 'NO'
    END AS Favorited,
	CASE bookmark_locations.deleted
        WHEN 1 THEN 'YES'
        ELSE 'NO'
    END AS Deleted,
    folder_paths.path AS "Folder Path",	
    bookmark_locations.title,
    bookmark_locations.url,
    bookmark_locations.lastModified
FROM bookmark_locations
LEFT JOIN folder_paths ON bookmark_locations.folderId = folder_paths.folderId
LEFT JOIN bookmark_favorites ON bookmark_locations.entityId = bookmark_favorites.entityId
GROUP BY bookmark_locations.entityId
ORDER BY bookmark_locations.ROWID;

