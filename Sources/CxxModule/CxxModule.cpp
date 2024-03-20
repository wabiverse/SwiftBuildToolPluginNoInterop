#include <CxxModule/cxxA.h>
#include <CxxModule/cxxB.h>
#include <CxxModule/cxxC.h>
#include <CxxModule/cxxD.h>

#include <iostream>

Example::Example()
{}

void Example::doSomething()
{
  A a;
  B b;
  C c;
  D d;
  a.a = 1;
  b.b = 2;
  c.c = 3;
  d.d = 4;

  printf("a.a = %d, b.b = %d, c.c = %d, d.d = %d\n", a.a, b.b, c.c, d.d);
}
