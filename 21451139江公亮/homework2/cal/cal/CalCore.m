

#import "CalCore.h"

@implementation CalCore

// 构造方法
- (id)init {
    self = [super init];
    if (self) {
        debug = YES;
        //debug = NO;
        
        opc = [[NSString alloc] initWithFormat:@"0"];
        op1 = 0.0;
        op2 = 0.0;
        cache = 0.0;
        result = 0.0;
        
        hasCache = NO;
        
        [self resetAll];
        
        // Initialization code here.
    }

    return self;
}
// 析构方法(毁灭函数)
-(void)dealloc {
	if(opc != nil) {
		[opc release];
	}
	[super dealloc];
}


// --------------------------------------------
-(void) debugInfo:(NSString*)info{
    if ( debug == YES ) {
        NSLog(@"\n\n%@\n", info);
        NSLog(@"==============================\n");
        NSLog(@">> Last Operation is %ld\n", lastOp);
        NSLog(@">> Current Operation is %@\n", opc);
        NSLog(@">> Current Operation Index is %d\n", opi);
        NSLog(@">> The OperationNum 1 is %g\n", op1);
        NSLog(@">> The OperationNum 2 is %g\n", op2);
        NSLog(@">> Mem Store Number is %g and Cache Switch is %d\n", cache, hasCache);
        NSLog(@">> Result Cache is %g\n", result);
        NSLog(@"==============================\n");
    }
}

-(void) reset {
    opc = @"";
    op1 = 0.0;
    op2 = 0.0;
    result = 0.0;

    opi = 0;
    //lastInput = 0;  // 上一个键入的内容类型
    hasPoint = NO;   // 是否输入了小数点
    lastOp = -1;    // 初始时为-1
    isError = 0;
    
    [self display: @"0"];
}
-(void) resetAll {
    cache = 0.0;
    hasCache = NO;
    [self reset];
}

-(void) display: (NSString * ) display {
    [dispbox setTitleWithMnemonic :display ];
}
-(void) displayError: (NSInteger) ErrorID {
    isError = ErrorID;
    NSString * ErrorMsg;
    switch (ErrorID) {
        case 1:
            ErrorMsg = [NSString stringWithFormat: @"除数不能为0!"];
            break;
        default:
            ErrorMsg = @"";
            break;
    }
    [self display:ErrorMsg];
    [self debugInfo:ErrorMsg];
    [self reset];
}
-(void) displayResult: (NSString * ) Result {
    [self display: Result];
}


-(void) setStatusInfo: (id) ctrl title: (NSString *) title {
    [ctrl setTitleWithMnemonic:title];
}
// 缓存操作
-(void) saveCache {
    if ( opi==0 ) {
        cache = op1;
    } else {
        cache = [opc doubleValue];
    }
    hasCache = YES;
    [self setStatusInfo:st_Cache title:@"M"];
}
-(void) readCache {
    if ( hasCache == YES ) {
        if ( opi == 0 ) {
            op1 = cache;
        } else {
            op2 = cache;
        }
        opc = [NSString stringWithFormat:@"%g",cache];
        [self displayResult: opc];
        [self debugInfo:@"==readCache===\n"];
    }
}
-(void) clearCache {
    cache = 0;
    hasCache = NO;
    [self setStatusInfo:st_Cache title:@""];
}

// 命令操作
-(void) inputACommand:(NSInteger) cmd {
    [self debugInfo:[NSString stringWithFormat:@"current commend is %ld", cmd]];
    switch (cmd) {
        case 1: // press CE reset
            [self reset];
            break;
        case 2: // press MC for Clear MEM Cache
            //[self display:@"测试清除内存"];
            [self clearCache];
            break;
        case 3: // press M+ for Save current Num to MEM Cache
            //[self display:@"测试内存保存"];
            [self saveCache];
            break;
        case 4: // press MR for Read MEM Cache to current Number
            [self readCache];
            break;
        default: // other none support
            break;
    }
}

