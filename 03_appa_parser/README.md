# APPA* Lexer & Parser

This folder contains a lexer & parser pair for the language `a product price
array (APPA)` I just came up with for this exercise. `APPA` is described using
EBNF as follows:

```
appa: dict
dict: ID ':' '{' dict_entry  { ',' dict_entry } [','] '}'
dict_entry: ID ':' (NUMBER | dict)
```
Where the terminal symbols are defined as
```
ID: [A-Za-z_][A-Za-z0-9_]*
NUMBER: [1-9][0-9]*
```

An example APPA file looks like this
```
pizza_prizes.appa
-----------------
pizza : {
  veg_pizza : {
    cheese : 5,
    cheese_mushroom: 6,
    fresh_tomato: 8,
  },
  non_veg_pizza : {
    hot_dog: 8,
    shred_chicken: 9,
  },
}
```

##  Build and run

The parser optionally accepts a file or prints a hard-coded APPA string as example.
```
make
./paser [<file>]
```

---
###### *Easter egg
The flying `bison` [appa](https://avatar.fandom.com/wiki/Appa).

