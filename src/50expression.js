/*
//
// Expressions for Alasql.js
// Date: 03.11.2014
// (c) 2014, Andrey Gershun
//
*/

yy.ExpressionStatement = function(params) { return yy.extend(this, params); };
yy.ExpressionStatement.prototype.toString = function() {
	return this.expression.toString();
};

yy.ExpressionStatement.prototype.execute = function (databaseid, params, cb) {
	if(this.expression) {
//		console.log(this.expression.toJavaScript('','', null));
//		console.log(this.expression.toJavaScript('','', null));
		var expr =  new Function("params,alasql",'return '+this.expression.toJavaScript('','', null));
		var res = expr(params,alasql);
		if(cb) res = cb(res);
		return res;
	}
}

yy.Expression = function(params) { return yy.extend(this, params); };
yy.Expression.prototype.toString = function() {
	var s = this.expression.toString();
	if(this.order) s += ' '+this.order.toString();
	if(this.nocase) s += ' '+K('COLLATE')+' '+K('NOCASE');
	return s;
};
yy.Expression.prototype.findAggregator = function (query){
	if(this.expression.findAggregator) this.expression.findAggregator(query);
};

yy.Expression.prototype.toJavaScript = function(context, tableid, defcols) {
//	console.log('Expression',this);
	if(this.expression.reduced) return 'true';
	return this.expression.toJavaScript(context, tableid, defcols);
};
yy.Expression.prototype.compile = function(context, tableid, defcols){
//	console.log('Expression',this);
	if(this.reduced) return returnTrue();
	return new Function('p','return '+this.toJavaScript(context, tableid, defcols));
};




yy.Literal = function (params) { return yy.extend(this, params); }
yy.Literal.prototype.toString = function() {
	var s = this.value;
	if(this.value1) s = this.value1+'.'+s; 
//	else s = tableid+'.'+s;
	return L(s);
}


yy.Join = function (params) { return yy.extend(this, params); }
yy.Join.prototype.toString = function() {
	var s = NL()+ID();
	if(this.joinmode) s += K(this.joinmode)+' ';
	s += K('JOIN')+this.table.toString();
	return s;
}

//yy.Join.prototype.toJavaScript = function(context, tableid) {
//	return 'JOIN'+this.table.toString();
//}


yy.Table = function (params) { return yy.extend(this, params); }
yy.Table.prototype.toString = function() {
	var s = this.tableid;
//	if(this.joinmode)
	if(this.databaseid) s = this.databaseid+'.'+s;
	return L(s);
};


yy.View = function (params) { return yy.extend(this, params); }
yy.View.prototype.toString = function() {
	var s = this.viewid;
//	if(this.joinmode)
	if(this.databaseid) s = this.databaseid+'.'+s;
	return L(s);
};


yy.Op = function (params) { return yy.extend(this, params); }
yy.Op.prototype.toString = function() {
	if(this.op == 'IN' || this.op == 'NOT IN') {
		return this.left.toString()+" "+P(this.op)+" ("+this.right.toString()+")";
	}
	if(this.allsome) {
		return this.left.toString()+" "+P(this.op)+" "+this.allsome+' ('+this.right.toString()+')';
	}
	return this.left.toString()+" "+P(this.op)+" "+(this.allsome?this.allsome+' ':'')+this.right.toString();
};

yy.Op.prototype.findAggregator = function (query){
//	console.log(this.toString());
	if(this.left && this.left.findAggregator) this.left.findAggregator(query);
	// Do not go in > ALL
	if(this.right && this.right.findAggregator && (!this.allsome)) {
		this.right.findAggregator(query);
	}
};

yy.Op.prototype.toType = function(tableid) {
	if(['-','*','/','%','^'].indexOf(this.op) >-1) return 'number';
	if(this.op == '+') {
		if(this.left.toType(tableid) == 'string' || this.right.toType(tableid) == 'string') return 'string';
		if(this.left.toType(tableid) == 'number' || this.right.toType(tableid) == 'number') return 'number';
	};
	if(['AND','OR','NOT','=','==','===', '!=','!==','!===','>','>=','<','<=', 'IN', 'NOT IN', 'LIKE'].indexOf(this.op) >-1 ) return 'boolean';
	if(this.op == 'BETWEEN' || this.op == 'NOT BETWEEN' || this.op == 'IS NULL' || this.op == 'IS NOT NULL') return 'boolean';
	if(this.allsome) return 'boolean';
	if(!this.op) return this.left.toType();

	return 'unknown';
};

