---- Знайдемо середню зарплату за посадами
-- Ми робимо запит до таблиці payments, приєднуємо таблицю employees, 
-- щоб при цьому збігалися поля employee_id з таблиці payments та id з таблиці employees.
-- Середнє значення знаходимо за полем total таблиці payments та округляємо його 
-- до двох знаків після коми. Головне - це виконати групування за полем post, 
-- щоб запит точно розумів процес обчислення середнього значення до кожної посади.

SELECT ROUND(AVG(p.total), 2), e.post
FROM payments as p
LEFT JOIN employees as e ON p.employee_id = e.id
GROUP BY e.post;

---- кількість співробітників за компаніями​
-- Тут використовуємо функцію COUNT для підрахунку кількості рядків, 
-- головне - це з'єднати таблиці companies та employees за ключами id та company_id, 
-- а потім виконати групування за полем id або company_name таблиці companies. 
-- У нашому випадку ми виконали групування за полем id.

SELECT COUNT(*), c.company_name
FROM employees e
LEFT JOIN companies c ON e.company_id = c.id
GROUP BY c.id;

---- Вибрати співробітників компаній, у яких у 7 місяці була зарплата > 5000​
-- Тут запит дещо складніший, необхідно послідовно з'єднати таблиці між собою.
-- Знайти всі записи, де виплати були більшими 5000 та час виплат повинен бути 
-- між датами '2021-07-10' та '2021-07-20'.

SELECT c.company_name, e.employee, e.post, p.total
FROM companies c
    LEFT JOIN employees e ON e.company_id = c.id
    LEFT JOIN payments p ON p.employee_id = e.id
WHERE p.total > 5000
    AND  p.date_of BETWEEN  '2021-07-10' AND  '2021-07-20';

