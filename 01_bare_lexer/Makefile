# flex-bison-playground -- 01_bare_lexer/Makefile
# author: johannst

CXX = clang++
CXXFLAGS = -g -O0

FLEX = flex++

ELF = lexer

$(ELF): lexer.yy.o
	$(CXX) -o $@ $^

%.yy.cc: %.l
	$(FLEX) -o $@ $<

%.o: %.cc
	$(CXX) -c -o $@ $<

clean:
	rm -f $(ELF) *.o

