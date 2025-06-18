CREATE TABLE IF NOT EXISTS user_actions (
    user_id INTEGER,
    time TIMESTAMP,
    event TEXT,
    value TEXT
);

-- Вставляем тестовые данные
DELETE FROM  user_actions;
INSERT INTO user_actions (user_id, time, event, value) VALUES
-- Пользователь 1 (3 сессии)
(1, '2023-10-01 09:00:00', 'login', NULL),
(1, '2023-10-01 09:01:15', 'template_selected', 'modern_style'),  -- Сессия 1
(1, '2023-10-01 09:02:30', 'template_selected', 'modern_style'),  -- 2 раза подряд
(1, '2023-10-01 09:03:45', 'click_button', NULL),
(1, '2023-10-01 09:03:50', 'template_selected', 'pop_art_style'),  
(1, '2023-10-01 09:03:55', 'template_selected', 'pop_art_style'), -- 2 раза
(1, '2023-10-01 09:04:20', 'template_selected', 'minimalism'),
(1, '2023-10-01 09:05:00', 'logout', NULL),

(1, '2023-10-01 09:20:00', 'login', NULL),  -- Сессия 2 (>=5 мин после предыдущей)
(1, '2023-10-01 09:21:00', 'template_selected', 'vintage_style'),
(1, '2023-10-01 09:22:00', 'template_selected', 'vintage_style'),  -- 2 раза
(1, '2023-10-01 09:23:00', 'template_selected', 'vintage_style'), 
(1, '2023-10-01 09:24:00', 'logout', NULL),

(1, '2023-10-01 09:30:00', 'login', NULL),  -- Сессия 3 (>=5 мин после предыдущей)
(1, '2023-10-01 09:31:00', 'template_selected', 'dark_mode'),
(1, '2023-10-01 09:31:30', 'template_selected', 'dark_mode'),  -- 2 раза
(1, '2023-10-01 09:35:00', 'logout', NULL),
(1, '2023-10-01 10:12:10', 'template_selected', 'vintage_style'),  
(1, '2023-10-01 10:12:20', 'template_selected', 'vintage_style'),   -- 2 раза

-- Пользователь 2 (2 сессии)
(2, '2023-10-01 10:00:00', 'login', NULL),  -- Сессия 1
(2, '2023-10-01 10:01:00', 'template_selected', 'corporate_style'),
(2, '2023-10-01 10:02:00', 'template_selected', 'corporate_style'),  -- 2 раза
(2, '2023-10-01 10:07:01', 'click_button', NULL),  -- -- Сессия 2 >=5 мин после предыдущей
(2, '2023-10-01 10:11:00', 'template_selected', 'pop_art_style'),  
(2, '2023-10-01 10:12:00', 'template_selected', 'pop_art_style'),  -- 2 раза
(2, '2023-10-01 10:12:10', 'template_selected', 'vintage_style'),  
(2, '2023-10-01 10:12:20', 'template_selected', 'vintage_style'),   -- 2 раза
(2, '2023-10-01 10:13:00', 'logout', NULL),

-- Пользователь 3 (1 длинная сессия)
(3, '2023-10-01 11:00:00', 'login', NULL),
(3, '2023-10-01 11:01:00', 'template_selected', 'bright_theme'),
(3, '2023-10-01 11:02:00', 'template_selected', 'bright_theme'),  -- 2 раза
(3, '2023-10-01 11:03:00', 'click_button', NULL),
(3, '2023-10-01 11:04:00', 'template_selected', 'professional_style'),
(3, '2023-10-01 11:05:00', 'template_selected', 'professional_style'),  -- 2 раза
(3, '2023-10-01 11:06:00', 'logout', NULL),

-- Пользователь 4 
(4, '2023-10-01 09:03:50', 'template_selected', 'pop_art_style'),  
(4, '2023-10-01 09:03:55', 'template_selected', 'pop_art_style'), -- 2 раза
(4, '2023-10-01 12:00:00', 'login', NULL),
(4, '2023-10-01 12:01:00', 'template_selected', 'creative_style'),
(4, '2023-10-01 12:02:00', 'click_button', NULL),
(4, '2023-10-01 12:03:00', 'template_selected', 'minimalism'),
(4, '2023-10-01 12:04:00', 'logout', NULL);