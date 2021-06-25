import psycopg2


class BudiPostgres():

    def __init__(self):
        """Constructor for Budipest's postgres database"""
        self.conn = psycopg2.connect(
            host="localhost",
            port=5437,
            database="budipest_development",
            user="budipest",
            password="bdpst1234")
        self.cursor = self.conn.cursor()

    def insert(self, data, table):
        """Insert data into a specified table"""
        columns = []
        values = []

        for k, v in data.items():
            columns.append(k)
            values.append(v)

        values = ",".join(
            ["'" + str(v).replace("'", "''") + "'" if v is not None else 'null' for v in values])
        statement = f'INSERT INTO {table} ({",".join(columns)}) SELECT {values}; '
        self.cursor.execute(statement)

    def save(self):
        """Save the session"""
        self.conn.commit()

    def close(self):
        """Close the connection"""
        self.cursor.close()
        self.conn.close()
