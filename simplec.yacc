%{
#include <stdio.h>
#include "util.h"
#include "errormsg.h"

int yylex(void);

void yyerror(char *s)       //错误处理
{
    EM_error(EM_tokPos, "%s", s);
}

%}


%union
{
    int ival;
    string cval;
    double dval;
    string sval;
}

/*优先级从低到高*/

%token <sval> ID STRINGV
%token <ival> INTV
%token <cval> CHARV
%token <dval> DOUBLEV

%token
        STRING CHAR INT DOUBLE
        DO BREAK CONTINUE FOR WHILE
        CASE DEFAULT IF SWITCH GOTO ELSE
        VOID RETURN
        COLON SEMICOLON LBRACE RBRACE

%left COMMA
%right PLUSASSIGN MINUSASSIGN TIMESASSIGN DIVIDEASSIGN ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LE GE LT GT
%left PLUS MINUS
%left TIMES DIVIDE MOD
%right INC DEC NOT
%left LPAREN RPAREN LBRACK RBRACK

%start program

%%

program
    : function
    | program function
    ;

function
    : VOID ID LPAREN VOID RPAREN LBRACE statements RBRACE
    | id_type ID LPAREN VOID RPAREN LBRACE statements RBRACE
    | VOID ID LPAREN function_paramstate RPAREN LBRACE statements RBRACE
    | id_type ID LPAREN function_paramstate RPAREN LBRACE statements RBRACE
    ;

id_type
    : STRING
    | CHAR
    | INT
    | DOUBLE
    ;

function_paramstate
    : function_paramstate COMMA declaration
    | declaration
    ;

function_paramuse
    : function_paramuse COMMA ID
    | ID
    ;

statements
    : statement
    | statements statement
    ;

statement
    : sequence SEMICOLON
    | select
    | loop
    | BREAK SEMICOLON
    | CONTINUE SEMICOLON
    | RETURN ID SEMICOLON
    | RETURN value SEMICOLON
    ;

/*顺序结构*/

sequence
    : declaration
    | assignment
    | arrassignment
    | ID LPAREN function_paramuse RPAREN
    ;

declaration
    : id_type ID
    | id_type assignment
    | id_type ID LBRACK INT RBRACK
    | id_type arrassignment
    ;

arrassignment
    : ID LBRACK INTV RBRACK ASSIGN LBRACE arrvalue RBRACE
    ;

arrvalue
    : value
    | arrvalue COMMA value
    ;

value
    : INTV
    | CHARV
    | DOUBLEV
    | STRINGV
    ;

assignment
    : ID ASSIGN exp
    | ID LBRACK INTV RBRACK ASSIGN exp
    | ID PLUSASSIGN exp
    | ID MINUSASSIGN exp
    | ID TIMESASSIGN exp
    | ID DIVIDEASSIGN exp
    | ID INC
    | ID DEC
    ;

exp
    : ID
    | value
    | LPAREN exp RPAREN
    | exp PLUS exp
    | exp MINUS exp
    | exp TIMES exp
    | exp DIVIDE exp
    | exp MOD exp
    ;

/*选择结构*/

select
    : ifelsestate
    | SWITCH LPAREN ID RPAREN LBRACE casestatement RBRACE
    ;

ifelsestate
    : IF LPAREN boolexp RPAREN LBRACE statements RBRACE
    | IF LPAREN boolexp RPAREN statement
    | ifelsestate ELSE LBRACE statements RBRACE
    | ifelsestate ELSE statement
    ;

casestatement
    : CASE value COLON statements
    | DEFAULT COLON statements
    | casestatement CASE value COLON statements
    | casestatement DEFAULT COLON statements
    ;

boolexp
    : LPAREN boolexp RPAREN
    | boolexp AND boolexp
    | boolexp OR boolexp
    | NOT boolexp
    | ID compare value
    | value compare ID
    | ID
    | value
    ;

compare
    : NEQ
    | LE
    | GE
    | EQ
    | LT
    | GT
    ;

/*循环结构*/

loop
    : DO LBRACE statements RBRACE WHILE LPAREN boolexp RPAREN
    | WHILE LPAREN boolexp RPAREN LBRACE statements RBRACE
    | FOR LPAREN sequence SEMICOLON boolexp SEMICOLON sequence RPAREN LBRACE statements RBRACE
    ;
