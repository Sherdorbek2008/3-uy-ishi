import psycopg2

db = psycopg2.connect(
    database='3-uy ishi',
    user='postgres',
    password='1',
    host='localhost',
    port='2008'
)
cursor = db.cursor()

cursor.execute('''
ALTER TABLE attendance
RENAME TO davomat
''')

cursor.execute('''
ALTER TABLE grade
RENAME TO baholar
''')

cursor.execute('''
ALTER TABLE baholar RENAME COLUMN grade_id TO baholar_idsi;
''')

cursor.execute('''
ALTER TABLE school RENAME COLUMN address TO manzil;
''')

cursor.execute('''
ALTER TABLE teachers RENAME COLUMN phone_number TO tel_raqami;
''')

cursor.execute('''
ALTER TABLE baholar
ADD COLUMN chorak TEXT DEFAULT 5;
''')

cursor.execute('''
ALTER TABLE sinf
ADD COLUMN oquvchi_soni TEXT DEFAULT 25;
''')

cursor.execute('''
ALTER TABLE sinf DROP COLUMN oquvchi_soni;
''')

cursor.execute('''
UPDATE teachers SET tel_raqami = '+998888888888' WHERE teachers_id = 3
''')

cursor.execute('''
UPDATE teachers SET email = '@hi.gmail.com' WHERE teachers_id = 3
''')

cursor.execute('''
UPDATE teachers SET last_name = 'Bakirov' WHERE teachers_id = 3
''')

cursor.execute('''
UPDATE teachers SET first_name = 'Bakir' WHERE teachers_id = 3
''')

cursor.execute('''
DELETE FROM teachers WHERE teachers_id = 3;
''')

cursor.execute('''
DELETE FROM school WHERE school_id = 3;
''')

cursor.execute('''
DELETE FROM baholar WHERE baholar_idsi = 2;
''')

cursor.execute('''
DELETE FROM davomat WHERE id = 2;
''')

db.commit()
db.close()
