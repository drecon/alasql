/*
//
// alasqlparser.jison
// SQL Parser for Alasql.js
// Date: 03.11.2014
// Modified: 20.11.2014
// (c) 2014, Andrey Gershun
//
*/

%lex
%options case-insensitive
%%

\[\?\]							return 'BRAQUESTION'
'@['							return 'ATLBRA'
\[([^\]])*?\]					return 'BRALITERAL'
/*								{
									console.log(this.matched);
									if((this.matched+"").substr(0,6).toUpperCase() == 'ASSERT') {
										//this.less(2);
										return 'LBRA';
									} else {
										return 'BRALITERAL'
									}
								}
*/
\`([^\]])*?\`	   								 return 'BRALITERAL'
(['](\\.|[^']|\\\')*?['])+                       return 'STRING'
(["](\\.|[^"]|\\\")*?["])+                       return 'STRING'

\/\*(.*?)\*\/									return /* skip comments */

/*

\/\*											
\*\/											

*/
"--"(.*?)($|\r\n|\r|\n)							return /* return 'COMMENT' */

\s+                                             /* skip whitespace */
'||'											return 'OR'
'&&'											return 'AND'
'ABSOLUTE'                                 		return 'ABSOLUTE'
'ACTION'                                      	return 'ACTION'
'ADD'                                      		return 'ADD'
'AGGR'                                     		return 'AGGR'
'ALL'                                      		return 'ALL'
'ALTER'                                    		return 'ALTER'
'AND'											return 'AND'
'ANTI'											return 'ANTI'
'ANY'											return 'ANY'
'APPLY'											return 'APPLY'
'ARRAY'                                     	return 'ARRAY'
'AS'                                      		return 'AS'
'ASSERT'                                      	return 'ASSERT'
'ASC'                                      		return 'DIRECTION'
'ATTACH'                                      	return 'ATTACH'
'AUTO_INCREMENT'                                return 'AUTO_INCREMENT'
/* 'AUTOCOMMIT'									return 'AUTOCOMMIT'; */
'AVG'                                      		return 'AVG'

'BEGIN'											return 'BEGIN'
'BETWEEN'										return 'BETWEEN'
'BREAK'											return 'BREAK'
'NOT BETWEEN'									return 'NOT_BETWEEN'
'BY'											return 'BY'

'CASE'											return 'CASE'
'CAST'											return 'CAST'
'CHARSET'										return 'CHARSET'
'CLOSE'											return 'CLOSE'
'COLLATE'										return 'COLLATE'
"COLUMN"										return "COLUMN"
"COLUMNS"										return "COLUMNS"
"COMMIT"										return "COMMIT"
"CONSTRAINT"									return "CONSTRAINT"
"CONTINUE"										return "CONTINUE"
"CONVERT"										return "CONVERT"
"COUNT"											return "COUNT"
'CREATE'										return 'CREATE'
"CROSS"											return "CROSS"
'CUBE'											return 'CUBE'
"CURSOR"										return "CURSOR"
'DATABASE'										return 'DATABASE'
'DATABASES'										return 'DATABASES'
'DECLARE'                                       return 'DECLARE'
'DEFAULT'                                       return 'DEFAULT'
'DELETE'                                        return 'DELETE'
'DESC'                                          return 'DIRECTION'
'DETACH'										return 'DETACH'
'DISTINCT'                                      return 'DISTINCT'
'DROP'											return 'DROP'

'END'											return 'END'
'ENGINE'										return 'ENGINE'
'ENUM'											return 'ENUM'
'ELSE'											return 'ELSE'
'EXCEPT'										return 'EXCEPT'
'EXISTS'										return 'EXISTS'
'EXPLAIN'                                       return 'EXPLAIN'
'FALSE'											return 'FALSE'
'FETCH'											return 'FETCH'
'FIRST'											return 'FIRST'
'FOREIGN'										return 'FOREIGN'
'FROM'                                          return 'FROM'
'GO'                                      		return 'GO'
'GROUP'                                      	return 'GROUP'
'GROUPING'                                     	return 'GROUPING'
'HAVING'                                        return 'HAVING'
'HELP'											return 'HELP'
'IF'											return 'IF'
'IDENTITY'										return 'IDENTITY'
'IS'											return 'IS'
'IN'											return 'IN'
'INDEX'											return 'INDEX'
'INNER'                                         return 'INNER'
'INSERT'                                        return 'INSERT'
'INTERSECT'                                     return 'INTERSECT'
'INTO'                                         	return 'INTO'
'JOIN'                                         	return 'JOIN'
/*
'JSON'                                         	return 'JSON'
*/
'KEY'											return 'KEY'
'LAST'											return 'LAST'
'LEFT'											return 'LEFT'
'LIKE'											return 'LIKE'
'LIMIT'											return 'LIMIT'
'SOURCE'										return 'SOURCE'
'MATRIX'										return 'MATRIX'	
"MAX"											return "MAX"
"MIN"											return "MIN"
"MINUS"											return "EXCEPT"
"MODIFY"										return "MODIFY"
'NATURAL'										return 'NATURAL'
'NEXT'											return 'NEXT'
'NEW'											return 'NEW'
'NOCASE'										return 'NOCASE'
'NO'											return 'NO'
'NOT'											return 'NOT'
'NULL'											return 'NULL'
'OFF'											return 'OFF'
'ON'											return 'ON'
'OFFSET'										return 'OFFSET'
'OPEN'											return 'OPEN'
'OR'											return 'OR'
'ORDER'	                                      	return 'ORDER'
'OUTER'											return 'OUTER'
'OVER'											return 'OVER'
'PARTITION'										return 'PARTITION'
'PERCENT'                                       return 'PERCENT'
'PLAN'                                        	return 'PLAN'
'PRIMARY'										return 'PRIMARY'
'PRINT'                                        	return 'PRINT'
'PRIOR'                                        	return 'PRIOR'
'QUERY'                                        	return 'QUERY'
'RECORDSET'                                     return 'RECORDSET'
'REDUCE'                                        return 'REDUCE'
'REFERENCES'                                    return 'REFERENCES'
'RELATIVE'                                      return 'RELATIVE'
'RENAME'                                        return 'RENAME'
'REQUIRE'                                       return 'REQUIRE'
'RESTORE'                                       return 'RESTORE'
'RIGHT'                                        	return 'RIGHT'
'ROLLBACK'										return 'ROLLBACK'
'ROLLUP'										return 'ROLLUP'
'ROW'											return 'ROW'
'SCHEMA'                                        return 'DATABASE'
'SCHEMAS'                                       return 'DATABASES'
'SELECT'                                        return 'SELECT'
'SEMI'                                        	return 'SEMI'
'SET'                                        	return 'SET'
'SETS'                                        	return 'SETS'
'SHOW'                                        	return 'SHOW'
'SOME'                                        	return 'SOME'
'STORE'                                        	return 'STORE'
"SUM"											return "SUM"
'TABLE'											return 'TABLE'
'TABLES'										return 'TABLES'
'TEXT'											return 'TEXT'
'THEN'											return 'THEN'
'TO'											return 'TO'
'TOP'											return 'TOP'
'TRAN'											return 'TRAN'
'TRANSACTION'									return 'TRANSACTION'
'TRUE'						  					return 'TRUE'
'UNION'                                         return 'UNION'
'UNIQUE'                                        return 'UNIQUE'
'UPDATE'                                        return 'UPDATE'
'USE'											return 'USE'
'USING'                                         return 'USING'
'VALUE'                                        	return 'VALUE'
'VALUES'                                        return 'VALUES'
'VIEW'											return 'VIEW'
'WHEN'                                          return 'WHEN'
'WHERE'                                         return 'WHERE'
'WHILE'                                         return 'WHILE'

/*
[0-9]+											return 'NUMBER'
[0-9]+\.[0-9]*									return 'NUMBER'
*/
(\d*[.])?\d+									return 'NUMBER'

'->'											return 'ARROW'
'+'												return 'PLUS'
'-' 											return 'MINUS'
'*'												return 'STAR'
'/'												return 'SLASH'
'%'												return 'MODULO'
'!==='											return 'NEEQEQEQ'
'==='											return 'EQEQEQ'
'!=='											return 'NEEQEQ'
'=='											return 'EQEQ'
'>='											return 'GE'
'>'												return 'GT'
'<='											return 'LE'
'<>'											return 'NE'
'<'												return 'LT'
'='												return 'EQ'
'!='											return 'NE'
'('												return 'LPAR'
')'												return 'RPAR'

'@'												return 'AT'

'{'												return 'LCUR'
'}'												return 'RCUR'

/* '['												return 'LBRA' */
']'												return 'RBRA'

'.'												return 'DOT'
','												return 'COMMA'
':'												return 'COLON'
';'												return 'SEMICOLON'
'$'												return 'DOLLAR'
'?'												return 'QUESTION'
'^'												return 'CARET'


[a-zA-Z_][a-zA-Z_0-9]*                       	return 'LITERAL'

/*
[a-zA-ZА-Яа-я_][a-zA-ZА-Яа-я_0-9]*              return 'LITERAL'
*/
<<EOF>>               							return 'EOF'
.												return 'INVALID'

/lex
%left If
%left COMMA
%left OR
%left BETWEEN NOT_BETWEEN
%left AND
%left GT GE LT LE EQ NE EQEQ NEEQEQ EQEQEQ NEEQEQEQ
%left IN
%left NOT
%left IS
%left LIKE
%left PLUS MINUS
%left STAR SLASH MODULO
%left CARET
%left DOT ARROW
/* %left UMINUS */

%start main

%%

Literal
	: LITERAL
		{
			if (yy.casesensitive) $$ = $1;
			else $$ = $1.toLowerCase();
		}
	| BRALITERAL
		{ $$ = doubleq($1.substr(1,$1.length-2)); }
	;

main
	: Statements EOF
		{ return new yy.Statements({statements:$1}); }
	;

Statements
	: Statements SEMICOLON Statement
		{ $$ = $1; if($3) $1.push($3); }
	| Statements GO Statement
		{ $$ = $1; if($3) $1.push($3); }
	| Statement
		{ $$ = [$1]; }
	| ExplainStatement
		{ $$ = [$1]; }
	;

ExplainStatement
	: EXPLAIN Statement
		{ $$ = $2; $2.explain = true; }
	| EXPLAIN QUERY PLAN Statement
		{ $$ = $4;  $4.explain = true;}
	;

Statement
	: { $$ = undefined; }
	| If
	| AlterTable	
	| AttachDatabase	
	| CreateDatabase
	| CreateIndex
	| CreateTable
	| CreateView
	| Declare
	| Delete
	| DetachDatabase
	| DropDatabase
	| DropIndex
	| DropTable
	| DropView
	| Insert
	| RenameTable
	| Select
	| ShowCreateTable
	| ShowColumns
	| ShowDatabases
	| ShowIndex
	| ShowTables
	| BeginTransaction
	| CommitTransaction
	| RollbackTransaction
	| EndTransaction
	| UseDatabase
	| Update
	| Help

	| Source
	| Assert
	| While
	| Continue
	| Break
	| BeginEnd
	| Print
	| Require
	| SetVariable

/*
	| ExpressionStatement 
	| Store
	| Restore

	| DeclareCursor
	| OpenCursor
	| FetchCursor
	| CloseCursor
*/


/*	
	| CreateTrigger
	| DropTrigger
	| SavePoint
	| Reindex
	| StoreDatabase
	| StoreTable
	| RestoreDatabase
	| RestoreTable

	| IfElse
	| BeginEnd
	| While
	| BulkInsert

	| Declare
	| CreateFunction
	| CreateProcedure
	| Loop
	| ForLoop
*/
	;

/* WITH */

WithSelectClause
	: WITH WithTables Select
		{ $$ = $3; }
	| WITH RECURSIVE WithTables Select
		{ $$ = $4; }
	| Select
		{ $$ = $1;}
	;

WithTables :;

/* SELECT */

Select
	: SelectClause IntoClause FromClause WhereClause GroupClause OrderClause LimitClause UnionClause 
		{   yy.extend($$,$1); yy.extend($$,$2); yy.extend($$,$3); yy.extend($$,$4); 
		    yy.extend($$,$5); yy.extend($$,$6);yy.extend($$,$7); 
		    yy.extend($$,$8); 
		    $$ = $1;
		    if(yy.exists) $$.exists = yy.exists;
		    delete yy.exists;
		    if(yy.queries) $$.queries = yy.queries;
			delete yy.queries;
		}
/*	| SELECT NumValue
		{ $$ = new yy.Select({value: $2}); }
*/	;

SelectClause
	: SelectModifier DISTINCT TopClause ResultColumns  
		{ $$ = new yy.Select({ columns:$4, distinct: true }); yy,extend($$, $1); yy.extend($$, $3); }
	| SelectModifier UNIQUE TopClause ResultColumns  
		{ $$ = new yy.Select({ columns:$4, distinct: true }); yy,extend($$, $1);yy.extend($$, $3); }
	| SelectModifier  ALL TopClause ResultColumns  
		{ $$ = new yy.Select({ columns:$4, all:true }); yy,extend($$, $1);yy.extend($$, $3); }
	| SelectModifier TopClause ResultColumns  
		{ $$ = new yy.Select({ columns:$3 }); yy,extend($$, $1);yy.extend($$, $2); }
/*	| 
		{ $$ = new yy.Select({columns:[new yy.Column({columnid:'_', modifier:'COLUMN'})]});}
*/	;

SelectModifier
	: SELECT
		{ $$ = null}
	| SELECT VALUE
		{ $$ = {modifier:'VALUE'}}
	| SELECT ROW
		{ $$ = {modifier:'ROW'}}
	| SELECT COLUMN
		{ $$ = {modifier:'COLUMN'}}
	| SELECT MATRIX
		{ $$ = {modifier:'MATRIX'}}
	| SELECT TEXT
		{ $$ = {modifier:'TEXT'}}
	| SELECT INDEX
		{ $$ = {modifier:'INDEX'}}
	| SELECT RECORDSET
		{ $$ = {modifier:'RECORDSET'}}
	;

TopClause
	: TOP NumValue  
		{ $$ = {top: $2}; }
	| TOP LPAR NumValue RPAR
		{ $$ = {top: $3}; }
	| TOP NumValue PERCENT  
		{ $$ = {top: $2, percent:true}; }
	| { $$ = null; }
	;

IntoClause
	: {$$ = null}
	| INTO Table
		{$$ = {into: $2} }
	| INTO FuncValue
		{$$ = {into: $2} }
	| INTO ParamValue
		{$$ = {into: $2} }
	| INTO VarValue
		{$$ = {into: $2} }
	;

FromClause
	: FROM FromTablesList
		{ $$ = { from: $2 }; } 
	| FROM FromTable JoinTablesList
		{ $$ = { from: [$2], joins: $3 }; }
	|
		{ $$ = null; }
	;

ApplyClause
	: CROSS APPLY LPAR Select RPAR Literal
		{ $$ = new yy.Apply({select: $4, apply:'CROSS', as:$6}); }
	| CROSS APPLY LPAR Select RPAR AS Literal
		{ 
			if(!yy.exists) yy.exists = [];
			$$ = new yy.Apply({select: $4, apply:'CROSS', as:$7,existsidx:yy.exists.length});
			yy.exists.push($3);

		 }
	| OUTER APPLY LPAR Select RPAR Literal
		{ $$ = new yy.Apply({select: $4, apply:'OUTER', as:$6}); }
	| OUTER APPLY LPAR Select RPAR AS Literal
		{ $$ = new yy.Apply({select: $4, apply:'OUTER', as:$7}); }
	;

FromTablesList
	: FromTable
		{ $$ = [$1]; }
	| FromTablesList COMMA FromTable
		{ $$ = $1; $1.push($3); }
	;

FromTable
	: LPAR Select RPAR Literal
		{ $$ = $2; $$.as = $4 }	
	| LPAR Select RPAR AS Literal
		{ $$ = $2; $$.as = $5 }	
	| LPAR Select RPAR /* default alias */
		{ $$ = $2; $$.as = 'default' }	

	| Table Literal
		{ $$ = $1; $1.as = $2 }
	| Table AS Literal
		{ $$ = $1; $1.as = $3 }
	| Table 
		{ $$ = $1; }

	| ParamValue Literal 
		{ $$ = $1; $1.as = $2; }
	| ParamValue AS Literal 
		{ $$ = $1; $1.as = $3; }
	| ParamValue
		{ $$ = $1; $1.as = 'default'; }

	| FuncValue
		{ $$ = $1; $1.as = 'default'; }
	| FuncValue Literal
		{ $$ = $1; $1.as = $2; }
	| FuncValue AS Literal
		{ $$ = $1; $1.as = $3; }

	| VarValue
		{ $$ = $1; $1.as = 'default'; }
	| VarValue Literal
		{ $$ = $1; $1.as = $2; }
	| VarValue AS Literal
		{ $$ = $1; $1.as = $3; }
	;

Table
	: Literal DOT Literal
		{ $$ = new yy.Table({databaseid: $1, tableid:$3});}
	| Literal
		{ $$ = new yy.Table({tableid: $1});}
	;

JoinTablesList
	: JoinTablesList JoinTable
		{ $$ = $1; $1.push($2); } 
	| JoinTablesList ApplyClause
		{ $$ = $1; $1.push($2); } 
	| JoinTable
	 	{ $$ = [$1]; }
	| ApplyClause
	 	{ $$ = [$1]; }
	;

JoinTable
	: JoinMode JoinTableAs OnClause
		{ $$ = new yy.Join($1); yy.extend($$, $2); yy.extend($$, $3); }
	;

JoinTableAs
	: Table
		{ $$ = {table: $1}; }
	| Table Literal
		{ $$ = {table: $1, as: $2 } ; }
	| Table AS Literal
		{ $$ = {table: $1, as: $3 } ; }
	| ParamValue Literal
		{ $$ = {param: $1, as: $2 } ; }
	| ParamValue AS Literal
		{ $$ = {param: $1, as: $3 } ; }
	| LPAR Select RPAR Literal
		{ $$ = {select: $1, as: $4} ; }
	| LPAR Select RPAR AS Literal
		{ $$ = {select: $1, as: $5 } ; }
	| FuncValue
		{ $$ = {func:$1, as:'default'}; }
	| FuncValue Literal
		{ $$ = {func:$1, as: $2}; }
	| FuncValue AS Literal
		{ $$ = {func:$1, as: $3}; }

	| VarValue
		{ $$ = {variable:$1,as:'default'}; }
	| VarValue Literal
		{ $$ = {variable:$1,as:$2}; }
	| VarValue AS Literal
		{ $$ = {variable:$1,as:$3} }
	;

JoinMode
	: JoinModeMode
		{ $$ = { joinmode: $1 } ; }
	| NATURAL JoinModeMode
		{ $$ = {joinmode: $1, natural:true} ; }
	;

JoinModeMode
	: JOIN 
		{ $$ = "INNER"; }
	| INNER JOIN 
		{ $$ = "INNER"; }
	| LEFT JOIN
		{ $$ = "LEFT"; }
	| LEFT OUTER JOIN
		{ $$ = "LEFT"; }
	| RIGHT JOIN
		{ $$ = "RIGHT"; }
	| RIGHT OUTER JOIN
		{ $$ = "RIGHT"; }
	| OUTER JOIN
		{ $$ = "OUTER"; }
	| FULL OUTER JOIN
		{ $$ = "OUTER"; }
	| SEMI JOIN
		{ $$ = "SEMI"; }
	| ANTI JOIN
		{ $$ = "ANTI"; }
	| CROSS JOIN
		{ $$ = "CROSS"; }
	;

OnClause
	: ON Expression
		{ $$ = {on: $2}; }
	| USING ColumnsList
		{ $$ = {using: $2}; }
	|
		{ $$ = null; }
	;

WhereClause
	: { $$ = null; }
	| WHERE Expression
		{ $$ = {where: new yy.Expression({expression:$2})}; }
	;

GroupClause
	: { $$ = null; }
	| GROUP BY GroupExpressionsList HavingClause
		{ $$ = {group:$3}; yy.extend($$,$4); }
	;

GroupExpressionsList
	: GroupExpression
		{ $$ = [$1]; }
	| GroupExpressionsList COMMA GroupExpression
		{ $$ = $1; $1.push($3); }
	;

GroupExpression
	: GROUPING SETS LPAR GroupExpressionsList RPAR
		{ $$ = new yy.GroupExpression({type:'GROUPING SETS', group: $4}); }
	| ROLLUP LPAR GroupExpressionsList RPAR
		{ $$ = new yy.GroupExpression({type:'ROLLUP', group: $3}); }
	| CUBE LPAR GroupExpressionsList RPAR
		{ $$ = new yy.GroupExpression({type:'CUBE', group: $3}); }
	| Expression
		{ $$ = $1; }
	;


HavingClause
	: { $$ = null; }
	| HAVING Expression
		{ $$ = {having:$2}}
	;

UnionClause
	:   { $$ = null; }
	| UNION Select
		{ $$ = {union: $2} ; }
	| UNION ALL Select
		{ $$ = {unionall: $3} ; }
	| EXCEPT Select
		{ $$ = {except: $2} ; }
	| INTERSECT Select
		{ $$ = {intersect: $2} ; }
	;

OrderClause
	: { $$ = null; }
	| ORDER BY OrderExpressionsList
		{ $$ = {order:$3}}
	;

OrderExpressionsList
	: OrderExpression
		{ $$ = [$1]; }
	| OrderExpressionsList COMMA OrderExpression
		{ $$ = $1; $1.push($3)}
	;

OrderExpression
	: Expression
		{ $$ = new yy.Expression({expression: $1, direction:'ASC'}) }
	| Expression DIRECTION
		{ $$ = new yy.Expression({expression: $1, direction:$2.toUpperCase()}) }
	| Expression COLLATE NOCASE
		{ $$ = new yy.Expression({expression: $1, direction:'ASC', nocase:true}) }
	| Expression COLLATE NOCASE DIRECTION
		{ $$ = new yy.Expression({expression: $1, direction:$4.toUpperCase(), nocase:true}) }
	;

LimitClause
	: { $$ = null; }
	| LIMIT NumValue OffsetClause
		{ $$ = {limit:$2}; yy.extend($$, $3)}
	;

OffsetClause
	: { $$ = null; }
	| OFFSET NumValue 
		{ $$ = {offset:$2}}
	;

ResultColumns
	: ResultColumns COMMA ResultColumn
		{ $1.push($3); $$ = $1; }
	| ResultColumn
		{ $$ = [$1]; }
	;

ResultColumn
	: Expression AS Literal
		{ $1.as = $3; $$ = $1;}
	| Expression Literal
		{ $1.as = $2; $$ = $1;}

/*	| Expression AS LBRA NUMBER RBRA
		{ $1.as = $4; $$ = $1;}
*/
	| Expression AS NUMBER
		{ $1.as = $3; $$ = $1;}
	| Expression NUMBER
		{ $1.as = $2; $$ = $1;}
	| Expression AS StringValue
		{ $1.as = $3; $$ = $1;}
	| Expression StringValue
		{ $1.as = $2; $$ = $1;}
	| Expression
		{ $$ = $1; }
	;

Star
	: Literal DOT Literal DOT STAR
		{ $$ = new yy.Column({columid: $5, tableid: $3, databaseid:$1}); }	
	| Literal DOT STAR
		{ $$ = new yy.Column({columnid: $3, tableid: $1}); }	
	| STAR
		{ $$ = new yy.Column({columnid:$1}); }
	;

Column
	: Literal DOT Literal DOT Literal
		{ $$ = new yy.Column({columnid: $5, tableid: $3, databaseid:$1});}	
	| Literal DOT Literal
		{ $$ = new yy.Column({columnid: $3, tableid: $1});}	
	| Literal
		{ $$ = new yy.Column({columnid: $1});}	
	;

Expression
	: AggrValue
		{ $$ = $1; }
	| FuncValue
		{ $$ = $1; }
	| Op
		{ $$ = $1; }
	| Column
		{ $$ = $1; }
	| Star
		{ $$ = $1; }
	| NumValue
		{ $$ = $1; }
	| LogicValue
		{ $$ = $1; }
	| StringValue
		{ $$ = $1; }
	| NullValue
		{ $$ = $1; }
	| ParamValue
		{ $$ = $1; }
	| VarValue
		{ $$ = $1; }
	| ExistsValue
		{ $$ = $1; }
	| CaseValue
		{ $$ = $1; }
	| CastClause
		{ $$ = $1; }
	| Json
		{ $$ = new yy.Json({value:$1}); }			
/*	| ATLBRA JsonArray
		{ $$ = new yy.Json({value:$2}); }
*/	| NewClause
		{ $$ = $1; }
/*	| AT LPAR Expression RPAR
		{ $$ = new yy.FuncValue({funcid: 'CLONEDEEP', args:[$3]}); }			
*/
/*	| AT LPAR Json RPAR
		{ $$ = new yy.Json({value:$3}); }			
*/	| LPAR Select RPAR
		{
			if(!yy.queries) yy.queries = []; 
			yy.queries.push($2);
			$2.queriesidx = yy.queries.length;
			$$ = $2;
		}		
	;

NewClause
	: NEW Literal
		{ $$ = new yy.FuncValue({funcid:$2, newid:true}); }
	| NEW FuncValue
		{ $$ = $2; yy.extend($$,{newid:true}); }
	;


CastClause
	: CAST LPAR Expression AS ColumnType RPAR
		{ $$ = new yy.Convert({expression:$3}) ; yy.extend($$,$5) ; }
	| CAST LPAR Expression AS ColumnType COMMA NUMBER RPAR
		{ $$ = new yy.Convert({expression:$3, style:$7}) ; yy.extend($$,$5) ; }
	| CONVERT LPAR ColumnType COMMA Expression RPAR
		{ $$ = new yy.Convert({expression:$5}) ; yy.extend($$,$3) ; }
	| CONVERT LPAR ColumnType COMMA Expression COMMA NUMBER RPAR
		{ $$ = new yy.Convert({expression:$5, style:$7}) ; yy.extend($$,$3) ; }
	;

PrimitiveValue
	: NumValue
		{ $$ = $1; }
	| StringValue
		{ $$ = $1; }
	| LogicValue
		{ $$ = $1; }
	| NullValue
		{ $$ = $1; }
	| ParamValue
		{ $$ = $1; }
	| FuncValue
		{ $$ = $1; }
	;


AggrValue
	: Aggregator LPAR Expression RPAR OverClause
		{ $$ = new yy.AggrValue({aggregatorid: $1.toUpperCase(), expression: $3}); }
	| Aggregator LPAR DISTINCT Expression RPAR OverClause
		{ $$ = new yy.AggrValue({aggregatorid: $1.toUpperCase(), expression: $4, distinct:true}); }
	| Aggregator LPAR ALL Expression RPAR OverClause
		{ $$ = new yy.AggrValue({aggregatorid: $1.toUpperCase(), expression: $4}); }
	;

OverClause
	:
		{$$ = null}
	| OVER LPAR OverPartitionClause RPAR
		{ $$ = {over: new yy.Over()}; yy.extend($$,$3); }
	| OVER LPAR OverOrderByClause RPAR
		{ $$ = {over: new yy.Over()}; yy.extend($$,$3); }
	| OVER LPAR OverPartitionClause OverOrderByClause RPAR
		{ $$ = {over: new yy.Over()}; yy.extend($$,$3); yy.extend($$,$4);}
	;

OverPartitionClause
	: PARTITION BY GroupExpressionsList
		{ $$ = {partition:$3}; }
	;
OverOrderByClause
	: ORDER BY OrderExpressionsList
		{ $$ = {order:$3}; }
	;
Aggregator
	: SUM { $$ = "SUM"; }
	| COUNT { $$ = "COUNT"; } 
	| MIN { $$ = "MIN"; }
	| MAX { $$ = "MAX"; }
	| AVG { $$ = "AVG"; }
	| FIRST { $$ = "FIRST"; }
	| LAST { $$ = "LAST"; }
	| AGGR { $$ = "AGGR"; }
	| ARRAY { $$ = "ARRAY"; }
/*	| REDUCE { $$ = "REDUCE"; } */
	;

FuncValue
/*	: LITERAL LPAR Expression RPAR
		{ 
		    $$ = new yy.FuncValue({funcid: $1, expression: $3}); 
		}
*/	
	: Literal LPAR ExprList RPAR
		{ 
		    if(alasql.aggr[$1]) {
		    	$$ = new yy.AggrValue({aggregatorid: 'REDUCE', 
                      funcid: $1, expression: $3.pop() });
		    } else {
			    $$ = new yy.FuncValue({funcid: $1, args: $3}); 
			};
		}
	| Literal LPAR RPAR
		{ $$ = new yy.FuncValue({ funcid: $1 }) }
	;

ExprList
	: Expression
		{ $$ = [$1]; }
	| ExprList COMMA Expression
		{ $1.push($3); $$ = $1 }
	;

NumValue
	: NUMBER
		{ $$ = new yy.NumValue({value:+$1}); }
/*	| MINUS NUMBER
		{ $$ = new yy.NumValue({value:-$2}); }
*/	;

LogicValue
	: TRUE
		{ $$ = new yy.LogicValue({value:true}); }
	| FALSE
		{ $$ = new yy.LogicValue({value:false}); }
	;

StringValue
	: STRING
		{ $$ = new yy.StringValue({value: $1.substr(1,$1.length-2).replace(/(\\\')/g,"'").replace(/(\'\')/g,"'")}); }
	;

NullValue
	: NULL
		{ $$ = new yy.NullValue({value:undefined}); }
	;

VarValue
	: AT Literal
		{ $$ = new yy.VarValue({variable:$2}); }
	;

ExistsValue
	: EXISTS LPAR Select RPAR
		{ 
			if(!yy.exists) yy.exists = [];
			$$ = new yy.ExistsValue({value:$3, existsidx:yy.exists.length}); 
			yy.exists.push($3);
		}
	;


ParamValue
	: DOLLAR Literal
		{ $$ = new yy.ParamValue({param: $2}); }
	| COLON Literal
		{ $$ = new yy.ParamValue({param: $2}); }
	| QUESTION
		{ 
			if(typeof yy.question == 'undefined') yy.question = 0; 
			$$ = new yy.ParamValue({param: yy.question++}); 
		}
	| BRAQUESTION
		{ 
			if(typeof yy.question == 'undefined') yy.question = 0; 
			$$ = new yy.ParamValue({param: yy.question++, array:true}); 
		}
	;


CaseValue
	: CASE Expression WhensList ElseClause END
		{ $$ = new yy.CaseValue({expression:$2, whens: $3, elses: $4}); }
	| CASE WhensList ElseClause END
		{ $$ = new yy.CaseValue({whens: $2, elses: $3}); }
	;

WhensList
	: WhensList When
		{ $$ = $1; $$.push($2); }
	| When
		{ $$ = [$1]; }
	;

When
	: WHEN Expression THEN Expression
		{ $$ = {when: $2, then: $4 }; }
	;

ElseClause
	: ELSE Expression
		{ $$ = $2; }
	| 
		{$$ = null; } 
	; 

Op
	: Expression LIKE Expression
		{ $$ = new yy.Op({left:$1, op:'LIKE', right:$3}); }
	| Expression PLUS Expression
		{ $$ = new yy.Op({left:$1, op:'+', right:$3}); }
	| Expression MINUS Expression
		{ $$ = new yy.Op({left:$1, op:'-', right:$3}); }
	| Expression STAR Expression
		{ $$ = new yy.Op({left:$1, op:'*', right:$3}); }
	| Expression SLASH Expression
		{ $$ = new yy.Op({left:$1, op:'/', right:$3}); }
	| Expression MODULO Expression
		{ $$ = new yy.Op({left:$1, op:'%', right:$3}); }
	| Expression CARET Expression
		{ $$ = new yy.Op({left:$1, op:'^', right:$3}); }

	| Expression ARROW Literal
		{ $$ = new yy.Op({left:$1, op:'->' , right:$3}); }
	| Expression ARROW NumValue
		{ $$ = new yy.Op({left:$1, op:'->' , right:$3}); }
	| Expression ARROW LPAR Expression RPAR
		{ $$ = new yy.Op({left:$1, op:'->' , right:$4}); }

	| Expression ARROW FuncValue
		{ $$ = new yy.Op({left:$1, op:'->' , right:$3}); }


	| Expression GT Expression
		{ $$ = new yy.Op({left:$1, op:'>' , right:$3}); }
	| Expression GE Expression
		{ $$ = new yy.Op({left:$1, op:'>=' , right:$3}); }
	| Expression LT Expression
		{ $$ = new yy.Op({left:$1, op:'<' , right:$3}); }
	| Expression LE Expression
		{ $$ = new yy.Op({left:$1, op:'<=' , right:$3}); }
	| Expression EQ Expression
		{ $$ = new yy.Op({left:$1, op:'=' , right:$3}); }
	| Expression EQEQ Expression
		{ $$ = new yy.Op({left:$1, op:'==' , right:$3}); }
	| Expression EQEQEQ Expression
		{ $$ = new yy.Op({left:$1, op:'===' , right:$3}); }
	| Expression NE Expression
		{ $$ = new yy.Op({left:$1, op:'!=' , right:$3}); }
	| Expression NEEQEQ Expression
		{ $$ = new yy.Op({left:$1, op:'!==' , right:$3}); }
	| Expression NEEQEQEQ Expression
		{ $$ = new yy.Op({left:$1, op:'!===' , right:$3}); }

	| Expression CondOp AllSome LPAR Select RPAR
		{ 
			if(!yy.queries) yy.queries = []; 
			$$ = new yy.Op({left:$1, op:$2 , allsome:$3, right:$5, queriesidx: yy.queries.length}); 
			yy.queries.push($5);  
		}

	| Expression CondOp AllSome LPAR ExprList RPAR
		{ 
			$$ = new yy.Op({left:$1, op:$2 , allsome:$3, right:$5}); 
		}

	| Expression AND Expression
		{ $$ = new yy.Op({left:$1, op:'AND' , right:$3}); }
	| Expression OR Expression
		{ $$ = new yy.Op({left:$1, op:'OR' , right:$3}); }
	| NOT Expression
		{ $$ = new yy.UniOp({op:'NOT' , right:$2}); }
	| MINUS Expression
		{ $$ = new yy.UniOp({op:'-' , right:$2}); }
	| LPAR Expression RPAR
		{ $$ = new yy.UniOp({right: $2}); }

	| Expression IN LPAR Select RPAR
		{ 
			if(!yy.queries) yy.queries = []; 
			$$ = new yy.Op({left: $1, op:'IN', right:$4, queriesidx: yy.queries.length});
			yy.queries.push($4);  
		}

	| Expression NOT IN LPAR Select RPAR
		{ 
			if(!yy.queries) yy.queries = []; 
			$$ = new yy.Op({left: $1, op:'NOT IN', right:$5, queriesidx: yy.queries.length});
			yy.queries.push($5);  
		}

	| Expression IN LPAR ExprList RPAR
		{ $$ = new yy.Op({left: $1, op:'IN', right:$4}); }

	| Expression NOT IN LPAR ExprList RPAR
		{ $$ = new yy.Op({left: $1, op:'NOT IN', right:$5}); }

	| Expression IN ColFunc
		{ $$ = new yy.Op({left: $1, op:'IN', right:$3}); }

	| Expression NOT IN ColFunc
		{ $$ = new yy.Op({left: $1, op:'NOT IN', right:$4}); }


	/* 
		Hack - it impossimle to parse BETWEEN AND and AND expressions with grammar 
		at least, I do not know how.
	*/
	| Expression BETWEEN Expression
		{ $$ = new yy.Op({left:$1, op:'BETWEEN', right:$3 }); }
	| Expression NOT_BETWEEN Expression
		{ $$ = new yy.Op({left:$1, op:'NOT BETWEEN', right:$3 }); }
	| Expression IS Expression
		{ $$ = new yy.Op({op:'IS' , left:$1, right:$3}); }
	;

ColFunc
	: Column
		{ $$ = $1;}
	| FuncValue
		{ $$ = $1;}
	| AT LPAR Expression RPAR
		{ $$ = $3;}	
	;

CondOp 
	: GT { $$ = $1; }
	| GE { $$ = $1; }
	| LT { $$ = $1; }
	| LE { $$ = $1; }
	| EQ { $$ = $1; }
	| NE { $$ = $1; }
	;

AllSome
	: ALL
		{ $$ = 'ALL'; }
	| SOME
		{ $$ = 'SOME'; }
	| ANY
		{ $$ = 'ANY'; }
	;

/* PART TWO */

/* UPDATE */

Update
	: UPDATE Table SET SetColumnsList WHERE Expression
		{ $$ = new yy.Update({table:$2, columns:$4, where:$6}); }
	| UPDATE Table SET SetColumnsList
		{ $$ = new yy.Update({table:$2, columns:$4}); }
	;

SetColumnsList
	: SetColumn
		{ $$ = [$1]; }
	| SetColumnsList COMMA SetColumn
		{ $$ = $1; $1.push($3); }
	;

SetColumn
	: Column EQ Expression
		{ $$ = new yy.SetColumn({columnid:$1, expression:$3})}
	;

/* DELETE */

Delete
	: DELETE FROM Table WHERE Expression
		{ $$ = new yy.Delete({table:$3, where:$5});}
	| DELETE FROM Table
		{ $$ = new yy.Delete({table:$3});}
	;

/* INSERT */

Insert
	: INSERT INTO Table VALUES ValuesListsList
		{ $$ = new yy.Insert({into:$3, values: $5}); }
	| INSERT INTO Table DEFAULT VALUES
		{ $$ = new yy.Insert({into:$3, default: true}) ; }
	| INSERT INTO Table LPAR ColumnsList RPAR VALUES ValuesListsList
		{ $$ = new yy.Insert({into:$3, columns: $5, values: $8}); }
	| INSERT INTO Table Select
		{ $$ = new yy.Insert({into:$3, select: $4}); }
	| INSERT INTO Table LPAR ColumnsList RPAR Select
		{ $$ = new yy.Insert({into:$3, columns: $5, select: $7}); }
	;
/*
TableParamFunc
	: Table
		{ $$ = $1; }
	| ParamValue
		{ $$ = $1; }
	| FuncValue
		{ $$ = $1; }
	;
*/

ValuesListsList
	: LPAR ValuesList RPAR
		{ $$ = [$2]; }
	| Json
		{ $$ = [$1]; }
	| ParamValue
		{ $$ = [$1]; }
	| ValuesListsList COMMA LPAR ValuesList RPAR
		{$$ = $1; $1.push($4)}
	| ValuesListsList COMMA Json
		{$$ = $1; $1.push($3)}
	| ValuesListsList COMMA ParamValue
		{$$ = $1; $1.push($3)}
	;

ValuesList
	: Expression
		{ $$ = [$1]; }
	| ValuesList COMMA Expression
		{$$ = $1; $1.push($3)}
	;

Value
	: NumValue
	| StringValue
	| LogicValue
	| NullValue
	| DateValue
	| ParamValue
	;

ColumnsList
	: Column
		{ $$ = [$1]; }
	| ColumnsList COMMA Column
		{$$ = $1; $1.push($3)}
	;

/* CREATE TABLE */

CreateTable
/*
	:  CREATE TemporaryClause TABLE IfNotExists Table LPAR CreateTableDefClause RPAR CreateTableOptionsClause

*/
	:  CREATE TABLE IfNotExists Table LPAR CreateTableDefClause RPAR CreateTableOptionsClause
		{ 
			$$ = new yy.CreateTable({table:$4}); 
			//yy.extend($$,$2); 
			yy.extend($$,$3); 
			yy.extend($$,$6); 
		}
	| CREATE TABLE IfNotExists Literal
		{ 
			$$ = new yy.CreateTable({table:new yy.Table({tableid:$4})}); 
		}		
	| CREATE TABLE IfNotExists Literal DOT Literal
		{ 
			$$ = new yy.CreateTable({table:new yy.Table({tableid:$6, databaseid:$4})}); 
		}		
	;

CreateTableOptionsClause
	:
	| CreateTableOptions
	;

CreateTableOptions
	: CreateTableOptions CreateTableOption
	| CreateTableOption
	;

CreateTableOption
	: DEFAULT
	| ENGINE EQ Literal
	| AUTO_INCREMENT EQ NumValue
	| CHARSET EQ Literal 
	;

TemporaryClause 
	: { $$ = null; }
	| TEMPORARY
		{ $$ = {temporary:true}; }
	| TEMP
		{ $$ = {temporary:true}; }
	;

IfNotExists
	: { $$ = null; }
	| IF NOT EXISTS
		{ $$ = {ifnotexists: true}; }
	;

CreateTableDefClause
	: ColumnDefsList COMMA ConstraintsList
		{ $$ = {columns: $1, constraints: $3}; }	
	| ColumnDefsList
		{ $$ = {columns: $1}; }	
	| AS Select
		{ $$ = {as: $2} }
	;

ConstraintsList
	: Constraint
		{ $$ = [$1];}
	| ConstraintsList COMMA Constraint
		{ $1.push($3); $$ = $1; }
	;

Constraint
	: ConstraintName PrimaryKey
		{ $2.constraintid = $1; $$ = $2; }
	| ConstraintName ForeignKey
		{ $2.constraintid = $1; $$ = $2; }
	| ConstraintName UniqueKey
		{ $2.constraintid = $1; $$ = $2; }
	| ConstraintName IndexKey
		{ $2.constraintid = $1; $$ = $2; }
	;

ConstraintName
	:   { $$ = null }
	| CONSTRAINT Literal
		{ $$ = $2; }
	;

PrimaryKey
	: PRIMARY KEY LPAR ColsList RPAR
		{ $$ = {type: 'PRIMARY KEY', columns: $4}; }
	;

ForeignKey
	: FOREIGN KEY LPAR ColsList RPAR REFERENCES Literal LPAR ColsList RPAR OnForeignKeyClause
		{ $$ = {type: 'FOREIGN KEY', columns: $4, fktableid: $7, fkcolumns: $9}; }
	;

OnForeignKeyClause
	:
		{ $$ = null; }
	| OnDeleteClause OnUpdateClause
		{ $$ = null; }
	;

OnDeleteClause
	: ON DELETE NO ACTION
		{$$ = null; }
	;
OnUpdateClause
	: ON UPDATE NO ACTION
		{$$ = null; }
	;

UniqueKey
	: UNIQUE 
	;

IndexKey
	: INDEX Literal LPAR ColumnsList RPAR
	| KEY Literal LPAR ColumnsList RPAR
	;	
ColsList
	: Literal
		{ $$ = [$1]; }
	| ColsList COMMA Literal
		{ $$ = $1; $1.push($3); }
	;

ColumnDefsList
	: ColumnDef
		{ $$ = [$1];}
	| ColumnDefsList COMMA ColumnDef
		{ $1.push($3); $$ = $1; }
	;

ColumnDef
	: Literal ColumnType ColumnConstraintsClause
		{ $$ = new yy.ColumnDef({columnid:$1}); yy.extend($$,$2); yy.extend($$,$3);}
	| Literal ColumnConstraints
		{ $$ = new yy.ColumnDef({columnid:$1}); yy.extend($$,$2); }
	;

ColumnType
	: LITERAL LPAR NUMBER COMMA NUMBER RPAR
		{ $$ = {dbtypeid: $1, dbsize: +$3, dbprecision: +$5} }
	| LITERAL LPAR NUMBER RPAR
		{ $$ = {dbtypeid: $1, dbsize: +$3} }
	| LITERAL
		{ $$ = {dbtypeid: $1} }
	| ENUM LPAR ValuesList RPAR
		{ $$ = {dbtypeid: 'ENUM', enumvalues: $3} }
	;


ColumnConstraintsClause
	: {$$ = null}
	| ColumnConstraintsList
		{ $$ = $1; }
	;


ColumnConstraintsList
	: ColumnConstraintsList ColumnConstraint
		{ yy.extend($1,$2); $$ = $1;}
	| ColumnConstraint
		{ $$ = $1; }
	;

ColumnConstraint 
	: PRIMARY KEY
		{$$ = {primarykey:true};}
	| FOREIGN KEY REFERENCES Literal LPAR Literal RPAR
		{$$ = {foreignkey:{tableid:$4, columnid: $6}};}
	| REFERENCES Literal LPAR Literal RPAR
		{$$ = {foreignkey:{tableid:$2, columnid: $4}};}
	| AUTO_INCREMENT
		{$$ = {auto_increment:true};}
	| IDENTITY LPAR NumValue COMMA NumValue RPAR
		{ $$ = {identity: [$3,$5]} }
	| DEFAULT PrimitiveValue
		{$$ = {default:$2};}
	| NULL
		{$$ = {null:true}; }
	| NOT NULL
		{$$ = {notnull:true}; }
	;

/* DROP TABLE */

DropTable
	: DROP TABLE IfExists Table
		{ $$ = new yy.DropTable({table:$4}); yy.extend($$, $3); }
	;

IfExists
	: { $$ = null; }
	| IF EXISTS
		{ $$ = {ifexists: true};}
	;

/* ALTER TABLE */

AlterTable
	: ALTER TABLE Table RENAME TO Literal
		{ $$ = new yy.AlterTable({table:$3, renameto: $6});}
	| ALTER TABLE Table ADD COLUMN ColumnDef
		{ $$ = new yy.AlterTable({table:$3, addcolumn: $6});}
	| ALTER TABLE Table MODIFY COLUMN ColumnDef
		{ $$ = new yy.AlterTable({table:$3, modifycolumn: $6});}
	| ALTER TABLE Table RENAME COLUMN Literal TO Literal
		{ $$ = new yy.AlterTable({table:$3, renamecolumn: $6, to: $8});}
	| ALTER TABLE Table DROP COLUMN Literal
		{ $$ = new yy.AlterTable({table:$3, dropcolumn: $6});}
	;

RenameTable
	: RENAME TABLE Table TO Literal
		{ $$ = new yy.AlterTable({table:$3, renameto: $5});}
	;

/* DATABASES */

AttachDatabase
	: ATTACH Literal DATABASE Literal
		{ $$ = new yy.AttachDatabase({databaseid:$4, engineid:$2.toUpperCase() });}
	| ATTACH Literal DATABASE Literal LPAR ExprList RPAR
		{ $$ = new yy.AttachDatabase({databaseid:$4, engineid:$2.toUpperCase(), args:$6 });}
	| ATTACH Literal DATABASE Literal AS Literal
		{ $$ = new yy.AttachDatabase({databaseid:$4, engineid:$2.toUpperCase(), as:$6 });}
	| ATTACH Literal DATABASE Literal LPAR ExprList RPAR AS Literal
		{ $$ = new yy.AttachDatabase({databaseid:$4, engineid:$2.toUpperCase(), as:$9, args:$6});}
	;

DetachDatabase
	: DETACH DATABASE Literal
		{ $$ = new yy.DetachDatabase({databaseid:$3});}
	;

CreateDatabase
	: CREATE DATABASE IfNotExists Literal
		{ $$ = new yy.CreateDatabase({databaseid:$4 }); yy.extend($$,$4); }
	| CREATE Literal DATABASE IfNotExists Literal AsClause
		{ $$ = new yy.CreateDatabase({engineid:$2.toUpperCase(), databaseid:$5, as:$6 }); yy.extend($$,$4); }
	| CREATE Literal DATABASE IfNotExists Literal LPAR ExprList RPAR AsClause
		{ $$ = new yy.CreateDatabase({engineid:$2.toUpperCase(), databaseid:$5, args:$7, as:$9 }); yy.extend($$,$4); }
	;

AsClause
	:	
		{$$ = null;}
	| AS Literal
		{ $$ = $1; }
	;
	
UseDatabase
	: USE DATABASE Literal
		{ $$ = new yy.UseDatabase({databaseid: $3 });}	
	| USE Literal
		{ $$ = new yy.UseDatabase({databaseid: $2 });}	
	;

DropDatabase
	: DROP DATABASE IfExists Literal
		{ $$ = new yy.DropDatabase({databaseid: $4 }); yy.extend($$,$3); }	
	| DROP Literal DATABASE IfExists Literal
		{ $$ = new yy.DropDatabase({databaseid: $5, engineid:$2.toUpperCase() }); yy.extend($$,$4); }	
	;

/* INDEXES */

CreateIndex
	: CREATE INDEX Literal ON Table LPAR ColsList RPAR
		{ $$ = new yy.CreateIndex({indexid:$3, table:$5, columns:$7})}
	| CREATE UNIQUE INDEX Literal ON Table LPAR ColsList RPAR
		{ $$ = new yy.CreateIndex({indexid:$4, table:$6, columns:$8, unique:true})}
	;

DropIndex
	: DROP INDEX Literal
		{ $$ = new yy.DropIndex({indexid:$3});}
	;

/* SHOW COMMAND */

ShowDatabases
	: SHOW DATABASES
		{ $$ = new yy.ShowDatabases();}
	| SHOW DATABASES LIKE StringValue
		{ $$ = new yy.ShowDatabases({like:$4});}
	| SHOW Literal DATABASES
		{ $$ = new yy.ShowDatabases({engineid:$2.toUpperCase() });}
	| SHOW Literal DATABASES LIKE StringValue
		{ $$ = new yy.ShowDatabases({engineid:$2.toUpperCase() , like:$5});}
	;

ShowTables
	: SHOW TABLES
		{ $$ = new yy.ShowTables();}
	| SHOW TABLES LIKE StringValue
		{ $$ = new yy.ShowTables({like:$4});}
	| SHOW TABLES FROM Literal 
		{ $$ = new yy.ShowTables({databaseid: $4});}
	| SHOW TABLES FROM Literal LIKE StringValue
		{ $$ = new yy.ShowTables({like:$6, databaseid: $4});}
	;

ShowColumns
	: SHOW COLUMNS FROM Table
		{ $$ = new yy.ShowColumns({table: $4});}
	| SHOW COLUMNS FROM Table FROM Literal
		{ $$ = new yy.ShowColumns({table: $4, databaseid:$6});}
	;

ShowIndex
	: SHOW INDEX FROM Table
		{ $$ = new yy.ShowIndex({table: $4});}
	| SHOW INDEX FROM Table FROM Literal
		{ $$ = new yy.ShowIndex({table: $4, databaseid: $6});}
	;

ShowCreateTable
	: SHOW CREATE TABLE Table
		{ $$ = new yy.ShowCreateTable({table: $4});}
	| SHOW CREATE TABLE Table FROM Literal
		{ $$ = new yy.ShowCreateTable({table: $4, databaseid:$6});}
	;

CreateView
	: CREATE VIEW View AS Select
		{ $$ = new yy.CreateView({view:$3, select: $5}); }
	| CREATE VIEW View LPAR ColsList RPAR AS Select
		{ $$ = new yy.CreateView({view:$3, columns: $5, select: $5}); }
	;

DropView
	: DROP VIEW View
		{ $$ = new yy.DropView({view:$2}); }
	;

View
	: Literal
		{ $$ = new yy.View({viewid: $1}); }
	| Literal DOT Literal
		{ $$ = new yy.View({databaseid:$1, viewid: $3}); }
	;

DeclareCursor
	: DECLARE Literal CURSOR FOR Select
		{ $$ = new yy.DeclareCursor({cursorid:$2, select:$5}); }
	;

OpenCursor
	: OPEN Literal
		{ $$ = new yy.OpenCursor({cursorid:$2}); }
	;

CloseCursor
	: CLOSE Literal
		{ $$ = new yy.CloseCursor({cursorid:$2}); }
	;

FetchCursor
	: FETCH FetchDirection FROM Literal
		{ $$ = new yy.FetchCursor({cursorid:$4}); yy.extend($$,$2); }
	;

FetchDirection
	: NEXT
		{ $$ = {direction: 'NEXT'}; }
	| PRIOR
		{ $$ = {direction: 'PRIOR'}; }
	| FIRST
		{ $$ = {direction: 'FIRST'}; }
	| LAST
		{ $$ = {direction: 'LAST'}; }
	| ABSOLUTE NumValue
		{ $$ = {direction: 'ABSOLUTE', num:$2}; }
	| RELATIVE NumValue
		{ $$ = {direction: 'RELATIVE', num:$2}; }
	;

Help
	: HELP StringValue 
		{ $$ = new yy.Help({subject:$2.value.toUpperCase()} ) ; }
	| HELP
		{ $$ = new yy.Help() ; }
	;

ExpressionStatement
	: Expression
		{ $$ = new yy.ExpressionStatement({expression:$1}); }
	;

Source
	: SOURCE StringValue
		{ $$ = new yy.Source({url:$2.value}); }
	;

Assert
	: ASSERT Json
		{ $$ = new yy.Assert({value:$2}); }
	| ASSERT PrimitiveValue
		{ $$ = new yy.Assert({value:$2.value}); }
	| ASSERT STRING COMMA Json	
		{ $$ = new yy.Assert({value:$4, message:$2}); }
	;

Json
	: AT LPAR Expression RPAR
		{ $$ = $3; }
	| AT StringValue
		{ $$ = $2.value; }
	| AT NumValue
		{ $$ = +$2.value; }
	| AT LogicValue
		{ $$ = (!!$2.value); }
	| AT ParamValue
		{ $$ = $2; }
	| JsonObject
		{ $$ = $1; }
	| AT JsonObject
		{ $$ = $2; }
	| ATLBRA JsonArray
		{ $$ = $2; }
	;

JsonValue
	: Json
		{ $$ = $1; }
	| JsonPrimitiveValue
		{ $$ = $1; }
	;

JsonPrimitiveValue
	: NumValue
		{ $$ = +$1.value; }
	| StringValue
		{ $$ = ""+$1.value; }
	| LogicValue
		{ $$ = $1.value; }
	| Column
		{ $$ = $1; }	
	| NullValue
		{ $$ = $1.value; }
	| ParamValue
		{ $$ = $1; }
	| FuncValue
		{ $$ = $1; }
	| LPAR Expression RPAR
		{ $$ = $2}
	;


JsonObject
	: LCUR JsonPropertiesList RCUR
		{ $$ = $2; }
	| LCUR JsonPropertiesList COMMA RCUR
		{ $$ = $2; }
	| LCUR RCUR
		{ $$ = {}; }
	;

JsonArray
	: JsonElementsList RBRA
		{ $$ = $1; } 
	| JsonElementsList COMMA RBRA
		{ $$ = $1; } 
	| RBRA
		{ $$ = []; }
	;

JsonPropertiesList
	: JsonPropertiesList COMMA JsonProperty
		{ yy.extend($1,$3); $$ = $1; }
	| JsonProperty
		{ $$ = $1; }
	;

JsonProperty
	: STRING COLON JsonValue
		{ $$ = {}; $$[$1.substr(1,$1.length-2)] = $3; }
	| NUMBER COLON JsonValue
		{ $$ = {}; $$[$1] = $3; }		
	| Literal COLON JsonValue
		{ $$ = {}; $$[$1] = $3; }		
/*	| STRING COLON ParamValue
		{ $$ = {}; $$[$1.substr(1,$1.length-2)] = $3; }	
	| NUMBER COLON ParamValue
		{ $$ = {}; $$[$1] = $3; }		
	| LITERAL COLON ParamValue
		{ $$ = {}; $$[$1] = $3; }		
*/	;

JsonElementsList
	: JsonElementsList COMMA JsonValue
		{ $1.push($3); $$ = $1; }
	| JsonValue
		{ $$ = [$1]; }
	;

SetVariable
	: SET Literal OnOff
		{ $$ = new yy.SetVariable({variable:$2.toLowerCase(), value:$3});}
	| SET AT Literal EQ Expression
		{ $$ = new yy.SetVariable({variable:$3, expression:$5});}
	;

OnOff
	: ON
		{ $$ = true; }
	| OFF
		{ $$ = false; }
	;

CommitTransaction
	: COMMIT TRANSACTION
		{ $$ = new yy.CommitTransaction(); }
	;

RollbackTransaction
	: ROLLBACK TRANSACTION
		{ $$ = new yy.RollbackTransaction(); }
	;

BeginTransaction
	: BEGIN TRANSACTION
		{ $$ = new yy.BeginTransaction(); }
	;

Store
	: STORE
		{ $$ = new yy.Store(); }
	| STORE Literal
		{ $$ = new yy.Store({databaseid: $2}); }
	;

Restore
	: RESTORE
		{ $$ = new yy.Restore(); }
	| RESTORE Literal
		{ $$ = new yy.Restore({databaseid: $2}); }
	;	

If
	: IF Expression Statement
		{ $$ = new yy.If({expression:$2,thenstat:$3}); }
	| IF Expression Statement ElseStatement
		{ $$ = new yy.If({expression:$2,thenstat:$3, elsestat:$4}); }

/*	| IF Expression Statement
		{ $$ = new yy.If({expression:$2,thenstat:$3}); }
*/	;

ElseStatement
	: ELSE Statement
		{$$ = $2;}
	| {$$ = undefined; }
	;

While
	: WHILE Expression Statement
		{ $$ = new yy.While({expression:$2,loopstat:$3}); }
	;

Continue
	: CONTINUE
		{ $$ = new yy.Continue(); } 
	;

Break
	: BREAK
		{ $$ = new yy.Break(); } 
	;

BeginEnd
	: BEGIN Statements END
		{ $$ = new yy.BeginEnd({statements:$2}); } 
	;

Print
	: PRINT Select
		{ $$ = new yy.Print({statement:$2});}
	| PRINT ExpressionStatement
		{ $$ = new yy.Print({statement:$2});}	
	;

Require
	: REQUIRE StringValuesList
		{ $$ = new yy.Require({paths:$2}); }
	;

StringValuesList
	: StringValuesList COMMA StringValue
		{ $1.push($3); $$ = $1; }
	| StringValue
		{ $$ = [$1]; }
	;

Declare
	: DECLARE AT Literal ColumnType
		{ $$ = new yy.Declare({variable:$3}); yy.extend($$,$4); }
	;