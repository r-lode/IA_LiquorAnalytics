import mysql.connector

# Connect to your MySQL server (update these details)
connection = mysql.connector.connect(
    host="LAPTOP-52JLHC77.local",
    user="root",
    password="@@#strider!!$",
    database="wedding_gift_ideas"
)

# Create a cursor to execute SQL commands
cursor = connection.cursor()

# Create a table for sci-fi weapons
cursor.execute('''
    CREATE TABLE IF NOT EXISTS scifi_weapons (
        weapon_id INT AUTO_INCREMENT PRIMARY KEY,
        weapon_name VARCHAR(50),
        description TEXT,
        price DECIMAL(10, 2)
    )
''')

# Insert some sample data
weapons_data = [
    ('Phaser', 'A standard-issue Starfleet phaser', 499.99),
    ('Lightsaber', 'An elegant weapon for a more civilized age', 999.99),
    ('Blaster', 'A versatile blaster commonly used in the galaxy', 399.99),
    ('Plasma Rifle', 'A powerful and futuristic plasma rifle', 799.99),
    ('Neuralizer', 'A device to erase memories, Men in Black style', 299.99),
]

cursor.executemany('''
    INSERT INTO scifi_weapons (weapon_name, description, price)
    VALUES (%s, %s, %s)
''', weapons_data)

# Commit the changes and close the connection
connection.commit()
connection.close()
