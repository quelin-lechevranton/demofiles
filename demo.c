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
\' //single quote
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

/*TYPES*********************/
const long long unsigned ......
sizeof(a) //size in the memory of the variable a

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

int length(a) { return (int) sizeof(a) / sizeof(a[0]); }

int m[2][2]; //matrix
//m[i,j] is interpreted as m[j]
//m is stored in memory as m[0][0],m[0][1],m[1][0],m[1][1] as a 4-array would be
int m[2][2]={ {1,2} , {3,4} };
int m[2][2]={1,2,3,4};

memcpy(a,b, sizeof(a));

/*EXAMPLES******************/

#define PI 3.1415


int i,j;
i = 1 + (j=3);


int i,j=0,k,l=0;
i=j++;
l=++l


int i=0,a[10]; while(i<10) a[i++]=0;


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

  
