#include<stdio.h>
#include<string.h>
//#include <utility>

void print(int i) {printf("%d",i);}

int main() {
  int i=0;
  {print(i); int i=3; print(i);}
  print(i);
  return 0;
}