yy.Op.prototype.toJavaScript = function(context,tableid,defcols) {
//	console.log(this);
	var op = this.op;
	if(this.op == '=') op = '===';
	else if(this.op == '<>') op = '!=';
	else if(this.op == 'OR') op = '||';

	if(this.op == '->') {
//		console.log(this.right, typeof this.right);
		if(typeof this.right == "string") {
			return this.left.toJavaScript(context,tableid, defcols)+'["'+this.right+'"]';
		} else if(typeof this.right == "number") {
			return this.left.toJavaScript(context,tableid, defcols)+'['+this.right+']';
		} else if(this.right instanceof yy.FuncValue) {
			ss = [];
			if(!this.right.args || this.right.args.length == 0) {
			} else {
				var ss = this.right.args.map(function(arg){
					return arg.toJavaScript(context,tableid, defcols);
				});
			}
			return this.left.toJavaScript(context,tableid, defcols)+'[\''+this.right.funcid+'\']('+
				ss.join(',')+')'; 
		} else {
			return this.left.toJavaScript(context,tableid, defcols)+'['+this.right.toJavaScript(context,tableid, defcols)+']';
		}
	}

	if(this.op == 'IS') {
		return '((typeof '+this.left.toJavaScript(context,tableid, defcols)+"=='undefined') == "
			+ '(typeof '+this.right.toJavaScript(context,tableid, defcols)+"=='undefined'))";
	}


	if(this.op == '==') {
		return 'alasql.utils.deepEqual('+this.left.toJavaScript(context,tableid, defcols)+","+this.right.toJavaScript(context,tableid, defcols)+')';
	}
	if(this.op == '===') {
		return "(("+this.left.toJavaScript(context,tableid, defcols)+").valueOf()===("+this.right.toJavaScript(context,tableid, defcols)+'.valueOf()))';
	}

	if(this.op == '!===') {
		return "!(("+this.left.toJavaScript(context,tableid, defcols)+").valueOf()===("+this.right.toJavaScript(context,tableid, defcols)+'.valueOf()))';
	}


	if(this.op == '!==') {
		return '(!alasql.utils.deepEqual('+this.left.toJavaScript(context,tableid, defcols)+","+this.right.toJavaScript(context,tableid, defcols)+'))';
	}

	if(this.op == 'LIKE') {
		var s = "("+this.left.toJavaScript(context,tableid, defcols)+"+'')"+
		".match(new RegExp('^'+("+this.right.toJavaScript(context,tableid, defcols)+").replace(/\\\%/g,'.*')+'$','g'))"
//		console.log(s);
		return s;
	};

	if(this.op == 'BETWEEN') {
		if(this.right instanceof yy.Op && this.right.op == 'AND') {
			return '(('+this.right.left.toJavaScript(context,tableid, defcols)+'<='+this.left.toJavaScript(context,tableid, defcols)+')&&'+
			'('+this.left.toJavaScript(context,tableid, defcols)+'<='+this.right.right.toJavaScript(context,tableid, defcols)+'))';		
		} else {
			throw new Error('Wrong BETWEEM operator without AND part');
		}
	};

	if(this.op == 'NOT BETWEEN') {
		if(this.right instanceof yy.Op && this.right.op == 'AND') {
			return '!(('+this.right.left.toJavaScript(context,tableid, defcols)+'<='+this.left.toJavaScript(context,tableid, defcols)+')&&'+
			'('+this.left.toJavaScript(context,tableid, defcols)+'<='+this.right.right.toJavaScript(context,tableid, defcols)+'))';		
		} else {
			throw new Error('Wrong NOT BETWEEM operator without AND part');
		}
	};

	if(this.op == 'IN') {
		if(this.right instanceof yy.Select ) {
			var s = '(this.query.queriesdata['+this.queriesidx+'].indexOf(';
			s += this.left.toJavaScript(context,tableid, defcols)+')>-1)';
			return s;
		} else if(this.right instanceof Array ) {
			var s = '(['+this.right.map(function(a){return a.toJavaScript(context,tableid, defcols)}).join(',')+'].indexOf(';
			s += this.left.toJavaScript(context,tableid, defcols)+')>-1)';
//console.log(s);
			return s;
		} else {
			var s = '('+this.right.toJavaScript(context,tableid, defcols)+'.indexOf(';
			s += this.left.toJavaScript(context,tableid, defcols)+')>-1)';
			return s;
//		} else {
//			throw new Error('Wrong IN operator without SELECT part');
		}
	};


	if(this.op == 'NOT IN') {
		if(this.right instanceof yy.Select ) {
			var s = '(this.query.queriesdata['+this.queriesidx+'].indexOf(';
			s += this.left.toJavaScript(context,tableid, defcols)+')<0)';
			return s;
		} else if(this.right instanceof Array ) {
			var s = '(['+this.right.map(function(a){return a.toJavaScript(context,tableid, defcols)}).join(',')+'].indexOf(';
			s += this.left.toJavaScript(context,tableid, defcols)+')<0)';
			return s;
		} else {
			throw new Error('Wrong NOT IN operator without SELECT part');
		}
	};

	if(this.allsome == 'ALL') {
		if(this.right instanceof yy.Select ) {
			var s = 'this.query.queriesdata['+this.queriesidx+'].every(function(b){return (';
			s += this.left.toJavaScript(context,tableid, defcols)+')'+op+'b})';
			return s;
		} else if(this.right instanceof Array ) {
			var s = '['+this.right.map(function(a){return a.toJavaScript(context,tableid, defcols)}).join(',')+'].every(function(b){return (';
			s += this.left.toJavaScript(context,tableid, defcols)+')'+op+'b})';
			return s;
		} else {
			throw new Error('Wrong NOT IN operator without SELECT part');
		}		
	};

	if(this.allsome == 'SOME' || this.allsome == 'ANY') {
		if(this.right instanceof yy.Select ) {
			var s = 'this.query.queriesdata['+this.queriesidx+'].some(function(b){return (';
			s += this.left.toJavaScript(context,tableid, defcols)+')'+op+'b})';
			return s;
		} else if(this.right instanceof Array ) {
			var s = '['+this.right.map(function(a){return a.toJavaScript(context,tableid, defcols)}).join(',')+'].some(function(b){return (';
			s += this.left.toJavaScript(context,tableid, defcols)+')'+op+'b})';
			return s;
		} else {
			throw new Error('Wrong NOT IN operator without SELECT part');
		}		
	};

// Special case for AND optimization (if reduced)
	if(this.op == 'AND') {
		if(this.left.reduced) {
			if(this.right.reduced) {
				return 'true';
			} else {
				return this.right.toJavaScript(context,tableid, defcols);
			}
		} else if(this.right.reduced) {
			return this.left.toJavaScript(context,tableid, defcols);
		}			

		// Otherwise process as regular operation (see below)
		op = '&&';

	}

	if(this.op == '^') {
		return 'Math.pow('+this.left.toJavaScript(context,tableid, defcols)
			+','+this.right.toJavaScript(context,tableid, defcols)+')';
	};


	// Change names
//	console.log(this);
	return '('+this.left.toJavaScript(context,tableid, defcols)+op+this.right.toJavaScript(context,tableid, defcols)+')';
};



