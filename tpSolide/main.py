import sqlite3



student_data = {
    "first_name": first_name,
    "last_name": last_name,
    "email": email,
    "apogee": apogee
}



con = sqlite3.connect('database.db')
cur = con.cursor()


data = cur.execute('''
    SELECT * FROM groups;
'''
)

for item in data:
    print(item)
    
con.commit()

