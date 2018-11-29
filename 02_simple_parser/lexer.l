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
   #define YY_DECL int nAppa::Lexer::yylex(Parser::semantic_type* lval, Parser::location_type* loc)

   using token = nAppa::Parser::token;

   #define YY_USER_ACTION loc->step(); loc->columns(YYLeng());

   #define yyterminate() { return token::END; }
%}

%%

%{
   lval = 0;
%}

[ \t]       ; // eat whitespace

DEFINITION  {
              std::cout << "Lexer matched: DEFINITION" << std::endl;
              return token::DEFINITION_BLOCK;
            }

[{}]        {
              std::cout << "Lexer matched: " << YYText()[0] << std::endl;
               return YYText()[0];
            }

.           ; // eat unknown chars

\n          loc->lines();

%%

// vim:et:ft=lex

