import sqlite3
from tabulate import tabulate


def create_database():
    """Заполнение user_actions тестовыми данными"""
    conn = sqlite3.connect('photo_test.db')
    cursor = conn.cursor()

    with open('task_1/init_db.sql', 'r') as f:
        sql_script = f.read()
    cursor.executescript(sql_script)

    conn.commit()
    conn.close()


def run_main_queries():
    """Выполнение основного скрипта и вывод результата"""
    conn = sqlite3.connect('photo_test.db')
    cursor = conn.cursor()

    with open('task_1/queries.sql', 'r') as f:
        sql_script = f.read()

    try:
        cursor.execute(sql_script)

        if cursor.description:
            columns = [desc[0] for desc in cursor.description]
            rows = cursor.fetchall()

            print("Результат выполнения запроса:")
            print(tabulate(rows, headers=columns, tablefmt="grid"))
        else:
            print("Запрос выполнен успешно (нет данных для вывода)")

    except sqlite3.Error as e:
        print(f"Ошибка при выполнении запроса: {e}")

    conn.commit()
    conn.close()


if __name__ == "__main__":
    create_database()
    run_main_queries()
