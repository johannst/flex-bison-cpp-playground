// flex-bison-cpp-playground -- 02_simple_parser/parser.yy
// author: johannst

%skeleton "lalr1.cc"
%require  "3.0"
%debug
%defines
%define api.namespace {nAppa}
%define parser_class_name {Parser}

%code requires{
   namespace nAppa {
      class Lexer;
   }
}

%parse-param { Lexer &lexer  }

%code{
   #include "lexer.h"

   #undef yylex
   #define yylex lexer.yylex
}

%define parse.assert

%token   END    0
%token   DEFINITION_BLOCK

%locations

%%

file
: END
| DEFINITION_BLOCK '{' '}' { std::cout << "Parser matched DEFINITION expression!" << std::endl; }
;

%%

void nAppa::Parser::error(const location_type &l, const std::string &err_message) {
   std::cerr << "Error: " << err_message << " at " << l << std::endl;;
}

#include <fstream>
#include <cassert>

int main(int argc, const char* argv[]) {
   if (argc > 1) {
      std::ifstream infile(argv[1]);
      assert(infile.is_open() && infile.good());
      nAppa::Lexer l(infile);
      nAppa::Parser p(l);
      return p.parse();
   } else {
      nAppa::Lexer l(std::cin);
      nAppa::Parser p(l);
      return p.parse();
   }
}

// vim:et:ft=yacc

