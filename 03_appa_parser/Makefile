# flex-bison-cpp-playground -- 03_appa_parser/Makefile
# author: johannst

CXX = clang++
CXXFLAGS = -g -O0 -Wall -Wextra -Werror -std=c++14 -MMD -MP

FLEX = flex++
BISON = bison
BISONFLAGS = -Wall -Werror

ELF = parser

OBJS = parser.tab.o lexer.yy.o
DEPS = $(patsubst %.o, %.d, $(OBJS))

$(ELF): $(OBJS)
	$(CXX) -o $@ $^

%.yy.cc: %.l
	$(FLEX) -o $@ $<

%.tab.cc: %.yy
	$(BISON) $(BISONFLAGS) -d $<
.SECONDARY: %.cc

%.o: %.cc
	$(CXX) $(CXXFLAGS) -c -o $@ $<

check: $(ELF)
	valgrind ./$(ELF)

clean:
	rm -f $(ELF) $(OBJS) $(DEPS)
	rm -f lexer.yy.cc
	rm -f parser.tab.{hh,cc} location.hh position.hh stack.hh

-include $(DEPS)

