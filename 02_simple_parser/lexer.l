/* flex-bison-cpp-playground -- 02_simple_parser/lexer.l */
/* author: johannst                                      */

%option c++
%option debug
%option warn
%option nodefault
%option noyywrap
%option yyclass="nAppa::Lexer"

%{
   #include "lexer.h"

   #undef  YY_DECL
   #define YY_DECL nAppa::Parser::symbol_type nAppa::Lexer::flex()

   using token = nAppa::Parser::token;

   #define YY_USER_ACTION loc.step(); loc.columns(YYLeng());

   #define yyterminate() { return Parser::make_END(loc); }
%}

%%

[ \t]       ; // eat whitespace

DEFINITION  {
              std::cout << "Lexer matched: DEFINITION" << std::endl;
              return Parser::make_DEFINITION_BLOCK("some_value_from_your_lexer", loc);
            }


.           ; // eat unknown chars

\n          loc.lines();

%%

// vim:et:ft=lex

