import sqlite3
from tabulate import tabulate

# Подключение к БД
conn = sqlite3.connect('photo_test.db')
cursor = conn.cursor()

# Заполнение user_actions тестовыми данными
with open('task_1/init_db.sql', 'r') as f:
    sql_script = f.read()

cursor.executescript(sql_script)

# Выполнение основного скрипта и вывод результата
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


# Закрытие соединения
conn.commit()
conn.close()
