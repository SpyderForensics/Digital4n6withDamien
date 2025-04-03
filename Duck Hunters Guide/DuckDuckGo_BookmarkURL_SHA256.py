# App: Android DuckDuckGo
# App Version: 5.228.0
# Database Location: com.duckduckgo.mobile.android\databases\app.db
# SHA256 Hash Bookmark URL's to associate Favicons in the Cache\Favicons folder.  
# Author: Damien Attoe

import sqlite3
import hashlib
import argparse
from urllib.parse import urlparse

def duckduckgo_favicon_normalize(url):
    """Normalize URL for DuckDuckGo favicon hashing."""
    parsed = urlparse(url.strip())

    # Remove www., lowercase domain
    netloc = parsed.netloc.lower()
    if netloc.startswith("www."):
        netloc = netloc[4:]

    # Strip trailing slash from path
    path = parsed.path.rstrip("/")

    # Combine domain and path, excluding scheme, query, fragment, params
    combined = f"{netloc}{path}"
    return combined

def ddg_favicon_hash(url):
    """Returns (normalized string, SHA256 hash) used for DDG favicon storage"""
    normalized = duckduckgo_favicon_normalize(url)
    return normalized, hashlib.sha256(normalized.encode('utf-8')).hexdigest()

def query_bookmarks_with_favicon_hashes(db_path):
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    query = """
    SELECT 
        entities.entityid,
        entities.title,
        entities.url
    FROM entities
    WHERE entities.type = 'BOOKMARK' AND entities.deleted = 0
    """

    cursor.execute(query)
    rows = cursor.fetchall()

    print(f"\n{'entityId':40} {'Bookmark URL':52} {'DDG Normalized URL':40} {'Favicon SHA256'}")
    print("=" * 160)

    for row in rows:
        entityid = row[0]
        raw_url = row[2] or ""

        normalized_url, favicon_hash = ddg_favicon_hash(raw_url)

        print(f"{entityid[:38]:40} {raw_url[:50]:52} {normalized_url[:38]:40} {favicon_hash}")

    conn.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate DuckDuckGo favicon hashes from APP.db")
    parser.add_argument("-i", "--input", required=True, help="Path to the DuckDuckGo APP.db file")
    args = parser.parse_args()

    query_bookmarks_with_favicon_hashes(args.input)
