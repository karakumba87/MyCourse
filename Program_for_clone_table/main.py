import datetime
import psycopg2 as pg
from prefect import Flow, task, Parameter


def main():
    name_table_copy = 'sessions'
    db_name = 'online_films'
    user = 'postgres'
    password = '123'
    host = 'localhost'

    try:
        set_conn_list = database_connection_open(db_name, user, password, host)
        flow_start.run(parameters={'name_table': name_table_copy, 'connection': set_conn_list[0],
                                   'cursor_db': set_conn_list[1]})
        database_connection_close(connection=set_conn_list[0], cursor_db=set_conn_list[1])
    except Exception as error:
        print('main:', error)


def database_connection_open(dbname, user, password, host):
    setting = []
    try:
        connect = pg.connect(dbname=dbname, user=user, password=password, host=host)
        cursor_db = connect.cursor()
        setting = [connect, cursor_db]
    except Exception as error:
        print('database_connection_open:', error)

    return setting


@task
def database_reading_table(connection, cursor_db, name_table_db):
    data = []
    col_names_and_types = []

    try:
        cursor_db.execute('''SELECT * FROM {}'''.format(name_table_db))
        connection.commit()
        data = cursor_db.fetchall()
        cursor_db.execute('''SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
                            WHERE table_name = {} ORDER BY ORDINAL_POSITION'''.format('\'' + name_table_db + '\''))
        connection.commit()
        col_names_and_types = cursor_db.fetchall()

        if len(data) == 0 or len(col_names_and_types) == 0:
            raise 'Data or col_names is empty.'
    except Exception as error:
        print('database_reading_table:', error)

    return [data, col_names_and_types]


@task
def database_creating_table(connection, cursor_db, name_table_str, data_list):
    dst_name_table_b = ''
    temp_build_col = []
    try:
        dst_name_table_b = str(name_table_str).replace('\"', '').upper() + '_TEMP_TABLE'
        cursor_db.execute('''DROP TABLE IF EXISTS %s''' % dst_name_table_b)
        connection.commit()

        for name_and_type in data_list:
            temp_build_col += [name_and_type[0] + ' ' + name_and_type[1]]
        sql_create_query = '''CREATE TABLE %s (%s)''' % (dst_name_table_b, ', '.join(temp_build_col))

        cursor_db.execute(sql_create_query)
        connection.commit()
    except Exception as error:
        print('database_creating_table:', error)

    return dst_name_table_b


@task
def database_writing_data(connection, cursor_db, name_table_str, data_list):
    data = [[] for i in data_list]
    try:
        j = 0
        for temp in data_list:
            i = 0
            while i < len(temp):
                if type(temp[i]) == type(datetime.date.today()):
                    data[j].append('TO_DATE(\'' + str(temp[i]) + '\', \'YYYY-MM-DD\')')
                elif temp[i] is None:
                    data[j].append('null')
                else:
                    data[j].append(str(temp[i]))
                i += 1
            j += 1
        for str_data in data:
            sql_writing_query = '''INSERT INTO  %s VALUES (%s)''' % (name_table_str, ', '.join(str_data))
            cursor_db.execute(sql_writing_query)
        connection.commit()
    except Exception as error:
        print('database_write:', error)


def database_connection_close(connection, cursor_db):
    try:
        cursor_db.close()
        connection.close()
    except Exception as error:
        print('database_connection_close:', error)


with Flow('Flow start') as flow_start:
    name_table = Parameter("name_table")
    cur = Parameter("cursor_db")
    conn = Parameter("connection")
    list_data = []
    dst_name_table = ''

    try:
        list_data = database_reading_table(connection=conn, cursor_db=cur, name_table_db=name_table)
        dst_name_table = database_creating_table(connection=conn, cursor_db=cur,
                                                 name_table_str=name_table, data_list=list_data[1])
        database_writing_data(connection=conn, cursor_db=cur, name_table_str=dst_name_table, data_list=list_data[0])
    except Exception as ex:
        print('with Flow:', ex)


if __name__ == '__main__':
    main()
