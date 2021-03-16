# Chapter 6: The Big O

def sum_between(x,y):
    """ Sums all of the values between x & y

    Parameters
    ___________
    :param x:  int: First variable
    :param y:  int: Second variable

    Returns
    ___________
    :return: The total between the minimum and max numbers
    """

    high = max(x,y)
    low = min(x,y)

    return ((high-low)+1)*(low+high)/2


