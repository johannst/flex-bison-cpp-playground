# Bare Lexer

This is a simple skeleton to demonstrate how flex++ can be used to generate cpp scanners.
We derive `nAppa::Lexer` from `yyFlexLexer` which is not required but put here as a starting point.

When run the lexer simply matches any token and prints it back out while eating up line feeds.

```
make

./lexer
abc
Matched TOKEN: a
Matched TOKEN: b
Matched TOKEN: c
```
## Short explanation

**`%option c++`**

Makes sure we use cpp mode even we run flex instead of flex++.

**`%option nodefault`**

Don't generate the default rule (which calls ECHO).

**`%option noyywrap`**

Generate a default stub of `yywrap()` function which returns 1 (no yywrap).
`yywrap()` is necessary when the lex input consists of multiple input streams.

**`%option yyclass="nAppa::Lexer"`**

Tell flex that we derived from `yyFlexLexer`. Flex will generate the action code into the derived class
and generate a call to `yyFlexLexer::LexerError()` for `yyFlexLexer::yylex()`.

**`#define YY_DECL int nAppa::Lexer::yylex()`**

We need to define `YY_DECL` to match the exact signature of our scanner function as the generated code
from flex++ looks as follows:
```
/** The main scanner function which does all the work.
 */
YY_DECL
{
	yy_state_type yy_current_state;
	...
```
To be honest, `YY_DECL` is not requiered in this specific case here as flex++ generated a default
definition based on `yyclass` as

`#define YY_DECL int nAppa::Lexer::yylex()`

However we will need it when we interface with bison later, so I already introduce it here.