yy.VarValue = function (params) { return yy.extend(this, params); }
yy.VarValue.prototype.toString = function() {
	return '@'+L(this.variable);
};

yy.VarValue.prototype.toType = function() {
	return 'unknown';
};

yy.VarValue.prototype.toJavaScript = function() {
	return "alasql.vars['"+this.variable+"']";
}


yy.NumValue = function (params) { return yy.extend(this, params); }
yy.NumValue.prototype.toString = function() {
	return N(this.value.toString());
};

yy.NumValue.prototype.toType = function() {
	return 'number';
};

yy.NumValue.prototype.toJavaScript = function() {
	return ""+this.value;
}




yy.StringValue = function (params) { return yy.extend(this, params); }
yy.StringValue.prototype.toString = function() {
	return "'"+S(this.value.toString())+"'";
}

yy.StringValue.prototype.toType = function() {
	return 'string';
}

yy.StringValue.prototype.toJavaScript = function() {
//	console.log("'"+doubleqq(this.value)+"'");
//	return "'"+doubleqq(this.value)+"'";
	return "'"+escapeq(this.value)+"'";

}


yy.LogicValue = function (params) { return yy.extend(this, params); }
yy.LogicValue.prototype.toString = function() {
	return this.value?'TRUE':'FALSE';
}

