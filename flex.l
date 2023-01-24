%{
int line_count=1;
%}

/*Defination of tokens*/
PRE_PROCESS_DIRECTIVE [#]"include"[^\n]*
MACRO [#]"define"[^\n]*
IDENTIFIER [_a-zA-Z0-9]
SINGLE_LINE_COMMENT "//"[^\n]* 
MULTILINE_LINE_COMMENT "/*"[^\n]*"*/"
DIGIT [_a-zA-Z0-9]
WHITESPACES [\r\t ]
NEWLINE [\n]
OPERATORS "++"|"+"|--|-|"*"|"/"|%|=|==|"+="|-=|"/="|"*="|>=|<=|!|!=|<|>|&|&&|^|~|<<|>>|"|"|"||"|->|"["{DIGIT}+"]"|"."
KEYWORDS asm|auto|bool|break|case|catch|char|class|const|const_cast|continue|default|delete|do|double|dynamic_cast|else|enum|extern|explicit|export|float|for|false|friend|goto|if|inline|int|long|mutable|namespace|new|operator|private|protected|public|register|return|reinterpret_cast|short|signed|sizeof|static|static_cast|struct|switch|template|this|throw|true|try|typeid|typedef|union|unsigned|using|virtual|void|volatile|wchar_t|cout|cin|while|std
PUNCTUATIONS ["]|#|$|%|&|,|-|:|;|"?"|@|"["|]|^|_|`|"{"|"}"|~|"("|")"

/*RULES*/
%%
{WHITESPACES} {/*skip whitespaces*/}
{PRE_PROCESS_DIRECTIVE} {fprintf(yyout,"line no:%d\tPreProcess\n\t\t\tDirective    \t%s\n",line_count,yytext);}
{MACRO} {fprintf(yyout,"line no:%d\tMACRO    \t\t%s\n",line_count,yytext);}
{SINGLE_LINE_COMMENT} {fprintf(yyout,"line no:%d\tcomment    \t\t%s\n",line_count,yytext);}
{MULTILINE_LINE_COMMENT} {fprintf(yyout,"line no:%d\tcomment    \t\t%s\n",line_count,yytext);}
{KEYWORDS} {fprintf(yyout,"line no:%d\tkeyword    \t\t%s\n",line_count,yytext);}
{IDENTIFIER}+ {fprintf(yyout,"line no:%d\tidentifier \t\t%s\n",line_count,yytext);}
{OPERATORS} {fprintf(yyout,"line no:%d\toperator   \t\t%s\n",line_count,yytext);}
{PUNCTUATIONS} {fprintf(yyout,"line no:%d\tpunctuation\t\t%s\n",line_count,yytext);}
{NEWLINE} {line_count++;}
%%

int yywrap(){
    printf("Output.txt generated successfully\n");
    return 1;
}
int main(){
//NAME: BETA TOKENIZER
//GROUP MEMBERS
//2021468 Muhammad Talha Imtiaz
//2021276 Mahnoor Amir
//2021446 Muhammad Saadullah

//Creating file pointers
extern FILE *yyin,*yyout;

//yyin ptr reads from input.txt
//yyout ptr reads from output.txt
yyin = fopen("input.cpp","r");
yyout = fopen("output.txt", "w");

//fprintf() is used to print/write into file
fprintf(yyout,"-----------------------------------------\n");
fprintf(yyout,"Line No  \tToken Type\t\tLexeme\n");
fprintf(yyout,"-----------------------------------------\n");

//driving funcition to go through input and give required output
yylex();



return 0;
}


