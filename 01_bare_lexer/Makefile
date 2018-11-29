# flex-bison-playground -- 01_bare_lexer/Makefile
# author: johannst

CXX = clang++
CXXFLAGS = -g -O0 -Wall -Wextra -Werror -std=c++11

FLEX = flex++

ELF = lexer

$(ELF): lexer.yy.o
	$(CXX) -o $@ $^

%.yy.cc: %.l %.h
	$(FLEX) -o $@ $<

%.o: %.cc
	$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f $(ELF) *.o

