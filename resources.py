# Putting methods + examples here

# List Methods

# Given a list, fruits:
fruits = ['orange', 'apple', 'pear', 'banana', 'kiwi', 'apple', 'banana']

# Inserts value to the end of the list
fruits.append('apple')

# Inserts all values from an iterable into the list
veggies = ['celery', 'carrot', 'spinach', 'potato', 'lettuce', 'potato']
fruits.extend(veggies)  # <- veggies is something we can run a loop/iterate over so we can add all values into fruits

# Given a position, insert value into that position on the list
fruits.insert(3, 'apple')  # Note: Indexes start at position 0 which means 3 is the 4th position

# Removes a specified value from a list
fruits.remove('orange')

# Remove a value based off of their index
del fruits[1]  # Deletes the value at index 1
fruits.pop(1)  # Deletes the value at index 1

# Remove all items from a list
fruits.clear()
# Equivalent to
del fruits[:]

# Returns the first index of a given value
fruits.index('apple')  # Returns 1
fruits.index('apple', 3, 6)  # Returns 5
# The other two optional parameters are to specify where you want to start looking for values and where you want to stop

# Count how many times apple appears
fruits.count('apple')

# Sorts the list
fruits.sort()  # Sorts alphabetically
fruits.sort(reverse=True)  # Sorts alphabetically reverse


def func(x):
    return len(x)


fruits.sort(key=func)  # Sorts by a given key/function <- This example would sort by word length

# Reverses the list by index (last item becomes first, etc.)
fruits.reverse()

# Creates a copy of the list <- normally assigned to a new variable
healthy = fruits.copy()
'''
If you don't do .copy and just assign healthy = fruits
any changes you make on healthy will also affect the initial list, fruits. 
That's why you use .copy() to make a copy and assign that copy to a variable.
'''

# You can simplify for loops that build lists with list comprehension ie:
# Take the following for loop:
coordinate = []                        # Create an empty list where we'll store all the coordinates
for x in [1,2,3]:                      # For every value in this list
    for y in [1,4,5]:                  # For every value in this list
        if x != y:                      # If the x-value and y-value of the current loop don't match
            coordinate.append((x,y))   # Then append it to the coordinate list
# We can simplify this for loop to just one line:
coordinate = [(x,y) for x in [1,2,3] for y in [1,4,5] if x != y]




