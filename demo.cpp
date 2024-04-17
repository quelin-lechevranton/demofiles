/*
 * The C++ Programming Language
 * Bjarne Stroustrup
 * Third and Fourth Edition
 */

#include<stdio.h>

/*TYPE*DECLARATION********4*/

//built-in types
    //arithmetic types
        //floating-point: double
        //integral types
            //boolean
            //character
            //integer
    //pointers
    //arrays
    //references
//user-defined
    //enumeration types
    //data structures and classes

/*characters: 
    char: almost universally on 8 bits (256). 
    character set is a variation of ISO-646 (eg. ASCII) but not standardized.
    signed char: -127 to 127
    unsigned char: 0 255
    wchar_t: should hold every possible character (implementation dependant)
*/

/*zero:
    char: NUL (null-character \0)
    int: 0
    float: 0.
    bool: false
    pointer: NULL
*/

//read until: 4.3.1 excl.

/*POINTER*ARRAY*STRUCT.***5*/

int* p;         //pointer
int a[];        //array: array bound must be a const type (cf. vectors)
auto s ="abc";  //string literal: const char[4] (can be converted to char*)
auto s =L"abc"; //const wchar_t[4]

int i=1;
int& r=i;       //reference: now r==i and &r==&i, the value has not been copied
void incr(int& x) {x++;}    //side effect function: incr(i);
void incp(int* p) {++*p;}   //more clear that it as side effects: incr(&i);

//arrays: aggregate of elements of same type
//structures: aggregate of elements of arbitrary types
struct date_struct { unsigned int day; char* month; signed int year;};
date_struct birthday,christmas={25,"decembre",2023}; 
void f1() {
    birthday.day=2; birthday.month="avril"; birthday.year=2001;
}
date_struct* pxmas=&christmas;
void f2() {
    pxmas->year=2024; (*pxmas).year=2024; //those are equivalent
}

struct S; S* pS; S fS(); //but S a; pS->..; fs(); are wrong since the size allocation is unknown yet

/*NAMSPACE******************/

namespace square {
    using m2 = double;
    using m = double;
    m2 area(double c) {return c*c;}
    m perimeter(double c) {return 4*c;}
}
square::m side = 2;
square::m2 A = square::area(side);
square::m2 area_sum (double c1, double c2) {
    using square::area;
    return area(c1) + area(c2);
}
double area_and_perimeter (double c) {
    using namespace square;
    return area(c) + perimeter(c);
}

/*CLASSE*****************10*/

class date {
    int y,m,d; //those are private member accessed via: today.y, only inside the class body
    static date today; //this is a private but static member: it has the same value for all object of this class. it can be accessed directly, ie. not through an object, via: date::today
public:
    static void today_is(int,int,int);
    date(int Y=0, int M=0, int D=0); //constructor: it initialize a class, function with the name of the class. why no return type has been specified?
    //default are set to 0 so that if no argument is provided in declaration the date is today
    //this is a public function available everywhere ?
    int year() const {return y;} //make the private member y accessible in public via: today.year(). the const indicates the compiler that this functions doesn't modify the object
    date& add_year(int n) {y+=n; return *this;}; //add a year to the object. not const. this is a pointer to the object for which the member function is invoked. 
    //every reference to a non-static member within a class relies on an implicit use of this: y and this->y are the same
};
date date::today(2024,4,16);
void date::today_is(int Y, int M, int D) {
    date::today = date(Y,M,D);
} //don't repeat the static, already set in the prototype, static variable makes no sense in the core part of the program
date::date (int Y, int M, int D) {
    y = Y ? Y : today.y; 
    m = M ? M : today.m;
    d = D ? D : today.d;
}
date bday = date (2001,4,2); //decalartion of the object birthday from the class date
date bday(2001,4,2); //those are equivalents
date hui; 
date hoy=hui; //by default this means the copy of each members 
int by = bday.year();

//read until: 10.2.7.2 excl.