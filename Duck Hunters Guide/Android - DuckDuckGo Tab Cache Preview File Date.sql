-- App: Android DuckDuckGo
-- App Version: 5.222.0
-- Database Location: com.duckduckgo.mobile.android\databases\app.db
-- Parse Datetime from Cached Tab Preview Filename  
-- Author: Damien Attoe

SELECT
    tabs.tabid AS 'Tab ID',
    tabs.tabPreviewFile AS 'Cached Tab Preview Filename',
	--Adjust your system timezone to the timezone of the device being examined
    DATETIME(RTRIM(tabs.tabPreviewFile, '.jpg') / 1000, 'unixepoch','localtime') AS 'Cached Tab Preview Time (Local)'  
FROM tabs