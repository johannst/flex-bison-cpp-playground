// flex-bison-cpp-playground -- 03_appa_parser/parser.yy
// author: johannst

%skeleton "lalr1.cc"
%require  "3.0"
%language "c++"
%debug
%defines
%define api.namespace {nAppa}
%define api.parser.class {Parser}

%code requires{
   #include "appa.h"
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
%define parse.error verbose
%locations
%expect 0


%token            END    0
%token <stInt>    NUMBER
%token <stStr>    ID
%type <stMapStrElement> dict_entries
%type <stPairStrElement> dict_entry
%type <stPairStrElement> dict

%union {
   int stInt;
   const std::string* stStr;
   const std::pair<const std::string*, const Element*>* stPairStrElement;
   std::map<const std::string*, const Element*>* stMapStrElement;
   const DictElement* stDict;
}

%start appa

%%

appa:
   dict
   {
      // Dump the parsed structure
      std::cout << "APPA: " << *$1->first << std::endl;

      AppaWalker w;
      $1->second->accept(w);

      delete $1->first;
      delete $1->second;
      delete $1;
   }

dict:
   ID ':' '{' dict_entries opt_comma '}'
   {
      $$ = new std::pair<const std::string*, const Element*>($1, new DictElement($4));
   }

dict_entries:
   dict_entry
   {
      $$ = new std::map<const std::string*, const Element*>;
      $$->insert(*$1);
      delete $1; // delete pair
   }
 | dict_entries ',' dict_entry
 {
   $$ = $1;
   $$->insert(*$3);
   delete $3; // delete pair
 }

dict_entry:
   ID ':' NUMBER
   {
      $$ = new std::pair<const std::string*, const Element*>($1, new NumElement($3));
   }
 | dict;

opt_comma:
   %empty
 | ','

%%

void nAppa::Parser::error(const location_type& l, const std::string& err_message) {
   std::cerr << "[Parser]: " << err_message << " @" << l << ", terminating ... " << std::endl;
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
      std::string input("");
      input += "pizzas : {\n";
      input += "  veg_pizza : {\n";
      input += "     cheese : 5,\n";
      input += "     cheese_mushroom: 6,\n";
      input += "     fresh_tomato: 8,\n";
      input += "  },\n";
      input += "  non_veg_pizza : {\n";
      input += "     hot_dog: 8,\n";
      input += "     shred_chicken: 9,\n";
      input += "  },\n";
      input += "}";

      is = std::make_unique<std::istringstream>(input);
   }
   assert(is->good());

   nAppa::Lexer l(*is);
   nAppa::Parser p(l);
   return p.parse();
}

// vim:et:ft=yacc

