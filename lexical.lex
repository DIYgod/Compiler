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


void adjust(void)           //计算单词位置, 并通过EM_tokPos传给错误信息模块
{
    EM_tokPos=charPos;
    charPos+=yyleng;
}

%}

%%
[" ""\t"]                   {adjust(); continue;}
"\n"                        {adjust(); EM_newline(); continue;}
\"(A-Za-z0-9)*\"            {adjust(); yylval.sval = yytext; return STRING_V;}
string                      {adjust(); return STRING;}
\'[A-Za-z0-9]\'             {adjust(); yylval.cval = yytext[0]; return CHAR_V;}
char                        {adjust(); return CHAR_V;}
short                       {adjust(); EM_error(EM_tokPos, "暂不支持short类型");}
-?[0-9]+                    {adjust(); yylval.ival=atoi(yytext); return INT_V;}
int                         {adjust(); return INT;}
unsigned                    {adjust(); EM_error(EM_tokPos, "暂不支持unsigned类型");}
long                        {adjust(); EM_error(EM_tokPos, "暂不支持long类型");}
float                       {adjust(); EM_error(EM_tokPos, "暂不支持float类型");}
-?[0-9]+(.[0-9]+)?          {adjust(); yylval.dval = atof(yytext); return DOUBLE_V;}
do                          {adjust(); return DO;}
double                      {adjust(); return DOUBLE;}
struct                      {adjust(); return STRUCT;}
union                       {adjust(); return UNION;}
void                        {adjust(); return VOID;}
enum                        {adjust(); return ENUM;}
signed                      {adjust(); EM_error(EM_tokPos, "暂不支持signed类型");}
conust                      {adjust(); return CONUST;}
volatile                    {adjust(); EM_error(EM_tokPos, "暂不支持volatile");}
typedef                     {adjust(); return TYPEDEF;}
auto                        {adjust(); EM_error(EM_tokPos, "暂不支持auto");}
register                    {adjust(); EM_error(EM_tokPos, "暂不支持register");}
static                      {adjust(); return STATIC;}
extern                      {adjust(); return EXTERN;}
break                       {adjust(); return BREAK;}
case                        {adjust(); return CASE;}
continue                    {adjust(); return CONTINUE;}
default                     {adjust(); return DEFAULT;}
else                        {adjust(); return ELSE;}
for                         {adjust(); return FOR;}
goto                        {adjust(); return GOTO;}
if                          {adjust(); return IF;}
return                      {adjust(); return RETURN;}
switch                      {adjust(); return SWITCH;}
while                       {adjust(); return WHILE;}
sizeof                      {adjust(); return SIZEOF;}
(A-Za-z)+\[(0-9)+\]         {adjust(); return ARRAY;}
([A-Za-z_](A-Za-z0-9_)*)    {adjust(); return ID;}
","                         {adjust(); return COMMA;}
":"                         {adjust(); return COLON;}
";"                         {adjust(); return SEMICOLON;}
"("                         {adjust(); return LPAREN;}
")"                         {adjust(); return RPAREN;}
"["                         {adjust(); return LBRACK;}
"]"                         {adjust(); return RBRACK;}
"{"                         {adjust(); return LBRACE;}
"}"                         {adjust(); return RBRACE;}
"."                         {adjust(); return DOT;}
"+"                         {adjust(); return PLUS;}
"-"                         {adjust(); return MINUS;}
"*"                         {adjust(); return TIMES;}
"/"                         {adjust(); return DIVIDE;}
"!="                        {adjust(); return NEQ;}
"=="                        {adjust(); return ASSIGN;}
"="                         {adjust(); return EQ;}
"<="                        {adjust(); return LE;}
"<"                         {adjust(); return LT;}
">="                        {adjust(); return GE;}
">"                         {adjust(); return GT;}
"&"                         {adjust(); return AND;}
"|"                         {adjust(); return OR;}
