# Uses LevelDB Parsers from: https://github.com/cclgroupltd/ccl_chromium_reader

import sys
import csv
from CCL import ccl_leveldb
import argparse
import sqlite3

def main(args):
    input_path = args.input
    output_path = args.output
    print(f"\n [+] Exracting LevelDB Key Pairs")
    leveldb_records = ccl_leveldb.RawLevelDb(input_path)
    # Connect to the SQLite database (it will be created if it doesn't exist)
    conn = sqlite3.connect(output_path)
    cursor = conn.cursor()
    print(f" [+] Creating SQLite Database: {output_path}")
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS LevelDB_Keys (
        key_text TEXT,
        key_hex BLOB,
        value_text TEXT,
        value_hex BLOB,
        origin_file TEXT,
        file_type TEXT,
        offset INTEGER,
        seq INTEGER,
        state TEXT,
        was_compressed BOOLEAN
    )
    """)
    print(f" [+] Inserting LevelDB Key Pairs to SQLite Database")
    # Insert records into the table
    for record in leveldb_records.iterate_records_raw():
        decoded_key = record.user_key.decode("utf-8", "ignore")
        cleaned_key = ''.join(c for c in decoded_key if ord(c) >= 32)
        decoded_value = record.value.decode("utf-8", "ignore")
        cleaned_value = ''.join(c for c in decoded_value if ord(c) >= 32)

        record_data = (
            cleaned_key,
            record.key.hex(" ", 1),
            cleaned_value,
            record.value.hex(" ", 1),
            str(record.origin_file),
            record.file_type.name,
            record.offset,
            record.seq,
            record.state.name,
            record.was_compressed
        )
        
        # Insert the record into the SQLite table
        cursor.execute("""
        INSERT INTO LevelDB_Keys (key_text, key_hex, value_text, value_hex, origin_file, file_type, offset, seq, state, was_compressed)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, record_data)

    # Commit the transaction and close the connection
    conn.commit()
    print(f" [+] LevelDB Key Pairs succesfully inserted!")
    conn.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Process LevelDB and output in an SQLite database"
    )
    parser.add_argument('-i', '--input', required=True, help="Path to LevelDB parent folder")
    parser.add_argument('-o', '--output', required=True, help="Path to outpur SQLite Database")
    args = parser.parse_args()
    print(r"""
 LevelDB to SQLite Converter
 Version: 1.0 March, 2025
 Author: Damien Attoe
""")

    print(f' Uses LevelDB Parsers from: https://github.com/cclgroupltd/ccl_chromium_reader')
    main(args)