yy.LogicValue.prototype.toType = function() {
	return 'boolean';
}

yy.LogicValue.prototype.toJavaScript = function() {
	return this.value?'true':'false';
}

yy.NullValue = function (params) { return yy.extend(this, params); }
yy.NullValue.prototype.toString = function() {
	return 'NULL';
}
yy.NullValue.prototype.toJavaScript = function() {
	return 'undefined';
}

yy.ParamValue = function (params) { return yy.extend(this, params); }
yy.ParamValue.prototype.toString = function() {
	return '$'+this.param;
}
yy.ParamValue.prototype.toJavaScript = function() {
	if(typeof this.param == "string") return "params[\'"+this.param+"\']";
	else return "params["+this.param+"]";
}



yy.UniOp = function (params) { return yy.extend(this, params); }
yy.UniOp.prototype.toString = function() {
	if(this.op == '-') return this.op+this.right.toString();
	if(this.op == 'NOT') return this.op+'('+this.right.toString()+')';
	else if(this.op == null) return '('+this.right.toString()+')';
};

yy.UniOp.prototype.findAggregator = function (query){
	if(this.right.findAggregator) this.right.findAggregator(query);
};

yy.UniOp.prototype.toType = function(tableid) {
	if(this.op == '-') return 'number';
	if(this.op == 'NOT') return 'boolean';
};

yy.UniOp.prototype.toJavaScript = function(context, tableid, defcols) {
	if(this.op == '-') return "-"+this.right.toJavaScript(context, tableid, defcols);
	if(this.op == 'NOT') return '!('+this.right.toJavaScript(context, tableid, defcols)+')';
	else if(this.op == null) return '('+this.right.toJavaScript(context, tableid, defcols)+')';
};



// yy.Star = function (params) { return yy.extend(this, params); }
// yy.Star.prototype.toString = function() {
// 	var s = this.fieldid;
// 	if(this.tableid) {
// 		s = this.tableid+'.'+s;
// 		if(this.databaseid) {
// 			s = this.databaseid+'.'+s;
// 		}
// 	}
// 	if(this.alias) s += ' AS '+this.alias;
// 	return s;
// }

yy.Column = function(params) { return yy.extend(this, params); }
yy.Column.prototype.toString = function() {
	var s;
	if(this.columnid == +this.columnid) {
		s = '['+this.columnid+']';
	} else {
		s = this.columnid;
	}
	if(this.tableid) {
		if(+this.columnid == this.columnid) {
			s = this.tableid+s;
		} else {
			s = this.tableid+'.'+s;
		}
		if(this.databaseid) {
			s = this.databaseid+'.'+s;
		}
	}
//	if(this.alias) s += ' AS '+this.alias;
	return s;
};

yy.Column.prototype.toJavaScript = function(context, tableid, defcols) {
//	var s = this.value;
// 	var s = this.columnid;
// 	if(this.tableid) {
// 		s = this.tableid+'.'+s;
// //		if(this.databaseid) {
// //			s = this.databaseid+'.'+s;
// //		}
// 	} else {
// 		s = tableid+'.'+s;
// 	}
//console.log('yy.Column',this, tableid);
//	console.log(392,this.columnid);
	var s = '';
	if(!this.tableid && tableid == '' && !defcols) {
		if(this.columnid != '_') {
			s = context+'[\''+this.columnid+'\']';
		} else {
			s = context;
		}
	} else {
		if(this.tableid) {
			if(this.columnid != '_') {
				s = context+'[\''+(this.tableid) + '\'][\''+this.columnid+'\']';			
			} else {
				s = context+'[\''+(this.tableid) + '\']';
			}
		} else if(defcols) {
			var tbid = defcols[this.columnid];
			if(tbid == '-') {
				throw new Error('Cannot resolve column "'+this.columnid+'" because it exists in two source tables');
			} else if(tbid) {
				if(this.columnid != '_') {
					s = context+'[\''+(tbid) + '\'][\''+this.columnid+'\']';
				} else {
					s = context+'[\''+(tbid) + '\']';
				};
			} else {
				if(this.columnid != '_') {
					s = context+'[\''+(this.tableid || tableid) + '\'][\''+this.columnid+'\']';
				} else {
					s = context+'[\''+(this.tableid || tableid) + '\']';
				};
			}
		} else if(tableid == -1) {
//			if(this.columnid != '') {
				s = context+'[\''+this.columnid+'\']';
//			} else {
//				s = context;				
//			}
		} else {
			if(this.columnid != '_') {
				s = context+'[\''+(this.tableid || tableid) + '\'][\''+this.columnid+'\']';
			} else {
				s = context+'[\''+(this.tableid || tableid) + '\']';
			}
		}
	}
//	console.log(context,s);
//	console.trace(new Error());
	return s;
}




