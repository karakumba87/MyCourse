import random
from random import choice
from string import ascii_uppercase
import pandas as pd


count_col = ''
count_row = ''
col_param = []


def main():
    # Если программа используется как модуль,
    # лучше указать имя файла как аргумент к main
    name_file_setting = 'settings.txt'

    a = getSetting(name_file_setting)
    print('Settings: ')
    print('count_col', ': ', count_col)
    print('count_row', ': ', count_row)
    print()
    print('Settings columns:')
    for row in a:
        print(row)

    print()
    print('Print result:')
    b = dataGenerated(a)
    for row in b:
        print(row)

    i = 0
    word = {}

    while i < int(count_col):
        word.update({i: b[i]})
        i += 1

    df = pd.DataFrame(word)
    df.to_excel('./temp.xlsx')


def getSetting(name):
    global count_col
    global count_row
    global col_param

    # Сделать проверку на отсутствие файла
    file = open(name, 'r')
    setting = (file.read().replace('\n', '')).replace('\t', '')
    file.close()
    flag1 = False
    flag_comment = False
    parameter_num = 1
    type_col = ''
    length = ''
    constraint = ''
    temp_array_types = []
    temp_array_lengths = []
    temp_array_constraints = []

    for s in setting:
        if flag1 is True and s != ';' and s != ' ' and s != '<' and flag_comment is not True:
            if parameter_num == 1:
                count_col += s
            elif parameter_num == 2:
                count_row += s
            elif parameter_num == 3:
                type_col += s
            elif parameter_num == 4:
                length += s
            elif parameter_num == 5:
                constraint += s
        elif s == ';' and flag_comment is not True:
            flag1 = False
            if type_col != '':
                temp_array_types.append(verifyType(type_col))
            if length != '':
                temp_array_lengths.append(int(length))
            if constraint != '':
                temp_array_constraints.append(False)
            type_col = ''
            length = ''
            constraint = ''
            parameter_num += 1
            if parameter_num == 6:
                parameter_num = 3
        elif s == ' ' and flag_comment is not True:
            flag1 = True
        elif s == '<':
            flag_comment = True
            flag1 = False
        elif s == '>':
            flag_comment = False

    type_col_array = [[0, 0, False] for x in range(int(count_col))]
    i = 0

    while i < int(count_col):
        type_col_array[i][0] = temp_array_types[i]
        type_col_array[i][1] = temp_array_lengths[i]
        type_col_array[i][2] = temp_array_constraints[i]
        i += 1

    return type_col_array


def verifyType(s):
    if s == 'num':
        return 0
    elif s == 'varchar':
        return ''


def dataGenerated(type_col_array):
    data_array = [[0 for j in range(int(count_row))] for i in range(int(count_col))]
    i = 0
    j = 0

    while i < int(count_col):
        while j < int(count_row):
            if isinstance(type_col_array[i][0], int):
                data_array[i][j] = random.randint(0, type_col_array[i][1])
            if isinstance(type_col_array[i][0], str):
                data_array[i][j] = ''.join(choice(ascii_uppercase) for x in range(type_col_array[i][1]))
            j += 1
        j = 0
        i += 1

    return data_array


if __name__ == "__main__":
    main()
