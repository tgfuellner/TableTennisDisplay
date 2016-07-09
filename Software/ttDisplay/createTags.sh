ctags -f tags.ino --langmap=c++:.ino ttDisplay.ino
ctags -f tags.cpp `find ~/Arduino/libraries/ -name "*.cpp" -o -name "*.h"`
cat tags.cpp tags.ino > tags
sort tags -o tags
rm tags.*
