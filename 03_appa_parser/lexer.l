/* flex-bison-cpp-playground -- 03_appa_parser/lexer.l */
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

   #define YY_USER_ACTION loc->step(); loc->columns(YYLeng()); dumpToken(false);

   #define yyterminate() { return token::END; }
%}

L [a-zA-Z_]
D [0-9]

%%

%{
   (void)lval;
%}

[ \t]          ; // eat whitespace
[{},:]         {
                  return YYText()[0];
               }
{D}+           {
                  lval->stInt = std::stoi(YYText());
                  return token::NUMBER;
               }
{L}({L}|{D})*  {
                  lval->stStr = new std::string(YYText());
                  return token::ID;
               }
\n             loc->lines();
.              {
                  std::cerr << "[Lexer]: Unrecognized token '" << YYText() << "' @" << *loc << ", terminating ... " << std::endl;
                  yyterminate();
               }

%%

// vim:et:ft=lex

