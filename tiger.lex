%{
#include <string.h>
#include "util.h"
#include "tokens.h"
#include "errormsg.h"

int charPos=1;              //记录每个单词的位置

int yywrap(void)            //Lex函数, 返回1就停止解析, 可以用来解析多个文件
{
    charPos=1;
    return 1;
}


void adjust(void)           //计算单词位置, 并告知错误信息模块
{
    EM_tokPos=charPos;
    charPos+=yyleng;
}

%}

%%
[" "\t]                     {adjust(); continue;}
\n                          {adjust(); EM_newline(); continue;}
.                           {adjust(); EM_error(EM_tokPos,"illegal token");}
([A-Za-z_](A-Za-z0-9_)*)    {adjust(); return ID;}
\"[A-Za-z]\"                {adjust(); yylval.sval = yytext; return STRING;}
,                           {adjust(); return COMMA;}

[0-9]+                      {adjust(); yylval.ival = atoi(yytext); return INT;}
