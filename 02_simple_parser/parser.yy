// flex-bison-cpp-playground -- 02_simple_parser/parser.yy
// author: johannst

%skeleton "lalr1.cc"
%require  "3.0"
%language "c++"
%debug
%defines
%define api.namespace {nAppa}
%define parser_class_name {Parser}
%define api.value.type variant
%define api.token.constructor

%code requires{
   namespace nAppa {
      class Lexer;
   }
}

%parse-param { Lexer &lexer  }

%code{
   #include "lexer.h"

   #undef yylex
   #define yylex lexer.flex
}

%define parse.assert

%token   END    0
%token   <std::string> DEFINITION_BLOCK

%start file

%locations

%%

file
: END
| DEFINITION_BLOCK { std::cout << "Parser matched DEFINITION expression, got semantic_value = " << $1 << std::endl; }
;

%%

void nAppa::Parser::error(const location_type &l, const std::string &err_message) {
   std::cerr << "Error: " << err_message << " at " << l << std::endl;;
}

#include <fstream>
#include <sstream>
#include <cassert>
#include <memory>

int main(int argc, const char* argv[]) {
   std::unique_ptr<std::istream> is = 0;
   if (argc > 1) {
      is = std::make_unique<std::fstream>(argv[1]);
   } else {
      is = std::make_unique<std::istringstream>("DEFINITION {  \n   }    ");
   }
   assert(is->good());

   nAppa::Lexer l(*is);
   nAppa::Parser p(l);
   return p.parse();
}

// vim:et:ft=yacc

