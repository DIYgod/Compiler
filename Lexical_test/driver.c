#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"

YYSTYPE yylval;

int yylex(void); /* prototype for the lexing function */



string toknames[] = {
    "ID", "STRING", "COMMA", "COLON", "SEMICOLON", "LPAREN",
    "RPAREN", "LBRACK", "RBRACK", "LBRACE", "RBRACE", "DOT", "PLUS",
    "MINUS", "TIMES", "DIVIDE", "EQ", "NEQ", "LT", "LE", "GT", "GE",
    "AND", "OR", "ASSIGN", "ARRAY", "CHAR", "SHORT", "INT", "UNSIGNED",
    "LONG", "FLOAT", "DOUBLE", "STRUCT", "UNION", "VOID", "ENUM",
    "SIGNED", "CONUST", "VOLATILE", "TYPEDEF", "AUTO", "REGISTER",
    "STATIC", "EXTERN", "BREAK", "CASE", "CONTINUE", "DEFAULT",
    "DO", "ELSE", "FOR", "GOTO", "IF", "RETURN", "SWITCH", "WHILE", "SIZEOF",
    "STRING_V", "INT_V", "CHAR_V", "DOUBLE_V"
};


string tokname(tok)
{
    return tok<128 || tok>189 ? "BAD_TOKEN" : toknames[tok-128];
}

int main(int argc, char **argv)
{
    string fname;
    int tok;
    if (argc!=2)
    {
        fprintf(stderr,"usage: a.out filename\n");
        exit(1);
    }
    fname=argv[1];
    EM_reset(fname);            //初始化
    while(1)
    {
        tok=yylex();            //读取单词
        if (tok==0)
            break;
        switch(tok)
        {
            case ID:
            case STRING_V:
                printf("%2d %10s %s\n", EM_tokPos, tokname(tok), yylval.sval);
                break;
            case INT_V:
                printf("%2d %10s %d\n", EM_tokPos, tokname(tok), yylval.ival);
                break;
            case CHAR_V:
                printf("%2d %10s %c\n", EM_tokPos, tokname(tok), yylval.cval);
                break;
            case DOUBLE_V:
                printf("%2d %10s %f\n", EM_tokPos, tokname(tok), yylval.dval);
                break;
            default:
                printf("%2d %10s \n", EM_tokPos, tokname(tok));
        }
    }
    return 0;
}


