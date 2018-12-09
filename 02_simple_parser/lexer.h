// flex-bison-cpp-playground -- 02_simple_parser/lexer.h
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

      virtual Parser::symbol_type flex();
      Parser::location_type loc;
   };
}

// vim:et:ft=cpp

