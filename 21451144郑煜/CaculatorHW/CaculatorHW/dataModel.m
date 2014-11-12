//
//  dataModel.m
//  CaculatorHW
//
//  Created by StarJade on 14-11-8.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "DataModel.h"
#import "Calculator/InfixCalculator.h"
@interface DataModel(){
    InfixCalculator * calc;
    enum s_type{numOrM,opOrBracket,Other}cntType;
}

- (double)caculateExpression:(NSString *)expression;
- (void)addNumber;

@property (nonatomic)NSString* numberStr;
@end

// 该类的作用是将得到的字符转化为字符串表达式，并返回需要显示的函数
@implementation DataModel

bool isExistDot = false;
int countBracketL = 0;

@synthesize resultStr = _resultStr, expression = _expression;

@synthesize numberStr = _numberStr;

/// 初始化
- (instancetype)init{
    if (self = [super init]) {
        calc = [[InfixCalculator alloc] init];
        
        cntType = Other;
        isExistDot = false;
        countBracketL = 0;
        _resultStr = @"0";
        _expression = @"";
        
        _numberStr = @"#";
    }
    return self;
}


/*处理输入*/

// 处理数字和小数点
- (void)addDigit:(char)digit{
    
    // 忽略执行的情况
    
    /// 字符是点，且点已经存在
    if (digit == '.' && isExistDot) return;
    if (digit == '.') isExistDot = YES;
    
    /// 字符是零，且数字串为0
    NSComparisonResult r = [_numberStr compare:@"0"];
    if (digit == '0' && r == NSOrderedSame){
        [self setResultStr:[self numberStr]];
        return;
    }
    
    
    // 添加到数值串
    
    NSComparisonResult r2 = [_numberStr compare:@"#"];
    if (r2 == NSOrderedSame) { //如果数值串还是'#'
        if (digit == '.')
        {
            _numberStr = [[NSString alloc] initWithFormat:@"0."];
        }else{
            
            _numberStr = [[NSString alloc] initWithFormat:@"%c",digit];
        }
    }else{
        _numberStr = [_numberStr stringByAppendingFormat:@"%c",digit];
    }
    
    [self setResultStr:[self numberStr]];
    
    cntType = numOrM;
    
}

// 处理括号
- (void)addBracket:(char)bracket{
    
    // 忽略执行的情况
    if(bracket == ')' && countBracketL == 0) return;
    
    // 处理
    if (bracket == '(') {
        countBracketL++;
    }else{
        countBracketL--;
        
        //添加数值串
        [self addNumber];
    }
    
    // 添加到表达式
    _expression = [_expression stringByAppendingFormat:@"%c",bracket];
    cntType = opOrBracket;
}

// 处理运算符
- (void)addOperator:(char)operatr{

    
    //先添加数值串
    [self addNumber];
    
    // 添加到表达式
    _expression = [_expression stringByAppendingFormat:@"%c",operatr];
    
    cntType = opOrBracket;
    
}

/// 把数字串添加到表达式
- (void)addNumber{
    
    // 如果表达式最后的符号是')' 则不添加
    if (_expression.length > 0) {
        
        NSString *lastStr = [_expression substringFromIndex:(_expression.length-1)];
        NSComparisonResult r = [lastStr compare:@")"];
        
        if (r == NSOrderedSame) return;
    }
    
    // 添加数字串到表达式
    double number = [_resultStr doubleValue];
    _expression = [_expression stringByAppendingFormat:@"%g",number];
    _resultStr = @"0";
    _numberStr = @"#";
    isExistDot = NO;


}

// 处理存储操作
- (void)clearNumberStr{
    // 清空数值串缓存
    _numberStr = @"#";
    isExistDot = NO;
}

/*计算 result */

- (double)caculateExpression:(NSString *)expression{
    if (expression.length==0)return 0;
    NSDecimalNumber* num = [calc computeExpression: expression];
    return [num doubleValue];
}

/*提供输出*/

- (void)caculate{
    
    
    if (cntType == numOrM) {
        // 如果result中有数字则添加
        [self addNumber];
    }else{
        // 去掉表达式中多余的运算符
        if (_expression.length > 0) {
            
            NSString *lastStr = [_expression substringFromIndex:(_expression.length-1)];
            NSComparisonResult a = [lastStr compare:@"+"];
            NSComparisonResult b = [lastStr compare:@"-"];
            NSComparisonResult c = [lastStr compare:@"*"];
            NSComparisonResult d = [lastStr compare:@"/"];
            NSComparisonResult e = [lastStr compare:@"m"];
            
            if (a == NSOrderedSame || b == NSOrderedSame || c == NSOrderedSame
                || d == NSOrderedSame || e == NSOrderedSame) {
                _expression = [_expression substringToIndex:(_expression.length-1)];
            }
        }
    }

    // 补全括号
    while(countBracketL){
        _expression = [_expression stringByAppendingFormat:@"%c",')'];
        --countBracketL;
    }
    
    // 计算表达式
    double result = [self caculateExpression:_expression];
    _resultStr = [[NSString alloc] initWithFormat:@"%g",result];
    
    
    // 重新初始化
    _expression = @"";
    _numberStr = @"#";
    isExistDot = NO;
    
}



@end
