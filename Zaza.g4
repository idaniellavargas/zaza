grammar Zaza;


programa        : (clase | funcion | declaracion_var | expr)* EOF;

clase           : 'clase' ID 'empieza' ID cuerpo_clase 'fin' ID;
cuerpo_clase    : (declaracion_var | funcion )*
                clase_constructor
                (declaracion_var | funcion )*
;

clase_constructor: funcion;

funcion         : 'proceso' ID '(' parametros? ')' 'empieza' ID cuerpo_funcion 'fin' ID;
cuerpo_funcion  : (declaracion_var | expr)*;

parametros      : parametro (',' parametro)*;
parametro       : tipo_dato ID;

declaracion_var : tipo_dato ID ('=' expr)?;

tipo_dato       : 'numero' | 'caracter' | 'texto' | 'booleano';

condicional:
                'si' expr 'entonces' expr* 
                ('sino' expr*)?
                'fin' 'si'
                ;
                
bucle:
                'bucle' (bucle_while | bucle_repeticion)  'entonces' expr* 'fin' 'bucle'
                ;
bucle_while:
                'mientras' expr 
                ;
    
bucle_repeticion:
                'repetir' NUMERO
                ;


expr            : asignacion               
                | expr operador expr
                | declaracion_var
                | llamada_funcion          
                | valor                   
                |  '(' expr ')'      
                | condicional
                | bucle
                | mostrar
                ;
                
// funciones basicas
mostrar:
                'mostrar' '(' (expr (',' expr)*)? ')'
                ;

asignacion      : ID '=' expr; 

operador        : '+' | '-' | '*' | '/' | '==' | '!=' | '<' | '>' | '<=' | '>=';

llamada_funcion : ID '(' argumentos? ')';
argumentos      : expr (',' expr)*;

valor           : NUMERO | CARACTER | TEXTO | BOOLEANO | ID;

ID              : [a-zA-Z_][a-zA-Z0-9_]*;
NUMERO          : [0-9]+;
CARACTER        : '\'' [a-zA-Z] '\'';
TEXTO           : '"' .*? '"';
BOOLEANO        : 'True' | 'False';

WS              : [ \t\r\n]+ -> skip;