// 函数操作
-(void) inputAFunction:(NSInteger) fun {
    NSLog(@"%ld", fun);
}

// 只处理当前操作数
-(void) inputANumber:(NSInteger) number {
    if ( [opc length]>=4 ) {
        return;
    }
    if ( number==99 ) {
        // 输入小数点
        if ( hasPoint==NO ) {
            if ( [opc intValue]==0 ) {
                opc = @"0";
            }
            opc = [NSString stringWithFormat:@"%@.",opc];
            hasPoint = YES;
        }
    } else {
        // 输入数字
        if ( hasPoint==YES ) {
            opc = [NSString stringWithFormat:@"%@%ld", opc, number];
        } else {
            if ( [opc intValue]==0 ) {
                if ( number>0 ) {
                    opc = [NSString stringWithFormat:@"%ld", number];
                }
            } else {
                opc = [NSString stringWithFormat:@"%@%ld", opc, number];
            }
        }
    }
    if ( opi == 0 ) {
        op1 = [opc doubleValue];
    } else {
        op2 = [opc doubleValue];
    }
    [self debugInfo:[NSString stringWithFormat:@"当前操作数 %@\n",opc]];
    //lastInput=1;
    [self displayResult: opc];
}

// 输入操作符
-(void) inputAOperator:(NSInteger) opt{
    double _result = 0;
    if ( opt==0 ) {
        // equl
        if ( lastOp<0 ) {
            if ( [opc doubleValue]!=0.0 ) {
                result = [opc doubleValue];
                opc = @"";
            }
            _result = result;
        } else {
            _result = [self getResult:op1 :op2 :lastOp];
            result = _result;
        }
        opi = 0;
        op1 = result;
        op2 = 0;
        opc = @"";
    } else if ( opt<5 ) {
        // plus sub muilt div
        if ( lastOp==-1 ) {
            _result = [opc doubleValue];
            result = _result;
        } else if ( lastOp==0 ) {
            if ( [opc doubleValue]!=0.0 ) {
                result = [opc doubleValue];
                opc = @"";
            }
            _result = result;
        } else {
            if ( lastOp==4 && opt==4 && [opc length]==0 ) {
                op2 = 1;
                //[self debugInfo:[NSString stringWithFormat:@"连续点击除法操作！\n",opc]];
            }
            _result = [self getResult:op1 :op2 :lastOp];
            result = _result;
        }
        opi = 1;
        op1 = result;
        opc = @"";
        op2 = 0;
    } else {
        // functional addition
    }
    hasPoint = NO;
    lastOp = opt;
    
    if ( isError == 0 ) {
        [self displayResult: [NSString stringWithFormat:@"%g",_result]];
    } else {
        [self displayError:isError];
        isError = 0;
    }
    [self debugInfo:@"操作完成\n"];
}

// 获得运算结果
-(double) getResult:(double)number1 :(double)number2 :(NSInteger)operation {
    double _result = 0;
    switch ( lastOp ) {
        case 0:
            _result = number1;
            break;
        case 1:
            _result = number1 + number2;
            break;
        case 2:
            _result = number1 - number2;
            break;
        case 3:
            _result = number1 * number2;
            break;
        case 4:
            if ( number2 != 0 ) {
                _result = number1 / number2;
            } else {
                // ErrorID == 1 for Cant div 0
                isError = 1;
            }
            break;
        default:
            break;
    }
    return _result;
}

// --------------------------------------------

// Press a Command Button {C|M+|MR}
-(IBAction) inputCommand:(id) sender {
    [self inputACommand: [sender tag]];
}
// Press a Numberic Button {0-9|.}
-(IBAction) inputNumberic:(id) sender {
    [self inputANumber: [sender tag]];
}
// Press a Operator Button {=|+|-|*|/}
-(IBAction) inputOperator:(id) sender{
    [self inputAOperator: [sender tag]];
}
// Press a Functional Button 
-(IBAction) inputFunction:(id) sender{
    [self inputAFunction:[sender tag]];
}

// --------------------------------------------
@end
