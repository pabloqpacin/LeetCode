
```sh
apt show cppcheck
apt install cppcheck
```
```sh
cppcheck src/hello_world.cpp 2> logs/cppcheck.log                                                                                                                    feat-ci  ✭ ✱

cppcheck \
  --enable=warning,style,performance,portability \
  --suppress=missingIncludeSystem \
  --error-exitcode=1 \
  --inline-suppr \
  --xml-version=2 \
  src/
```
