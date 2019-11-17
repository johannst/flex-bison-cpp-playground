/* flex-bison-playground -- 01_bare_lexer/lexer.l */
/* author: johannst                               */

%option c++
%option debug
%option warn
%option nodefault
%option noyywrap
%option yyclass="nLex::Lexer"

%{
   #include "lexer.h"
   #include <iostream>

   #undef  YY_DECL
   #define YY_DECL int nLex::Lexer::yylex()
%}

%%

.     { std::cout << "Matched TOKEN: " << YYText() << std::endl; }
\n    ;

%%

#include <fstream>
#include <cassert>

int main(int argc, const char* argv[]) {
   if (argc > 1) {
      std::ifstream infile(argv[1]);
      assert(infile.is_open() && infile.good());
      nLex::Lexer l(infile);
      return l.yylex();
   } else {
      nLex::Lexer l(std::cin);
      return l.yylex();
   }
}

// vim:et:ft=lex
