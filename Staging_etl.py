import psycopg2

# Conexão ao banco de produção ( transacional )
conn = psycopg2.connect(
    dbname="production_db",
    user="user",
    password="password",
    host="localhost"
)

cur = conn.cursor()

# Extraindo dados
cur.execute("SELECT * FROM public.orders WHERE order_date >= NOW() - INTERVAL '1 day'")
rows = cur.fetchall()

cur.close()
conn.close()

# Conexão ao banco de staging
conn_staging = psycopg2.connect(
    dbname="staging_db",
    user="user",
    password="password",
    host="localhost"
)

cur_staging = conn_staging.cursor()

# Inserir dados na área de staging
for row in rows:
    cur_staging.execute("""
        INSERT INTO staging.orders (order_id, customer_id, order_date, amount, status)
        VALUES (%s, %s, %s, %s, %s)
    """, row)

conn_staging.commit()
cur_staging.close()
conn_staging.close()
