/* flex-bison-cpp-playground -- 02_simple_parser/lexer.l */
/* author: johannst                                      */

%option c++
%option debug
%option warn
%option nodefault
%option noyywrap
%option yyclass="nExpr::Lexer"

%{
   #include "lexer.h"
   #include <cstdlib>

   #undef  YY_DECL
   #define YY_DECL int nExpr::Lexer::yylex(Parser::semantic_type* lval, Parser::location_type* loc)

   using token = nExpr::Parser::token;

   #define YY_USER_ACTION loc->step(); loc->columns(YYLeng());

   #define yyterminate() { return token::END; }
%}

%%

[ \t]       ; // eat whitespace

[1-9][0-9]* {
               lval->ival = std::strtol(YYText(), 0 /* endptr */, 10 /* base */);
               std::cout << "Lexer matched: " << lval->ival << std::endl;
               return token::NUMBER;
            }

[+-]        {
               std::cout << "Lexer matched: " << YYText()[0] << std::endl;
               return YYText()[0];
            }

[\n;]       {
               if (YYText()[0] == '\n') {
                  loc->lines();
               }
               return token::END_EXPR;
            }
.           ; // eat unknown chars


%%

// vim:et:ft=lex

