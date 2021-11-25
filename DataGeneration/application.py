import random
from random import choice
from string import ascii_uppercase
import pandas as pd
from datetime import datetime, timedelta


count_row = 10
col_param = []
data_word = {}
param_word = {}


# Принимает на вход тип вывода и откуда получать настройки
def application(out_type='excel_out', settings_type='oracle_db'):
    settings_file_name = './settings.txt'

    if settings_type == 'text_file':
        takesSettingsFromFile(settings_file_name)
    elif settings_type == 'oracle_db':
        print('Не работает!')

    if out_type == 'sql_out':
        print(data_word)
        # generateSqlInConsole()
    elif out_type == 'excel_out':
        generatesExcelFile()


# TO DO: Написать функцию генерации DDL
# Пока не работает
def generateSqlInConsole():
    print('Не работает!')


def generatesExcelFile():
    df = pd.DataFrame(data_word)
    df.to_excel('./temp.xlsx')


# TO DO: Разделить функцию
# Внутри забираются настройки из файла и здесь же  вызывается функция генерации данных
def takesSettingsFromFile(name_file):
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
            GeneratesData(dict(param_word.get(names_col[i])).get(params_col[0]),
                          names_col[i],
                          dict(param_word.get(names_col[i])).get(params_col[1]),
                          dict(param_word.get(names_col[i])).get(params_col[2]))
        i += 1


# TO DO: Создать объект с настройками и передавать его вместо кучи полей
def GeneratesData(type_column, name_column, range_min, range_max):
    global data_word
    if type_column == 'group_date':
        date_start, date_end = groupDateGenerates(datetime.strptime(range_min, '%d/%m/%Y'))
        data_word.update({name_column + '_from': date_start})
        data_word.update({name_column + '_to': date_end})
    elif type_column == 'date':
        date_start = dateGenerates(datetime.strptime(range_min, '%d/%m/%Y'))
        data_word.update({name_column: date_start})
    elif type_column == 'number':
        number_data = numberGenerates(int(range_min), int(range_max))
        data_word.update({name_column: number_data})
    elif type_column == 'varchar':
        number_data = stringGenerates(int(range_min))
        data_word.update({name_column: number_data})
    elif type_column == 'id':
        number_data = idGenerates()
        data_word.update({name_column: number_data})

# TO DO: Переместить функцию в numberGenerates() и
# изменить файл с настройками - убрать тип id
def idGenerates():
    data_array = [0 for i in range(int(count_row))]

    i = 0
    while i < int(count_row):
        data_array[i] = i+1
        i += 1

    return data_array


def numberGenerates(min, max):
    data_array = [0 for i in range(int(count_row))]
    i = 0

    while i < int(count_row):
        data_array[i] = random.randint(min, max)
        i += 1

    return data_array


def stringGenerates(min):
    data_array = [0 for i in range(int(count_row))]
    i = 0

    while i < int(count_row):
        data_array[i] = ''.join(choice(ascii_uppercase) for x in range(min))
        i += 1

    return data_array


def groupDateGenerates(range_min):
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


def dateGenerates(range_min):
    date_list = [range_min + timedelta(days=x + random.random()) for x in range(0, count_row)]
    date_array = [0 for i in range(int(count_row))]

    i = 0
    while i < len(date_list):
        date_array[i] = date_list[i].strftime("%m/%d/%Y, %H:%M:%S")
        i += 1

    return date_array


if __name__ == "__main__":
    application()
