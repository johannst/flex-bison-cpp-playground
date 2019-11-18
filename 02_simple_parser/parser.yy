// flex-bison-cpp-playground -- 02_simple_parser/parser.yy
// author: johannst

%skeleton "lalr1.cc"
%require  "3.0"
%language "c++"
%debug
%defines
%define api.namespace {nExpr}
%define api.parser.class {Parser}

%code requires {
   namespace nExpr {
      class Lexer;
   }
}

%parse-param { Lexer &lexer }
%parse-param { bool verbose }

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
%type <ival>   expr

%start expr_ress

%left '+' '-'
%left '*' '/'

%%

expr_ress
: expr_res
| expr_ress expr_res

expr_res
: expr END_EXPR { std::cout << "Parser expr result = " << $1 << std::endl; }
| END_EXPR

expr
: NUMBER
| expr '/' expr { $$ = $1 / $3; if (verbose) { std::cout << "Parser: DIV " << $1 << " " << $3 << std::endl; } }
| expr '*' expr { $$ = $1 * $3; if (verbose) { std::cout << "Parser: MUL " << $1 << " " << $3 << std::endl; } }
| expr '+' expr { $$ = $1 + $3; if (verbose) { std::cout << "Parser: ADD " << $1 << " " << $3 << std::endl; } }
| expr '-' expr { $$ = $1 - $3; if (verbose) { std::cout << "Parser: SUB " << $1 << " " << $3 << std::endl; } }

%%

void nExpr::Parser::error(const location_type &l, const std::string &err_message) {
   std::cerr << "Error: " << err_message << " at " << l << std::endl;;
}

#include <sstream>
#include <cassert>

struct Opts {
    bool verbose;
} gOpts = { false };

void parseOpts(int argc, const char* argv[]) {
   // skip argv[0] -- program name
   for (int i=1; i<argc; ++i) {
      assert(argv[i]);

      std::string arg(argv[i]);
      if (arg == "-v") {
         gOpts.verbose = true;
      }
      if (arg == "-h" || arg == "--help") {
         std::cout << argv[0] << " [-v]\n"
                   << "    -v ... verbose mode\n"
                   << std::endl;
         std::exit(0);
      }
   }
}

int main(int argc, const char* argv[]) {
   parseOpts(argc, argv);

   std::cout << "Enter expressions to evaluate ('q' to exit)" << std::endl;
   while (true) {
      std::cout << "> " << std::flush;
      std::string input;
      std::getline(std::cin, input);
      if (input == "q") {
         break;
      }
      input += ';'; // make sure expr is terminated

      std::istringstream input_stream(input);
      nExpr::Lexer l(input_stream, gOpts.verbose);
      nExpr::Parser p(l, gOpts.verbose);
      p.parse();
   }

   return 0;
}

// vim:et:ft=yacc

