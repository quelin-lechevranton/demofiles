# LIST, TUPLE, DICRIONNARY

l = [1,2,3]
t = (1,2,3)
d = { 'name' : 1 , 'color' : 2 , 'shape' : 3 }
# d = dict( 'name' : 1 , 'color' : 2 , 'shape' : 3 )
a =[[7,8,9],[4,5,6],[1,2,3]]

x=l[0]
x,*_=l
x,*_=t
x=d['name'] 
x=a[2][0]
x=a.flat[6]

# [f(x) if P(x) else g(x) for x in l]
# [f(x) for x in l if P(x)]

# ASTERISK *
# https://medium.com/understand-the-python/understanding-the-asterisk-of-python-8b9daaa4a558 

# UNDERSCORE _
# https://medium.com/hackernoon/understanding-the-underscore-of-python-309d1a029edc

# map(), filter(), reduce(), sorted()
# https://medium.com/@tuba.atabaycan/lambda-in-python-6cd22aa01aa9

# STRING FORMATING
# https://docs.python.org/2/library/string.html#format-specification-mini-language
# cf. f-strings and %-formating
# raw strings r' ' (no escape character needed)
# unicode strings u' '

# zip(), enumerate(),

# CURVE FITTING with MINUIT
# https://iminuit.readthedocs.io/en/stable/notebooks/basic.html
