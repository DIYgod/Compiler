/*
 * 报错信息模块, 用于产生含文件名和行号的报错信息
 */

extern bool EM_anyErrors;

void EM_newline(void);

extern int EM_tokPos;

void EM_error(int, string,...);
void EM_impossible(string,...);
void EM_reset(string filename);
