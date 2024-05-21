# JavaScript

> *Eloquent JavaScript*
> by Marijn Haverbeke,
> 4th ed.

Special numerical values: `Infinity` `-Infinity` `NaN`

> p.112: C7 Project: A Robot
>
> p.123: C8 Bugs and Error
>
> p.138: C9 Regular Expressions

## Strings

strings are enclosed by singlequotes, doublequotes

formatted strings are enclosed by backticks

| | |
| - | - |
| `+` | concatenation |
| `` `${expr}` `` | result of the expression `expr` |

## Boolean operations

same as `C`
| | |
| - | - |
| `===` | equality without type conversion |
| `!==` | inequality without type conversion |
| `a\|\|b` | `if (a) a; else b;` |
| `"a" in b` | checks if the object `b` has a property `a`, true even if set to `undefined` |
| `a instanceof B` | checks if the object `a` inherits from the class `B` |

## Loops and conditions

```javascript
if ( ... ) { ... ; } else { ... ; }
while ( ... ) { ... ; }
do { ... ; } while ( ... );
for ( ... ; ... ; ... ) { ... ; }
for ( let ... of ... ) { ... ; }
switch ( ... ) { case ... : ... ; break; default: ... ;}
```

## Variable

### Declaration

```javascript
let a = 1, b = 2;
const c = 3;
var e = 4; //function-scope variable
```

### Functions

```javascript
const f = function ( ... , ... ) { ... ; return ... ; };
function g ( ... , ... ) { ... ; return ... ; }
const h = ( ... , ... ) => { ... ; return ... ; };

function i (...a) { for (let b in a) { ... } return ...;} //rest parameters
let j = i(...[1,2,3]); //call with an array of arguments
function k ([a,b,c]) { ... ; return ... ; } //destructuring arrays
function l ({a,b,c}) { ... ; return ... ; } //destructuring objects
```

### Arrays

```javascript
let m = [ 5, 6, 7 ];
let n = m[2] + 1;
```

### Objects

```javascript
let o = { p: 9, "q q": 11, a};
let r = o.p;
let s = o["q q"];
o.a==1;
let t = o; //same address
const u = { ... }; //address is constant not the content

v?.att //returns undefined if v doesn't have a property attr 
v?.() //returns undefined if v is not callable
v?.[i] //returns undefined if v has no supscript
```

### Classes

```javascript
let today = 2024;
let proto = { 
    name: "jacques",
    birth: 0,
    age() { return today - this.birth;}
}
let person = Object.create(proto);
person.birth=2001;

class Person {
    //private properties start with #
    #id = 0; 
    name = "jacques";

    //static members are access via the constructor namespace
    static today = 2024;

    constructor(b) { this.birth = b;}
    age() { return Person.today - this.birth;}
}
let person = new Person(2001);
Person.prototype.height=180;
//every object Person has a property height, this is retroactive
//every object inherit from Object.prototype 

Person.prototype.toString = function() { return this.name+", born ${this.birth}"; };
console.log(String(person));

class Temperature {
    constructor(c) { this.celsius = c;}

    get fahrenheit() { return this.celsius * 1.8 + 32; }
    set fahrenheit(f) { this.celsius = (f - 32) / 1.8; }

    static fromFahrenheit(value) {
    return new Temperature((value - 32) / 1.8);
    }
}
let temp = new Temperature(22);
console.log(temp.fahrenheit);
temp.fahrenheit = 86;
console.log(temp.celsius);

class SubClass extends SuperClass {
    //the SuperClass constructor is called with super() and members with super.member
}
```

### Maps

```javascript
let w = new Map();
w.set("key", 12);
w.get("key");
w.has("key");
```

### Symbols

> p.105

## Arrayology

| | |
| - | - |
| __arrays__ | |
| stack | `push(x)` `pop()` |
| queue | `push(x)` `shift()` and `unshift(x)` |
| search | `indexOf(x)` `lastIndexOf(x)` |
| loop | `forEach(x => sideEffet(x))` `filter(x => condition(x))` `map(x => f(x))` `reduce(f,x0)` `some(condition(x))`|
| __strings__ | |
| access | `length` `indexOf("...")` |
| modification | `toUpperCase()` `toLowerCase()` |
| new string | `slice(i, j)` `trim()` `padStart(n, "..")` `repeat(n)` |
| string arrays | `split("...")` `join("...")` |
| __general__ | |

```javascript
//forEach necessits a key "length" an a key "i" for i=0 to i=length-1
Array.prototype.forEach.call({ length: 2, 0: "a", 1: "b"},x=>console.log(x));

//for/of loop necessits a method [Symbol.iterator] that return an object with a method next() which return an object that have keys value and done
for (let x of obj) { ... ; }
for (
    let its=obj[Symbol.iterator]() , it=its.next() , x = it.value ;
    !it.done ;
    it = its.next() , x = it.value
) { ... ; }
```

## JSON: JavaScript Object Notation

all properties must be around double quotes

not comments allowed

```javascript
let str = JSON.stringify(obj);
let obj = JSON.parse(str);
```

## Modularity

```javascript
//in file1.js:
const days = ["niti","getu","ka","sui","moku","kin","do"];
const default "youbi";
// const weekday = "youbi";
// const default weekday; //is this legit?

export function dayName(i) { return days[i]; }
export function dayNumber(d) { return days.indexOf(d); }
export function dayFullName(i) { return days[i]+"youbi"; }

//in file2.js:
import {dayName, dayNumber} from "./file1.js";
console.log(day.dayName(3));

//in file3.js:
import weekday from "./file1.js";
//weekday === "youbi"

//in file4.js
import * as day from "./file1.js";
console.log(day.dayFullName(3));
```

## Examples

```javascript
"4"+2==42;
"4"+2!==42;

function noisy(f) {
    return (...args) => {
        console.log("calling with", args);
        let result = f(...args);
        console.log("called with", args, ", returned", result);
        return result;
    };
}
```
