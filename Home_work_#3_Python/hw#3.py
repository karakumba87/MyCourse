# Задача 1
# Есть список a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89].
# Выведите все элементы, которые меньше 5.
def task_1():
    a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
    for i in a:
        if i < 5:
            print(i)


# Задача 2
# Даны списки:
# a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];
# b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13].
# Нужно вернуть список, который состоит из элементов, общих для этих двух списков.
def task_2():
    a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
    b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    c = []
    for i in b:
        for j in a:
            if i == j:
                c.append(i)
                break
    return c


# Задача 3
# Отсортируйте словарь по значению в порядке возрастания и убывания.
# d = {1: 2, 3: 4, 4: 3, 2: 1, 0: 0}
def task_3():
	d = {1: 2, 3: 4, 4: 3, 2: 1, 0: 0}
	list_d_asc = list(d.items())
	list_d_desc = list(d.items())
	list_d_asc.sort(key=lambda i: i[1], reverse=False)
	list_d_desc.sort(key=lambda i: i[1], reverse=True)
	print(list_d_asc)
	print(list_d_desc)


# Задача 4
# Напишите программу для слияния нескольких словарей в один.
# dict_a = {1:10, 2:20}
# dict_b = {3:30, 4:40}
# dict_c = {5:50, 6:60}
def task_4():
	dict_a = {1:10, 2:20}
	dict_b = {3:30, 4:40}
	dict_c = {5:50, 6:60}
	dict_a.update(dict_b.items())
	dict_a.update(dict_c.items())
	print(dict_a)


# Задача 5
# Сделать список из 3 ключей с самыми высокими значениями в словаре my_dict = {'a':500, 'b':5874, 'c': 560,'d':400, 'e':5874, 'f': 20}
def task_5():
	my_dict = {'a':500, 'b':5874, 'c': 560,'d':400, 'e':5874, 'f': 20}
	list_d = list(my_dict.items())
	list_d.sort(key=lambda i: i[1], reverse=True)
	result_list = []
	i = 0
	while i < 3:
		result_list.append(list_d[i][0])
		i += 1
	print(result_list)


# Задача 6
# Функция на проверку, является ли заданная строка палиндромом
def task_6(a):
	b = ''
	i = 1
	while i <= len(a):
		b += a[-i]
		i += 1
	if a == b:
		return True
	else:
		return False
	 
# Задача 7
# Функция по подсчёту факториала числа
def task_7(n):
	if n == 0:
		return 1
	else:
		return n * task_7(n - 1)