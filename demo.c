/*
 * C Programming: A Modern Approach
 * K. N. King
 * Second Edition
 */



<...> //headers

/*DIRECTIVES****************/
#include 
#define ...1 ...2 //macros: when ...1 is typed the compiler will understand ...2


/*LIST OF TYPES*************/
int, short, long, long long, unsigned int
float, double, long double
char //sigle quotes '': in ASCII from 0 to 127


/*ESCAPE SEQUENCES**********/
\a //alert
\b //backspace
\f //??
\n //new line
\r //carriage return
\t //tab
\v //vertical tab

\\ //backslash
\? //question mark
\' //single quote'
\" //double quote"
%% //percentage

/*PLACEHOLDERS**************/
%5.3d //decimal (int): "  001"
%-5.3d //"001  "
%u //unsigned
%o //octal
%x //hexadecimal
%i //01 -> octal, 0x -> hexadecimal
%.2f //float to the hundredth
%.2e //exponential form
%.2g //auto decimal or exponetial form

%c //character (can be used on an int to print ASCII character)
%.3s //3 first character of a string (char array)
%-10.5s //left-aligned first 5 character in a line of 10
%4s //in scanf, store only the first 4 characters of the string input

/*LOGICAL OPERATORS**********/
!
&&
||


/*STATEMENTS & EXPRESSIONS**/
...; //simple statements
{ ...; ...; } //compound statements
...1, ...2; //comma expression: value=...2
...1 ? ...2 : ...3 //if (...1) ...2; else ...3;

/*SELECTION STATEMENTS*******/
if ( ... ) ...; else ...; //if statement
switch ( ...1 ) { case 2: ...2; break; case 3: ...3; } //switch statement: ...1 must be int, if ...1==2 then ...2 is executed, then break quit the switch statement

/*ITERATION STATEMENTS*******/
while ( ... ) ...; //while loop
do ... while ( ... ) ; //do loop
for ( ...1; ...2; ...3 ) ...4; //for loop
...1 ; while ( ..2 ) { ...4; ...3; } //for loop equivalent
while (1) ...; for (;;) ...; //infinit loops

/*JUMP STATEMENTS***********/
break; //break the loop
continue; //break the interation
goto id1; /*****/  id1: ...;

/*INPUT/OUTPUT**************/
//printf :
//puts : one argument: a string
//putchar : one argument: a char

//scanf : start at first non-white space character, stops at a white space, tab, or new line
//gets : stops at new line
//getchar()


/*TYPES*********************/
const long long unsigned ......
sizeof(a) //size in the memory of the variable a

static int a; //A variable with static storage duration has a permanent storage location but still has block scope, so it’s not visible to other functions.



/*BOOLEANS******************/
#define true 1
#define false 0
typedef int bool;

#include<stdbool.h>

/*FUNCTIONS*****************/
int sum (int a,int b) { return a+b; }

int sum (int a,int b); //function declaration to provide a complete description to the compiler if we want to define the function after its first call

//functions can have side effect on pointers and array (not regular values)



/*CHARACTERS****************/
char c = 'a' //interpreted as an int (ASCII): 97 is the ASCII code for 'a'

/*ARRAYS********************/
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

/*POINTERS******************/

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

/*STRINGS*******************/

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


/*EXAMPLES******************/

#define PI 3.1415
#define N 10


int i,j;
i = 1 + (j=3);


int i,j=0,k,l=0;
i=j++;
l=++l


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
