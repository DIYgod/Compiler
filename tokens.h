/*
 * 词法单词常量以及yylval的定义
 */

typedef union  {
	int pos;
	int ival;
    char cval;
    double dval;
	string sval;
	} YYSTYPE;
extern YYSTYPE yylval;          //与单词关联的语义值

/*
 * 128-185, 全部用8位二进制数表示
 */
# define ID 128                 //变量名
# define STRING 129
# define COMMA 130              //,
# define COLON 131              //:
# define SEMICOLON 132          //;
# define LPAREN 133             //()
# define RPAREN 134
# define LBRACK 135             //[]
# define RBRACK 136
# define LBRACE 137             //{}
# define RBRACE 138
# define DOT 139                //.
# define PLUS 140               //+-*/
# define MINUS 141
# define TIMES 142
# define DIVIDE 143
# define EQ 144                 //=
# define NEQ 145                //!=
# define LT 146                 //<
# define LE 147                 //<=
# define GT 148                 //>
# define GE 149                 //>=
# define AND 150                //&
# define OR 151                 //|
# define ASSIGN 152             //==
# define ARRAY 153              //a[]
# define CHAR 154
# define SHORT 155
# define INT 156
# define UNSIGNED 157
# define LONG 158
# define FLOAT 159
# define DOUBLE 160
# define STRUCT 161
# define UNION 162
# define VOID 163
# define ENUM 164
# define SIGNED 165
# define CONUST 166
# define VOLATILE 167
# define TYPEDEF 168
# define AUTO 169
# define REGISTER 170
# define STATIC 171
# define EXTERN 172
# define BREAK 173
# define CASE 174
# define CONTINUE 175
# define DEFAULT 176
# define DO 177
# define ELSE 178
# define FOR 179
# define GOTO 180
# define IF 181
# define RETURN 182
# define SWITCH 183
# define WHILE 184
# define SIZEOF 185
# define STRING_V 186
# define INT_V 187
# define CHAR_V 188
# define DOUBLE_V 189