yy.AggrValue = function(params){ return yy.extend(this, params); }
yy.AggrValue.prototype.toString = function() {
	var s = '';
	if(this.aggregatorid == 'REDUCE') s += L(this.funcid)+'(';
	else s += this.aggregatorid+'(';
	if(this.distinct) s+= K('DISTINCT')+' ';
	if(this.expression) s += this.expression.toString();
	s += ')';
//	if(this.alias) s += ' AS '+this.alias;
	return s;
};
yy.AggrValue.prototype.findAggregator = function (query){
//	console.log('aggregator found',this.toString());

	var colas = this.as || this.toString();
/*	var found = false;
	for(var i=0;i<query.columns.length;i++) {
		// THis part should be intellectual
		if(query.columns[i].as == colas) {
			found = true;
			break;
		}
	}
*/	
//	if(!query.selectColumns[colas]) {
//	}

	var found = false;
	for(var i=0;i<query.selectGroup.length;i++){
		if(query.selectGroup[i].as==colas) {
			found = true;
			break;
		};
	};
	if(!found) {
		if(!this.as) {
			this.as = colas;
			var found = false;
			for(var i=0;i<query.removeKeys.length;i++){
				if(query.removeKeys[i]==colas) {
					found = true;
					break;
				}
			};
			if(!found) query.removeKeys.push(colas);
		};
		query.selectGroup.push(this);
	};
//	console.log(query.selectGroup);


////	this.reduced = true;
	return;
};

yy.AggrValue.prototype.toType = function() {
	if(['SUM','COUNT','AVG','MIN', 'MAX','AGGR','VAR','STDDEV'].indexOf(this.aggregatorid)>-1) return 'number';
	if(['ARRAY'].indexOf(this.aggregatorid)>-1) return 'array';
	if(['FIRST','LAST' ].indexOf(this.aggregatorid)>-1) return this.expression.toType();
}
yy.AggrValue.prototype.toJavaScript = function(context, tableid, defcols) {
//	var s = 'alasql.functions.'+this.funcid+'(';
//	if(this.expression) s += this.expression.toJavaScript(context, tableid);
//	s += ')';
//	if(this.alias) s += ' AS '+this.alias;
//	return s;
//	var s = ''; 
//if(this.as) console.log(499,this.as);
	var colas = this.as;
	if(typeof colas == 'undefined') colas = this.toString();
	return 'g[\''+colas+'\']';
}


yy.OrderExpression = function(params){ return yy.extend(this, params); }
yy.OrderExpression.prototype.toString = function() {
	var s = this.expression.toString();
	if(this.order) s += ' '+this.order.toString();
	if(this.nocase) s += ' '+K('COLLATE')+' '+K('NOCASE');
	return s;
}

yy.GroupExpression = function(params){ return yy.extend(this, params); }
yy.GroupExpression.prototype.toString = function() {
	return this.type+'('+this.group.toString()+')';
}


yy.ColumnDef = function (params) { return yy.extend(this, params); }
yy.ColumnDef.prototype.toString = function() {
	var s =  this.columnid;
	if(this.dbtypeid) s += ' '+this.dbtypeid;
	if(this.dbsize) {
		s += '('+this.dbsize;
		if(this.dbprecision) s += ','+this.dbprecision;
		s += ')';
	};
	if(this.primarykey) s += ' PRIMARY KEY';
	if(this.notnull) s += ' NOT NULL';
	return s;
}
