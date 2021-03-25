# Chapter 1 Programming Challenges

# Even-Odd Vending Machine
def eo_vm(x):
    """  Takes an integer and prints statements based on even/odd
    :param x: INT: Any integer

    No returns
    """
    if type(x) != int:
        return print('Please input a valid integer')

    if x % 2 == 0:
        print(f'{x} is even')
        value = 'even'
    else:
        print(f'{x} is odd')
        value = 'odd'

    print(f'The next 9 {value} numbers are:')
    for i in range(1, 10):
        print(f'{x + (i*2)}')

    return


# Enhanced Multiplication Generator
def mp_table(x, y):
    """ Generate a multiplication table based on two inputs
    :param x:  INT: The multiple we want to create the table for
    :param y:  INT: The number of times to multiply by
    :return:
    """
    for i in range(1,y+1):
        print(f'{x} * {i} = {x*i}')

    return


# Enhanced Unit Convertor



