#include<stdio.h>
#include<string.h>
//#include <utility>

void print(int i) {printf("%d",i);}

int main() {
  void d(double x, long *p, double *q) {*p=(long) x;*q=x-*p;};
  long i;double f;d(3.14,&i,&f);
  //void *p=&d;
  printf("3.14=%i+%.2f\n",i,f);
  printf("%p,%p",&i,&f);

  return 0;
}
