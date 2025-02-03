-- App: Android DuckDuckGo
-- App Version: 5.222.0
-- Database Location: com.duckduckgo.mobile.android\databases\history.db
-- Parse Web Browsing History 
-- Author: Damien Attoe

SELECT  
    visits_list.rowid AS 'Visit ID',
    history_entries.id AS 'URL ID',
    history_entries.url AS 'Visited URL',
    history_entries.title AS 'URL Title', 
    visits_list.timestamp AS 'Visit Date (Local)',
CASE history_entries.isSerp 
    WHEN 1 THEN 'DuckDuckGo Search'
    WHEN 0 THEN 'Web Page Visit' 
END AS 'History Type', 
history_entries.query AS 'Search Query' 
FROM visits_list 
LEFT JOIN history_entries ON visits_list.historyEntryId = history_entries.id;
