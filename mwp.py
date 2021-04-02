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
    """ Takes an input and creates a multiplication table - uses .format

    Parameters
    ___________
    :param  x:  int: a number

    Returns
    ___________
    :return: Returns a multiplication table
    """
    for i in range(1,x+1):
        print('{0} * {1} = {2}'.format(x, i, x*i))

    return


# using f' '
def multiply_table_f(x):
    """ Takes an input and creates a multiplication table - uses f''

    Parameters
    ___________
    :param  x:  int: a number

    Returns
    ___________
    :return: Returns a multiplication table
    """
    for i in range(1,x+1):
        print(f'{x} * {i} = {x*i}')

    return


def print_menu():
    """ Prints options to select from

    Parameters - None

    Returns
    ___________
    :return: Returns the options to select from
    """
    return print('1. Use .format\n2. Use f""')


# Creating a class to pick between which multiplication format to use
if __name__ == '__main__':
    # Prints the menu of options to select from
    print_menu()
    # Create a loop that restarts if invalid input
    while True:
        # Prints a question and asks for user input
        choice = input('Which choice do you want to do (1 or 2): ')
        # Checks if user input is valid
        if choice in ('1', '2'):
            # If choice is valid, then get out of the while loop and move on
            break
        # If choice is invalid, print statement and restart while loop
        print('Please input a valid choice [1, 2]')
    # Print question and asks for user input -> Converts it to an integer
    multiple = int(input('What number do you want to multiply to '))
    # Takes user input from earlier to decide which function to use to create the table
    if choice == '1':
        multiply_table_f(multiple)
    else:
        multiply_table_format(multiple)


# Quadratic formula
def quad_formula(a,b,c):

    x1 = round(((((b ** 2) - (4 * a * c))**0.5) - b) / (2 * a),3)
    x2 = round(((((b ** 2) - (4 * a * c))**0.5) + b) / (2 * a),3)

    return x1, x2


# Chapter 2

'''
Lists are mutable - you can add, remove, reorder values in lists
Tuples are immutable - you cannot add, remove, or reorder values

Create a list using [ ]
Create a tuple using ( )

Both have indexes you can refer to i.e. [0]/(0)

Empty lists and Empty tuples exist
However, you cannot add anything to an empty tuple as they are immutable 
'''

# Iterating over lists/tuples:
l = ['x', 'y', 'z']

# Assign items in list/tuple to variable i, loop over list
for i in l:
    # Print each item
    print(i)

# Assign index and items in list to variables - enumerate allows you to get the value and the index
for d, i in enumerate(l):
    print(d, i)

# Using matplotlib to create a graph
import matplotlib.pyplot as plt
# Create two lists - one to store x-values, one to store y-values
x_values = [1, 2, 3, 4, 5]
y_values = [5, 4, 3, 2, 1]
# Plot the coordinates
plt.plot(x_values, y_values)
'''
Styling your graph:
    Add a marker parameter to change each point's marker i.e. marker = 'o' <- Uses a small dot
        If you add this parameter to plot(), you'll get the markers + line
        If you only add the marker 'o' without the marker parameter, you'll only get the dots but no line
    plt.tile('Title') <- Inserts title above graph
    plt.xlabel('Label') <- Horizontal label below the x-axis
    plt.ylabel('Label') <- Vertical label next to the y-axis
    plt.axis(ymin=0, ymax=10, xmin=0, xmax=10) <- Set the minimum and max values of the axis
    
        
You can also plot multiple lines in the same graph 
    ie plt.plot(x_values, y_values, x2_values, y2_values, ...)
    Or you can do 3 different plots, then do show() and it'll show all 3 at the same time
'''
# Add a legend - Parameters are what you want to label each line
plt.legend([2000, 2005, 2010])
# Show the plotted graph
plt.show()
# Saving the graph - Available filetypes: png, pdf, svg - If no location specified, save to current directory
plt.savefig('location\Name.filetype')


# Plotting a formula example
def force_range(m1, m2):
    """ Generate a graph on the relationship between Force and distance between two masses
    :param m1: INT: The mass of object 1
    :param m2: INT: The mass of object 2
    """
    # Generate list of values for range from 100 - 1000 (increments of 50)
    r = range(100, 1001, 50)
    # Gravity is a constant variable
    G = 6.674 * (10**-11)
    # Empty list to store calculated values of F
    F = []

    # For each increment of r
    for dist in r:
        # Calculate force
        force = G*(m1*m2)/(dist**2)
        # Then append that value to F
        F.append(force)

    # Draw the graph
    plt.plot(r, F)

    return


def create_bar_chart(data, labels):
    """ Generate a bar chart
    :param data: List of numbers
    :param labels: List of labels for y-axis
    :return:
    """

    # Check how many bars need to be made
    num_bars = len(data)

    positions = range(1, num_bars+1)
    plt.barh(positions)

    return

