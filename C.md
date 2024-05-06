# C++

> *C Programming: A Modern Approach*
> by K. N. King,
> 2nd ed.

## Preprocessing et directives

The preprocessor remove all comments and sometimes even unnecessary white spaces. Directives can appear anywhere in a program

### includes

The preprocessor will copy the content of the file. C standard headers in `<>` are in `/usr/include` and personnal headers `""` are in current directory

```C
#include <c_standard_header.h>
#include "my_header.h"
```

> 15.3

### Macros

When `MACRO` is typed the preprocessor will type `some_thing` instead. To remove the macro:

```C
#define MACRO some_thing
#undef MACRO
```

Macro functions can also be defined. Macro functions may be faster then regular functions as they are not called during execution. Macro can have any type, MIN can be used on ``int``, ``long``, ``float`` ...

```C
#define MIN(a,b) ((a)<(b)?(a):(b))
```

stringization `#(a\bc) -> "a\\bc"` and take-pasting `a##(1) -> a1`

```C
#define PRINT(i) printf(#i "=%i\n",i)
#define TOKEN(i) a##i
```

Predefined macros:

```C
__LINE__
__FILE__
__DATE__
__TIME__
__STDC__
```

Variable number of arguments

```C
#define MACRO(a,...) some_thing(__VA_ARGS__)

#define DEBUG 0
#if DEBUG
/*
 * some
 * code
 */
#endif

defined(DEBUG) //returns 1 if DEBUG is defined, 0 otherwise
#ifdef DEBUG   //same as #if defined(DEBUG)
#ifndef DEBUG  //same as #if !defined(DEBUG)

#if ..1
//blabla
#elif ..2 //any number of #elif
//blabla
#else //at most one #else
//blabla
#endif

#error, #line, #pragma, _Pragma
```

## Special identifiers

```C++
__func__ //return the name (char*) of the current function
```

## Types

```C++
int, short, long, long long, unsigned int
float, double, long double
char //single quotes '': in ASCII from 0 to 127
```

## Formatted strings

### Escape sequences

| esc | octal| | esc | |
| - | - | - | - | - |
| `\a` | `\07` | BEL | `\\` | backslash |
| `\b` | `\010` | BS | `\?` | question mark |
| `\t` | `\011` | HT | `\'` | single quote' |
| `\n` | `\012` | LF | `\"` | double quote" |
| `\v` | `\013` | VT | `%%` | percentage |
| `\f` | `\014` | FF | | |
| `\r` | `\015` | CR | | |
| `\e` | `\033` | ESC | | |

### Placehodlers

| | | | |
| - | - | - | - |
| `%5.3d` | decimal (int): "  001" | `%c` | character |
| `%-5.3d` | "001  " | `%.3s` | 3 first character of a string (char array) |
| `%u` | unsigned | `%-10.5s` | left-aligned first 5 character in a line of 10 |
| `%o` | octal | `%4s` | in scanf, store only the first 4 characters of the string input |
| `%x` | hexadecimal | | |
| `%i` | 01 -> octal, 0x -> hexadecimal | | |
| `%.2f` | float to the hundredth | | |
| `%.2e` | exponential form | | |
| `%.2g` | auto decimal or exponetial form | | |

## Statements and expressions

```C++
...; //simple statements
{ ...; ...; } //compound statements
...1, ...2; //comma expression: v=...2
...1 ? ...2 : ...3 //if ...1 then v=...2 else v=...3;
```

### Selection statements

```C++
if ( ... ) ...; else ...; //if statement
switch ( ...1 ) { case 2: ...2; break; case 3: ...3; } //switch statement: ...1 must be integral type, if ...1==2 then ...2 is executed, then break quit the switch statement
```

### Iteration statements

```C++
while ( ... ) ...; //while loop
do ... while ( ... ) ; //do loop
for ( ...1; ...2; ...3 ) ...4; //for loop
...1 ; while ( ..2 ) { ...4; ...3; } //for loop equivalent
while (1) ...; for (;;) ...; //infinit loops
```

### Jump statements

```C++
break; //break the loop
continue; //break the interation
goto id1; /*****/  id1: ...;
```

