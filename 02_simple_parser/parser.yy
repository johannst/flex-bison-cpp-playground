// flex-bison-cpp-playground -- 02_simple_parser/parser.yy
// author: johannst

%skeleton "lalr1.cc"
%require  "3.0"
%language "c++"
%debug
%defines
%define api.namespace {nAppa}
%define api.parser.class {Parser}

%code requires {
   namespace nAppa {
      class Lexer;
   }
}

%parse-param { Lexer &lexer }

%code {
   #include "lexer.h"

   #undef yylex
   #define yylex lexer.yylex
}

%define parse.assert true
%define parse.error verbose
%locations
%expect 0

%union {
   long int ival;
}

%token   END    0
%token   END_EXPR
%token<ival>   NUMBER
%type <ival>   expr expr_add expr_sub

%start expr_ress

%%

expr_ress
: expr_res
| expr_ress expr_res

expr_res
: expr END_EXPR { std::cout << "Parser expr result = " << $1 << std::endl; }
| END_EXPR

expr
: expr_add
| expr_sub

expr_add
: expr '+' NUMBER { $$ = $1 + $3; }
| NUMBER '+' NUMBER { $$ = $1 + $3; }

expr_sub
: expr '-' NUMBER { $$ = $1 - $3; }
| NUMBER '-' NUMBER { $$ = $1 - $3; }

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
      is = std::make_unique<std::istringstream>("4+6+4-10+5;12+30\n");
   }
   assert(is->good());

   nAppa::Lexer l(*is);
   nAppa::Parser p(l);
   return p.parse();
}

// vim:et:ft=yacc

