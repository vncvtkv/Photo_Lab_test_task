WITH 
-- 1. Размечаем сессии: нумеруем их для каждого пользователя
sessions_0 AS (
  SELECT 
    user_id,
    time,
    event,
    value,
    -- Если разница с предыдущим действием >5 мин — это новая сессия
    CASE 
        WHEN (strftime('%s', time) - strftime('%s', LAG(time) OVER (PARTITION BY user_id ORDER BY time))) > 300 THEN 1
        ELSE 0 END AS session_id
  FROM user_actions
),

sessions AS (
  SELECT 
    user_id,
    time,
    event,
    value,
    SUM(session_id) OVER (PARTITION BY user_id ORDER BY time) AS session_id
  FROM sessions_0
),

-- 2. Выбираем только события выбора шаблона и находим повторы шаблонов в сессиях
repeats AS (
  SELECT 
    user_id,
    session_id,
    value,
    -- Если шаблон совпадает с предыдущим — это повтор
    CASE WHEN value = LAG(value) OVER (PARTITION BY user_id, session_id ORDER BY time) 
        THEN 1 ELSE 0 END AS is_repeat
  FROM sessions
  WHERE event = 'template_selected'
),

-- 3. Считаем количество сессий с повторениями для каждого шаблона
repeat_counts AS (
  SELECT 
    value,
    COUNT(DISTINCT user_id || '|' || session_id) AS sessions_with_repeats  -- Уникальные сессии с повторами
  FROM repeats
  WHERE is_repeat = 1
  GROUP BY value
),

-- 4. Считаем топ шаблонов  
template_stats AS (
  SELECT
    value,
    sessions_with_repeats,
    DENSE_RANK() OVER (ORDER BY sessions_with_repeats DESC) AS rk
  FROM repeat_counts
)

SELECT 
  value,
  sessions_with_repeats,
  rk
FROM template_stats
WHERE rk <= 5
ORDER BY rk;

