-- App: Android DuckDuckGo
-- App Version: 5.233.0
-- LevelDB Location: duckduckgo.mobile.android\app_webview\Default\Local Storage\leveldb\
-- Parse Duck Chat (AI) from SQLite output of the Webview LevelDB 
-- Author: Damien Attoe

SELECT DISTINCT
	json_extract(LevelDB_Keys.value_text, '$.version') AS version,
	json_extract(chat.value, '$.chatId') AS chat_id,
	json_extract(chat.value, '$.lastEdit') AS last_edit,
	json_extract(chat.value, '$.title') AS title,
	json_extract(chat.value, '$.model') AS model,
	json_extract(msg.value, '$.createdAt') AS timestamp,
	json_extract(msg.value, '$.role') AS role,
	CASE 
		WHEN json_type(msg.value, '$.parts') = 'array' 
		AND json_array_length(json_extract(msg.value, '$.parts')) > 0 THEN 
		(SELECT json_extract(part.value, '$.text')
		FROM json_each(msg.value, '$.parts') AS part
		WHERE json_extract(part.value, '$.type') = 'text')
		ELSE
		json_extract(msg.value, '$.content')
	END AS chat
FROM LevelDB_Keys,
	json_each(LevelDB_Keys.value_text, '$.chats') AS chat,
	json_each(chat.value, '$.messages') AS msg
WHERE key_text = '_https://duckduckgo.comsavedAIChats'
AND json_valid(LevelDB_Keys.value_text) = 1;
