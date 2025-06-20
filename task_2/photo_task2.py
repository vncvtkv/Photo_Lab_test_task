import sqlite3
import requests
from datetime import datetime
import time
from urllib.parse import quote


def create_database():
    """Создает базу данных и таблицу"""
    conn = sqlite3.connect('itunes.db')
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS itunes (
            id INTEGER,
            word TEXT,
            pos INTEGER,
            date TEXT,
            PRIMARY KEY (id, word, date)
        )
    ''')
    conn.commit()
    conn.close()


def get_app_info(app_id):
    """Получает информацию о приложении по ID"""
    url = f"https://itunes.apple.com/lookup?id={app_id}"
    response = requests.get(url)
    if response.status_code != 200:
        raise Exception(f"API Error: {response.status_code}")

    data = response.json()
    if not data['results']:
        raise Exception("App not found")

    return data['results'][0]


def search_app_position(app_name, word):
    """Ищет позицию приложения по ключевому слову"""
    encoded_word = quote(word)
    url = f"https://itunes.apple.com/search?term={encoded_word}&entity=software&limit=200"

    try:
        response = requests.get(url)
        response.raise_for_status()
        data = response.json()

        for index, app in enumerate(data.get('results', []), 1):
            if app['trackName'].lower() == app_name.lower():
                return index
        
        return None  # Если приложение не найдено в топ-200
    except Exception as e:
        print(f"Search error for '{word}': {str(e)}")
        return None


def analyze_app(app_id):
    """Основная функция анализа"""
    conn = sqlite3.connect('itunes.db')
    cursor = conn.cursor()
    
    try:
        # Получаем информацию о приложении
        app_info = get_app_info(app_id)
        app_name = app_info['trackName']
        words = app_name.split()
        current_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        print(f"Analyzing app: {app_name} (ID: {app_id})")
        print(f"Found {len(words)} words in title")
        
        # Для каждого слова в названии
        for word in words:
            clean_word = word.strip().lower()
            if len(clean_word) < 3:  # Пропускаем короткие слова
                continue
                
            print(f"Searching for word: {clean_word}...")
            position = search_app_position(app_name, clean_word)
            
            if position is not None:
                print(f"Found at position: {position}")
                # Записываем в базу данных
                cursor.execute(
                    "INSERT INTO itunes (id, word, pos, date) VALUES (?, ?, ?, ?)",
                    (app_id, clean_word, position, current_date)
                )
            else:
                print(f"App not found in top 200 for word: {clean_word}")
            
            time.sleep(1)  # Задержка между запросами
            
        conn.commit()
        print("Analysis completed successfully!")
        
    except Exception as e:
        print(f"Error: {str(e)}")
    finally:
        conn.close()


if __name__ == "__main__":
    create_database()
    app_id = 860011430
    analyze_app(app_id)
