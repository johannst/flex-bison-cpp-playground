# Simple Parser

This is a simple starting point for using flex++ & bison++ and can be used as a skeleton.

The parser is a simple calculator which can evaluate add/sub/mul/div expressions.
The lexer lexes numbers and +,-,*,/ operators and the parser evaluates the expression.

For demonstration purpose the parser reads expressions from stdin until
`'q'` is entered to quit. The lexer and parser can be made verbose by supplying
the `-v` flag.

```
make
./paser [-v]
```

## Short explanation: options

**`%debug`**

Enables the debug macro YYDEBUG inside the generated parser.
Allows to enable tracing of the parser when setting `p.set_debug_level(1);`.

**`%language c++`**

Specifies the language of the generated parser.

**`%define api.namespace { ns }`**

Defines the c++ namespace the parser is generated in.

**`%define parser_class_name { name }`**

The name of the generated parser class.

**`%define parser.assert true/false`**

Generate runtime asserts for invalid use.

**`%define parser.error simple/verbose`**

Controls the verbosity of error message passed to the error handler.

**`%parse-param { Lexer &lexer }`**

Additional arguments in the generated parser constructor.

**`%expect 0`**

Fail to generate if we have any shift/reduce | reduce/reduce conflicts.


**`%locations`**

Enable generation of location tracking code.

**`%code requires {}`**

Code gets copied verbatim into the generated parser header file.

**`%code {}`**

Code gets copied verbatim into the generated parser implementation file.


## Short explanation: tokens & lvalue

**`%token [<type>] name [val]`**

Define a token with an optional token type and optional numeric value (bigger than 0).
By convention tokens are named all capitalized.

**`%type <type> gr_rule`**

Specify a return type for an intermediate grammar rule.

**`%start grammer_rule`**

Define the parsers start symbols.


## TODO:
- Describe union and grammar rules

## References
* Options: https://www.gnu.org/software/bison/manual/html_node/Bison-Options.html
* Defines: https://www.gnu.org/software/bison/manual/html_node/_0025define-Summary.html
