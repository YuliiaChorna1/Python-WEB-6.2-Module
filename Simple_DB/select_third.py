### Вибрати співробітників компаній, у яких у 7 місяці була зарплата > 5000​
# Тут запит дещо складніший, необхідно послідовно з'єднати таблиці між собою.
# Знайти всі записи, де виплати були більшими 5000 та час виплат повинен бути 
# між датами '2021-07-10' та '2021-07-20'.

import sqlite3


def execute_query(sql: str) -> list:
    with sqlite3.connect('salary.db') as con:
        cur = con.cursor()
        cur.execute(sql)
        return cur.fetchall()


sql = """
SELECT c.company_name, e.employee, e.post, p.total
FROM companies c
    LEFT JOIN employees e ON e.company_id = c.id
    LEFT JOIN payments p ON p.employee_id = e.id
WHERE p.total > 5000
    AND  p.date_of BETWEEN  '2021-07-10' AND  '2021-07-20'
"""

print(execute_query(sql))

