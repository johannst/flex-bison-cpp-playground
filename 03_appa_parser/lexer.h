// flex-bison-cpp-playground -- 03_appa_parser/lexer.h
// author: johannst

#pragma once

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "parser.tab.hh"

namespace nAppa {
   class Lexer: public yyFlexLexer {
    public:
      Lexer(std::istream& is): yyFlexLexer(&is) {}
      Lexer(const Lexer&) =delete;
      Lexer& operator=(const Lexer&) =delete;

      // resolve hidden overloaded function warning
      virtual int yylex() override { assert(false); }

      virtual int yylex(Parser::semantic_type* lval, Parser::location_type* loc);

    private:
      void dumpToken(bool dump=false) {
         if (!dump) { return; }
         if (YYText()[0]==' ' || std::string(YYText()).find_first_of("\t\n")!=std::string::npos) { return; }
         std::cout << "[Lexer]: Token '" << YYText() << "'" << std::endl;
      }
   };
}

// vim:et:ft=cpp

