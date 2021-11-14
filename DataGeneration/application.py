import random
from random import choice
from string import ascii_uppercase
import pandas as pd
from datetime import datetime, timedelta


count_row = 10
col_param = []
data_word = {}
param_word = {}


# Принимает на вход тип вывода
def application(type_out='excel_out'):
    name_file_setting = './settings.txt'
    getParam(name_file_setting)

    if type_out == 'sql_out':
        print(data_word)
        # generateSqlInConsole()
    elif type_out == 'excel_out':
        generateExcel()


# Пока не работает
def generateSqlInConsole():
    print('Не работает!')
    # str1 = 'INSERT ALL\n'
    # str2 = 'INTO Views ('View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv) VALUES ('
    # names_column = data_word.keys()
    #
    # i = 0
    # while i < count_row / 2:
    #     print('INTO Views (View_id, Session_id, Film_id, Adv_partner_id, Count_adv, Count_click_adv)'
    #           , ' VALUES ('
    #           , data_word.get('View_id')[i]
    #           , ', '
    #           , data_word.get('Session_id')[i]
    #           , ', '
    #           , data_word.get('Film_id')[i]
    #           , ', '
    #           , data_word.get('Adv_partner_id')[i]
    #           , ', '
    #           , data_word.get('Count_adv')[i]
    #           , ', '
    #           , data_word.get('Count_click_adv')[i]
    #           , ')'
    #           , sep='')
    #     i += 1


def generateExcel():
    df = pd.DataFrame(data_word)
    df.to_excel('./temp.xlsx')


def getParam(name_file):
    global param_word
    data_json_cfg = pd.read_json(name_file)
    param_word = data_json_cfg.to_dict()

    global count_row

    names_col = list(param_word.keys())
    for i in names_col:
        if i == "Count_row":
            count_row = list(dict(param_word[i]).values())[0]

    i = 0
    while i < len(param_word):
        if names_col[i] != "Count_row":
            params_col = list(param_word.get(names_col[i]))
            dataGenerated(dict(param_word.get(names_col[i])).get(params_col[0]),
                          names_col[i],
                          dict(param_word.get(names_col[i])).get(params_col[1]),
                          dict(param_word.get(names_col[i])).get(params_col[2]))
        i += 1


def dataGenerated(type_column, name_column, range_min, range_max):
    global data_word
    if type_column == 'group_date':
        date_start, date_end = groupDateGenerate(datetime.strptime(range_min, '%d/%m/%Y'))
        data_word.update({name_column + '_from': date_start})
        data_word.update({name_column + '_to': date_end})
    elif type_column == 'date':
        date_start = dateGenerate(datetime.strptime(range_min, '%d/%m/%Y'))
        data_word.update({name_column: date_start})
    elif type_column == 'number':
        number_data = numberGenerate(int(range_min), int(range_max))
        data_word.update({name_column: number_data})
    elif type_column == 'varchar':
        number_data = stringGenerate(int(range_min))
        data_word.update({name_column: number_data})
    elif type_column == 'id':
        number_data = idGenerate()
        data_word.update({name_column: number_data})


def idGenerate():
    data_array = [0 for i in range(int(count_row))]

    i = 0
    while i < int(count_row):
        data_array[i] = i+1
        i += 1

    return data_array


def numberGenerate(min, max):
    data_array = [0 for i in range(int(count_row))]
    i = 0

    while i < int(count_row):
        data_array[i] = random.randint(min, max)
        i += 1

    return data_array


def stringGenerate(min):
    data_array = [0 for i in range(int(count_row))]
    i = 0

    while i < int(count_row):
        data_array[i] = ''.join(choice(ascii_uppercase) for x in range(min))
        i += 1

    return data_array


def groupDateGenerate(range_min):
    date_list = [range_min + timedelta(days=x + random.random()) for x in range(0, count_row*2)]
    date_array_start = [0 for i in range(int(count_row))]
    date_array_end = [0 for i in range(int(count_row))]

    i = x = y = 0
    while i < len(date_list):
        if i % 2 == 0:
            date_array_start[x] = date_list[i].strftime("%m/%d/%Y, %H:%M:%S")
            x += 1
        else:
            date_array_end[y] = date_list[i].strftime("%m/%d/%Y, %H:%M:%S")
            y += 1
        i += 1

    return date_array_start, date_array_end


def dateGenerate(range_min):
    date_list = [range_min + timedelta(days=x + random.random()) for x in range(0, count_row)]
    date_array = [0 for i in range(int(count_row))]

    i = 0
    while i < len(date_list):
        date_array[i] = date_list[i].strftime("%m/%d/%Y, %H:%M:%S")
        i += 1

    return date_array


if __name__ == "__main__":
    application()