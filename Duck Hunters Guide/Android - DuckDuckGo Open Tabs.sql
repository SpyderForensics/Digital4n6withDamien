-- App: Android DuckDuckGo
-- App Version: 5.222.0
-- Database Location: com.duckduckgo.mobile.android\databases\app.db
-- Parse Open Tabs 
-- Author: Damien Attoe

SELECT
    tabs.tabid AS 'Tab ID',
    CASE 
        WHEN tab_selection.tabid IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS 'Current Tab',
    tabs.url AS 'URL',
    tabs.title AS 'Title',
    tabs.position AS 'Tab Position',
    tabs.tabPreviewFile AS 'Cached Tab Filename',
    tabs.lastAccessTime AS 'Tab Last Accessed (Local)'    
FROM tabs
LEFT JOIN tab_selection ON tabs.tabid = tab_selection.tabid;