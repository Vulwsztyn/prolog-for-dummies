def my_head(my_list):
    return my_list[0]

print(my_head([1,2,3]))

def my_tail(my_list):
    return my_list[1:]

print(my_tail([1,2,3]))

def my_head_and_tail(my_list):
    return my_list[0], my_list[1:]

print(my_head_and_tail(['a',1,'dupa']))

def my_length(my_list):
    if my_list == []:
        return 0
    return 1 + my_length(my_list[1:])

print(my_length(['Z','i','b','r','o',',',' ','T','y',' ','k']))

def my_member(elem, my_list):
    # I must add this because of diffferences between the languages
    if len(my_list) == 0:
        return False
    # rest is 'same' as in prolog
    if elem == my_list[0]:
        return True
    return my_member(elem,my_list[1:])

print(my_member(2,[1,2,2,3]),my_member(2,[1,3]))
    
def my_last(my_list):
    if len(my_list) == 1:
        return my_list[0]
    return my_last(my_list[1:])

print(my_last(['Kyoshi','Roku','Aang']))

def my_init(my_list):
    if len(my_list) == 1:
        return []
    return [my_list[0]] + my_init(my_list[1:])

print(my_init([1,2,3,4,5,6,7]))

def my_init_and_last(my_list):
    if len(my_list) == 1:
        return [], my_list[0]
    init,last = my_init_and_last(my_list[1:])
    return [my_list[0]] + init, last

print(my_init_and_last([1,2,3]))

def my_prepend(new_elem,my_list):
    return [new_elem] + my_list

print(my_prepend('a',['b','c']))

def my_concat(list1, list2):
    if list1 == []:
        return list2
    init, last = my_init_and_last(list1)
    return my_concat(init, [last] + list2)

print(my_concat([1,2,3],[4,5,6]))