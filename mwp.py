# Doing Math with Python
# By Amit Saha

# Chapter 1
from fractions import Fraction


def float_input(num):
    """ Takes an input and tries to convert it into a float

    Parameters
    ___________
    :param num:  int/float: a number

    Returns
    ___________
    :return: The number as a float
    """

    # Try to convert the number you put in
    try:
        num = float(num)
    # If converting it returns a ValueError, print statement
    except ValueError:
        print('You entered an invalid number')

    return num


def fraction_input(x,y):
    """ Takes two inputs and returns it as a fraction

    Parameters
    ___________
    :param  x:  int/float: a number
    :param  y:  int/float: a number

    Returns
    ___________
    :return: Returns the fraction
    """

    # Try creating a Fraction using the two numbers inputted
    try:
        value = Fraction(int(x),int(y))
    # Print statement if y = 0
    except ZeroDivisionError:
        print('Invalid Fraction: Denominator cannot be 0')

    return value


def factor_calc(x,y):
    """ Takes two inputs and determines if first input is a factor of the second

    Parameters
    ___________
    :param  x:  int/float: a number
    :param  y:  int/float: a number

    Returns
    ___________
    :return: Returns if it's a factor or not + how many times
    """
    if int(y) % int(x) == 0:
        return print(f'x is a factor of y - {int(y)/int(x)} times')
    else:
        return print('x is not a factor of y')


def find_factors(x):
    """ Takes an input and prints how many factors and nonfactors there are

    Parameters
    ___________
    :param  x:  int: a number

    Returns
    ___________
    :return: Returns statement with how many factors and nonfactors there are
    """
    factors = []
    nonfactors = []

    for i in range(1, x):
        if x % i == 0:
            factors.append(i)
        else:
            nonfactors.append(i)

    return print(f'X has {len(factors)} factors and {len(nonfactors)} nonfactors')


# Using .format
def multiply_table_format(x):

    for i in range(1,x+1):
        print('{0} * {1} = {2}'.format(x, i, x*i))

    return


# using f' '
def multiply_table_f(x):

    for i in range(1,x+1):
        print(f'{x} * {i} = {x*i}')

    return


def print_menu():
    print('1. Use .format\n2. Use f""')
    return


# Creating a class to pick between which multiplication format to use
if __name__ == '__main__':
    print_menu()
    while True:
        choice = input('Which choice do you want to do (1 or 2): ')
        if choice in ('1', '2'):
            break
        print('Please input a valid ')
    multiple = int(input('What number do you want to multiply to '))
    if choice == '1':
        multiply_table_f(multiple)
    else:
        multiply_table_format(multiple)

