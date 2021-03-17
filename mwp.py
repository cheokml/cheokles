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

    factors = []
    nonfactors = []

    for i in range(1, x):
        if x % i == 0:
            factors.append(i)
        else:
            nonfactors.append(i)

    return print(f'')