## Input/Output

```C++
//printf :
//puts : one argument: a string
//putchar : one argument: a char

//scanf : start at first non-white space character, stops at a white space, tab, or new line
//gets : stops at new line
//getchar()
```

## Types

```C++
const long long unsigned ......
typedef double meters;
meters longeur; //stocked as a double, indicate that the value is to be thought as meters

sizeof(a) //size in the memory of the variable a

static int a; //A variable with static storage duration has a permanent storage location but still has block scope, so it’s not visible to other functions.
extern int a; //declare the variable without defining it (ie. allocating space) because it is defined elsewhere (usally a header)
```

## Booleans

```C++
#define true 1
#define false 0
typedef int bool;
//booleans are int by default

#include<stdbool.h>

/*FUNCTIONS*****************/
int sum (int a,int b) { return a+b; }

int sum (int a,int b); //function declaration to provide a complete description to the compiler if we want to define the function after its first call

//functions can have side effect on pointers and array (not regular values)
```

## Characters

```C++
char c = 'a' //interpreted as an int (ASCII): 97 is the ASCII code for 'a'
```

## Arrays

```C++
int a[5]; //initialize int array of length 5
a[0]=0; //access array values, they act as an ordinary int variable
int a[] = {1,2,3,4,5}; //initializer: automatically assign length
int a[5] = {1,2}; //unspecified values put to 0
int a[5] = {[1] = 2, [4]=5} //designated initializer: specify index of initialized values
int a[] = {1,2,[4]=5} //assigned length=5
int a[5]; a={1,2,3,4,5}; //this is wrong, initializer are only for initialization

int length(a) { return (int) sizeof(a) / sizeof(a[0]); }

int m[2][2]; //matrix
//m[i,j] is interpreted as m[j]
//m is stored in memory as m[0][0],m[0][1],m[1][0],m[1][1] as a 4-array would be
int m[2][2]={ {1,2} , {3,4} };
int m[2][2]={1,2,3,4};

memcpy(a,b, sizeof(a));

//array can be return values of functions
```

## Pointers

```C++
int *p; //p is a pointer: it is the address of a variable of type int
int a; p=&a; //p now points to the address of a
int b; b=*p; //b as the value stored in b, ie. the value of a

//int *p; *p=1; this is really not a good idea, p is uninitialized and could point to anything

int a;
void f(const int *p){
  p=&a; //ok p might not be constant
  //*p=0; this is wrong: the value p points is a constant
}
void g(int *const p){
  //p=&a; this is wrong
  *p=0;
}

int a[10],*p,*q,i;
p=&a[8]; //p points to the address hosting a[8]
q=p-3; //q points to the address hosting a[5]
i=p-q; //i is equal to 3. p and q must point to elements of the same array
p>q; //is true since p-q>0 is true

int *p=(int []){3,0,3,4,1}; //this is valid and the array is saved in memory even if no identifier has been declared

// arrays identifiers are pointers to the first element
// a+i and &a[i] are equivalents
// *(a+i) and a[i] are equivalents
// the compiler treats a[i] as *(a+i) so i[a], *(i+a), *(a+i) and a[i] are equivalent
// put a can't be modified. eg. a++ is undefined (it would actually points to the address a[N])
// int a[1]; allocated memory, while int *a; doesn't

// &a[i][0], &(*(a[i]+0)), &*a[i] and a[i] are equivalents

//variably modified types (pointers to variable-length arrays
int a[m][n], (*p)[n]=a; //this is the correct way to define a pointer pointing to a row of a
for (p=a ; p<a+m ; p++) (*p)[i]=0; //this clears the column i of a
```

## Strings

```C++
//strings literal: "abc"
//strings are pointers to char
//"abc"[3] is the null character \0

char string[20] = "hello";
char string[20] = { 'h','e','l','l','o','\0' }; //both declaration are equivalents
//uninitialized array elements are put to '\0' (as they are put to 0 in case of an int array
char string[] = "hello"; //string is initialized with length 6
char string[6]; string="hello"; //this is wrong initializers are only for initialization
char string[] = "\x7c" "ber"; //compiled as one string without white space

//cf. standard library: <string.h>

char str_list[][10] ={"I'm","batman"}; //list of strings up to 9 characters: end of strings filled with '\0': lost space
char *str_list[] = {"I'm","batman"}; //better
```

