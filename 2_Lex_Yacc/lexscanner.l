/*** Definition ***/
%{
    #include <string.h>
    #include <stdio.h>

    typedef struct {
        char symbol[100];
        int position;
    } SymbolTable;
    SymbolTable symboltable[50];
    int symbolcount = 0;

    typedef struct {
        char token[50];
        int position;
    } PIFTable;

    PIFTable piftable[100];
    int pifindex = 0;
    
    int addToST(char* symbol) {
        for (int i = 0; i < symbolcount; i++){
            if (strcmp(symboltable[i].symbol, symbol) == 0){
                return symboltable[i].position;

            }
        }
    

        symboltable[symbolcount].position = symbolcount + 1;
        strcpy(symboltable[symbolcount].symbol, symbol);
        symbolcount++;
        return symbolcount;
    }

    void addToPIF(char* token, int position){
        strcpy(piftable[pifindex].token, token);
        piftable[pifindex].position = position;
        pifindex++;
    }
    extern int yylineno;
    #define YY_NO_UNPUT
    #define YY_NO_INPUT

%}

DIGIT [0-9]+
IDENTIFIER [a-zA-Z][a-zA-Z0-9_]*

%%
[\n] {yylineno++;}
[ \t\r]+    ; // Whitespace
"program"   {addToPIF("program", 0);} 
"var"|"IF"|"WHILE"|"begin"|"end"    {addToPIF(yytext, 0);}
"true"|"false"  {int pos = addToST(yytext); addToPIF("CONST", pos);}
{DIGIT} {int pos = addToST(yytext); addToPIF("CONST", pos);}
{IDENTIFIER}    {int pos = addToST(yytext); addToPIF("ID", pos);}
"+"|"-"|"*"|"/"|"="|"<"|">" {addToPIF(yytext, 0);}
";"|":"|"{"|"}"|"("|")" {addToPIF(yytext, 0);}
.   {printf("Lexical error at line %d: Invalid token '%c' (ASCII: %d)\n", yylineno, yytext[0], yytext[0]);}
%%

int yywrap() {return 1;}

int main(int argc, char** argv) {
    if (argc != 2) {
        printf("Usage: %s <source_file>\n", argv[0]);
        return 1;
    }
    FILE* source_file = fopen(argv[1], "r");
    if(!source_file) {
        perror("Failed to open file");
        return 1;
    }
    yyin = source_file;
    yylex();

        // Print PIF
    printf("\nProgram Internal Form (PIF):\n");
    printf("+----------------+----------+\n");
    printf("| Token          | Position |\n");
    printf("+----------------+----------+\n");
    for (int i = 0; i < pifindex; i++) {
        printf("| %-14s | %-8d |\n", piftable[i].token, piftable[i].position);
    }
    printf("+----------------+----------+\n");

    // Print Symbol Table
    printf("\nSymbol Table:\n");
    printf("+----------------+----------+\n");
    printf("| Symbol         | Position |\n");
    printf("+----------------+----------+\n");
    for (int i = 0; i < symbolcount; i++) {
        printf("| %-14s | %-8d |\n", symboltable[i].symbol, symboltable[i].position);
    }
    printf("+----------------+----------+\n");

    fclose(source_file);
    return 0;

}