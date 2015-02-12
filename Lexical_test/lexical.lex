%{
#include <string.h>
#include "util.h"
#include "tokens.h"
#include "errormsg.h"
//#include "yy.tab.h"

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
"/*"([*]*(([^*/])+([/])*)*)*"*/"    {adjust();}         //匹配注释
"//"([^"\n"])*              {adjust();}
[" ""\t"]                   {adjust();}
"\n"                        {adjust(); EM_newline();}
(\")([A-Za-z0-9])*(\")      {adjust(); yylval.sval = yytext; return STRING_V;}
string                      {adjust(); return STRING;}
'[A-Za-z0-9]'               {adjust(); yylval.cval = yytext[1]; return CHAR_V;}
char                        {adjust(); return CHAR;}
short                       {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
-?[0-9]+                    {adjust(); yylval.ival=atoi(yytext); return INT_V;}
int                         {adjust(); return INT;}
unsigned                    {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
long                        {adjust(); EM_error(EM_tokPos, "");}
float                       {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
-?[0-9]+(\.[0-9]+)?         {adjust(); yylval.dval = atof(yytext); return DOUBLE_V;}
do                          {adjust(); return DO;}
double                      {adjust(); return DOUBLE;}
struct                      {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
union                       {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
void                        {adjust(); return VOID;}
enum                        {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
signed                      {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
conust                      {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
volatile                    {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
typedef                     {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
auto                        {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
register                    {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
static                      {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
extern                      {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
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
sizeof                      {adjust(); EM_error(EM_tokPos, "Sorry, this word are not supported.");}
[A-Za-z]+\[[0-9]+\]         {adjust(); return ARRAY;}
[A-Za-z_]([A-Za-z0-9_])*    {adjust(); yylval.sval = yytext; return ID;}
"+="                        {adjust(); return PLUSASSIGN;}
"-="                        {adjust(); return MINUSASSIGN;}
"*="                        {adjust(); return TIMESASSIGN;}
"/="                        {adjust(); return DIVIDE;}
"!="                        {adjust(); return NEQ;}
"<="                        {adjust(); return LE;}
">="                        {adjust(); return GE;}
"=="                        {adjust(); return ASSIGN;}
"++"                        {adjust(); return INC;}
"--"                        {adjust(); return DEC;}
"&&"                        {adjust(); return AND;}
"||"                        {adjust(); return OR;}
","                         {adjust(); return COMMA;}
":"                         {adjust(); return COLON;}
";"                         {adjust(); return SEMICOLON;}
"("                         {adjust(); return LPAREN;}
")"                         {adjust(); return RPAREN;}
"["                         {adjust(); return LBRACK;}
"]"                         {adjust(); return RBRACK;}
"{"                         {adjust(); return LBRACE;}
"}"                         {adjust(); return RBRACE;}
"."                         {adjust(); EM_error(EM_tokPos, "Bad character");}
"+"                         {adjust(); return PLUS;}
"-"                         {adjust(); return MINUS;}
"*"                         {adjust(); return TIMES;}
"/"                         {adjust(); return DIVIDE;}
"="                         {adjust(); return EQ;}
"<"                         {adjust(); return LT;}
">"                         {adjust(); return GT;}
"!"                         {adjust(); return NOT;}
"%"                         {adjust(); return MOD;}
