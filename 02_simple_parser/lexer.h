// flex-bison-cpp-playground -- 02_simple_parser/lexer.h
// author: johannst

#pragma once

#if !defined(yyFlexLexerOnce)
#include <FlexLexer.h>
#endif

#include "parser.tab.hh"

namespace nExpr {
   class Lexer: public yyFlexLexer {
    public:
      Lexer(std::istream& is, bool verbose): yyFlexLexer(&is), mVerbose(verbose) {}
      Lexer(const Lexer&) =delete;
      Lexer& operator=(const Lexer&) =delete;

      // resolve hidden overloaded function warning
      virtual int yylex() override { assert(false); }

      virtual int yylex(Parser::semantic_type* lval, Parser::location_type* loc);

    private:
      bool mVerbose;
   };
}

// vim:et:ft=cpp