## 16 Structures, Unions and Enumerations

### 16.1-3 Structures

```C
//arrays are collection of one type
//structures are collection of different types
struct {
  int numero;
  char name[10];
} coureur1={24},  //name is "\0"
  coureur2={46,"Ange"},
  coureur3={ .name="Pierre" }; //this is a designator
coureur1.numero++; //structure members are lvalues

struct Coureur {
  int numero;
  char name[10];
}; //structure tag
struct Coureur coureur4; //struct can't be omitted

typedef struct {
  int numero;
  char name[10];
} Coureur_t; //typedef
Coureur_t coureur5;

void f(struct Coureur c) {printf("%i", c.numero);}
f( (struct Coureur) {25 , "Dimitri"} ); //Compound Literal
coureur5 = (struct Coureur) {.numero=34 }; //can't use initializer here
```

### 16.4 Unions

```C
//unions store members in the same address
//u is either an int or a double
union {
  int i;
  double d;
} u = {0}; //only one value has to be initialized 
u.d = 10.; //u.i becomes meaningless
```

> Using Union to save space

### 16.5 Enumerations

```C
enum suit {club, diamond, heart, spade};
//by default it will be treated as an int, with club=0,...,spade=3
enum suit s1,s2=diamond;
s2++; //now s2 is heart

typedef enum {True, False} Bool;

typedef enum {white, black, red=3, green=6, blue=9} color;
//this imposes the compiler to assign specific int values to the enum constants
```

> Using Enumerations to Declare “Tag Fields”

## Examples

```C
#define PI 3.1415
#define N 10


int i,j;
i = 1 + (j=3);


int i,j=0,k,l=0;
i=j++;
k=++l


int i=0,a[N]; while(i<N) a[i++]=0;


int n;
scanf("%d",&n);
for (int sum=0,i=1;i<=n;i++) sum+=i;


for (;;) {
    printf("Enter a number (enter 0 to stop): ");
    scanf("%d", &n);
    if (n == 0)
        break;
    printf("%d cubed is %d\n", n, n * n * n);
}


for (int i = 0,n; i < 11; i++) {
  for (int j = 0; j < 10; j++) {
    n = 10 * i + j;
    if (n > 108) break;
    printf("\033[%dm %3d\033[m", n, n);
  }
  printf("\n");
}


int sum (int n, int a[n]) {
  int res=a[n-1];
  while ( n-- > 0 ) { res+=a[n]; }
  return res;
}
printf( "%d", sum( 5, (int []) { 3,0,3,4,1 }))


int power(int x, int n) { return n==0 ? 1 : x*power(x,n-1);}


int i=0;
{printf("%d",i); int i=1; printf("%d",i);}
printf("%d",i);
for (int i=0; i<2; i++) {printf("%d",i);} 
printf("%d",i);

void d(double x, long *p, double *q) {*p=(long) x;*q=x-*p;};
long i; double f; d(3.14,&i,&f); 
printf("3.14=%i+%.2f\n",i,f); 

int a[N]={1,2,3,4},*p,sum=0,prod=1;
p = &a[0];
while (p < &a[N])
  sum += *p++;
printf("%i",sum);
for(p=a;p<a+N;p++)
  prod *= *p;

char int_to_hex(int i) return "0123456789ABCDEF"[i];

int count_spaces(const char s[]) {
  int count = 0, i;
  for (i = 0; s[i] != '\0'; i++) if (s[i] == ' ') count++;
  return count;
}

int count_spaces(const char *s) {
  int count=0
  for (; *s!='\0' ;s++) if (*s == ' ') count++;
  return count;
} //*s!='\0', *s!=0, *s are the same

int len(const char *s) {const char *p=s; while(*s++); return (s-1)-p;}

void cat(char *s, const char *t) {char *p=s; while (*p)p++; while (*p++=*t++);}
```
