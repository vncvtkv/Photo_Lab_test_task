# Photo_Lab_test_task

# Быстрый старт

1.  **Клонируйте репозиторий:**

    ```bash
    git clone https://github.com/vncvtkv/Photo_Lab_test_task.git
    cd Photo_Lab_test_task
    ```
2.  **Установите виртуальное окружение:**

    ```bash
    python -m venv venv           
    source venv/bin/activate
    ```
3.  **Установите необходимые зависимомти:**
    ```bash
    pip install -r requirements.txt  
    ```

# Условия задач
## Задача 1: анализ повторяющихся шаблонов в пользовательских сессиях

**Исходные данные**:
Таблица `user_actions` с колонками:
- `user_id` (ID пользователя)
- `time` (время события)
- `event` (тип события, включая `template_selected`)
- `value` (название шаблона, если `event = template_selected`)

**Определение сессии**:
Последовательность событий одного пользователя, где между любыми соседними событиями ≤ 5 минут.

**Требуется**:
Найти **ТОП-5** шаблонов, которые пользователи применяют **≥2 раза подряд в одной сессии.**

**Решение**:
- [Папка с SQL-скриптами(инициализация бд и запрос) и Python-скриптом для запуска SQL с помощью SQLite](https://github.com/vncvtkv/Photo_Lab_test_task/blob/main/task_1/)

- [SQL-запрос для решения первой задачи](https://github.com/vncvtkv/Photo_Lab_test_task/blob/main/task_1/queries.sql)

## Задача 2: анализ повторяющихся шаблонов в пользовательских сессиях

**Требуется**:
Написать Python-скрипт, который для заданного Apple ID приложения:
1. Получает его название через iTunes API

2. Для каждого слова из названия ищет позицию приложения в поисковой выдаче iTunes

3. Сохраняет в SQLite БД (itunes.db) в таблицу `itunes`:

- `id` (Apple ID приложения)
- `word` (слово из названия)
- `pos` (позиция в поиске, 1-200)
- `date` (дата запуска скрипта)

**Решение**:
- [Python-скрипт для решения второй задачи](https://github.com/vncvtkv/Photo_Lab_test_task/blob/dev/task_2/photo_task2.py)
