/*
How to compile and run

g++ src/hello_world.cpp -o bin/hello_world && ./bin/hello_world || \
make && ./bin/hello_world
*/

#include <iostream>
using std::cout;
using std::endl;

int main(){
  cout << "Hello World!" << endl;
  // cout << "Hello World!" << flush;

  return 0;
}
