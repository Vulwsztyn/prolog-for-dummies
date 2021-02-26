def my_head(my_list):
    return my_list[0]

print('my_head', my_head([1,2,3]))

def my_tail(my_list):
    return my_list[1:]

print('my_tail', my_tail([1,2,3]))

def my_head_and_tail(my_list):
    return my_list[0], my_list[1:]

print('my_head_and_tail', my_head_and_tail(['a',1,'dupa']))

def my_length(my_list):
    if my_list == []:
        return 0
    return 1 + my_length(my_list[1:])

print('my_length', my_length(['Z','i','b','r','o',',',' ','T','y',' ','k']))

def my_member(elem, my_list):
    # I must add this because of diffferences between the languages
    if len(my_list) == 0:
        return False
    # rest is 'same' as in prolog
    if elem == my_list[0]:
        return True
    return my_member(elem,my_list[1:])

print('my_member', my_member(2,[1,2,2,3]),my_member(2,[1,3]))
    
def my_last(my_list):
    if len(my_list) == 1:
        return my_list[0]
    return my_last(my_list[1:])

print('my_last', my_last(['Kyoshi','Roku','Aang']))

def my_init(my_list):
    if len(my_list) == 1:
        return []
    return [my_list[0]] + my_init(my_list[1:])

print('my_init', my_init([1,2,3,4,5,6,7]))

def my_init_and_last(my_list):
    if len(my_list) == 1:
        return [], my_list[0]
    init,last = my_init_and_last(my_list[1:])
    return [my_list[0]] + init, last

print('my_init_and_last', my_init_and_last([1,2,3]))

def my_prepend(new_elem,my_list):
    return [new_elem] + my_list

print('my_prepend', my_prepend('a',['b','c']))

def my_concat(list1, list2):
    if list1 == []:
        return list2
    init, last = my_init_and_last(list1)
    return my_concat(init, [last] + list2)

print('my_concat', my_concat([1,2,3],[4,5,6]))

def my_sum(my_list):
    if my_list == []:
        return 0
    return my_list[0] + my_sum(my_list[1:])

print('my_sum', my_sum([12,25,5]))

def my_product(my_list):
    if my_list == []:
        return 1
    return my_list[0] * my_product(my_list[1:])

print('my_product', my_product([2,3,7]))

def my_min(my_list):
    if len(my_list) == 1:
        return my_list[0]
    tail_min = my_min(my_list[1:])
    return my_list[0] if my_list[0] < tail_min else tail_min

print('my_min', my_min([16, 18, 22, 27, 12, 25, 21]))

def my_max(my_list):
    if len(my_list) == 1:
        return my_list[0]
    tail_max = my_max(my_list[1:])
    return my_list[0] if my_list[0] > tail_max else tail_max

print('my_max', my_max([16, 18, 22, 27, 12, 25, 21]))

def int_to_list_of_digits(my_int):
    if my_int == 0:
        return []
    my_int_mod_10 = my_int % 10
    my_int_by_10 = my_int // 10
    return int_to_list_of_digits(my_int_by_10) + [my_int_mod_10]

print('int_to_list_of_digits', int_to_list_of_digits(123))

def list_of_digits_to_number(my_list):
    if my_list == []:
        return 0
    return list_of_digits_to_number(my_list[:-1]) * 10 + my_list[-1]

print('list_of_digits_to_number', list_of_digits_to_number([6,2,3]))

def my_range(start, end):
    if start == end:
        return [end]
    return [start] + my_range(start + 1, end)

print('my_range', my_range(-9,5))

def my_abs(x):
    if x >= 0:
        return x
    return -x

print('my_abs', my_abs(5), my_abs(-3))
