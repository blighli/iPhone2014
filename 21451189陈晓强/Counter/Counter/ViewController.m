//
//  ViewController.m
//  Counter
//
//  Created by 陈晓强 on 14/11/6.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "ViewController.h"
#import "Stack.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *expression;
@property (strong, nonatomic) NSMutableArray *postfixExpression;
@property (copy, nonatomic) NSMutableString *displaying;
@property (copy, nonatomic) NSMutableString *symbolLabel;
@property (copy, nonatomic) NSMutableString *memory;
@property (nonatomic) Boolean pointTag;
@property (nonatomic) Boolean rightBracketTag;
@property (nonatomic) Boolean leftBracketTag;
@property (nonatomic) Boolean symbolTag;
@property (nonatomic) Boolean equalTag;
@property (nonatomic) Boolean isMinus;
@property (nonatomic) NSUInteger commaTag;
@property (nonatomic) NSUInteger zeroTag;
@property (nonatomic) NSUInteger firstCount;
@property (nonatomic) NSUInteger secondCount;
@property (nonatomic) NSUInteger leftBracketCount;
@property (nonatomic) NSUInteger rightBracketCount;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *subButton;
@property (weak, nonatomic) IBOutlet UIButton *mulButton;
@property (weak, nonatomic) IBOutlet UIButton *divButton;
@property (weak, nonatomic) IBOutlet UIButton *modButton;
@property (weak, nonatomic) IBOutlet UIButton *memoryCleanButton;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _pointTag = true;
    _isMinus = false;
    _rightBracketTag = true;
    _leftBracketTag = true;
    _symbolTag = true;
    _equalTag = false;
    _displaying = [[NSMutableString alloc] initWithCapacity:11];
    _expression = [NSMutableArray array];
    _symbolLabel = [[NSMutableString alloc] init];
    _postfixExpression = [NSMutableArray array];
    [_displaying setString:@"0"];
    _display.text = _displaying;
    _display.lineBreakMode = NSLineBreakByClipping;
    _display.adjustsFontSizeToFitWidth = YES;
    _commaTag = 0;
    _zeroTag = 0;
    _leftBracketCount = 0;
    _rightBracketCount = 0;
    _memory = [[NSMutableString alloc] initWithString:@"0"];
}
- (IBAction)memoryClean:(id)sender {
    [_memory setString:@"0"];
    [_memoryCleanButton.layer setBorderWidth:0];
}
- (IBAction)memoryAdd:(id)sender {
    [self setButtonBounds:_memoryCleanButton];
    double x = [_memory doubleValue];
    double y = [_display.text doubleValue];
    x = x + y;
    _memory = [NSMutableString stringWithFormat:@"%.8f",x];
    [self clearZero:_memory];
}
- (IBAction)memorySub:(id)sender {
    [self setButtonBounds:_memoryCleanButton];
    double x = [_memory doubleValue];
    double y = [_display.text doubleValue];
    x = x - y;
    _memory = [NSMutableString stringWithFormat:@"%.8f",x];
    [self clearZero:_memory];
}
- (IBAction)memoryRead:(id)sender {
    _zeroTag = 0;
    [self clearButton];
    _display.text = _memory;
    [_displaying setString:_memory];
    NSRange range= [_displaying rangeOfString:@"."];
    if (range.location == NSNotFound) {
    }else{
        _pointTag = false;
    }
}


- (void) printDigit:(NSUInteger) digit
{
    _symbolTag = true;
    [self judgeSign:digit];
//    [self judgeComma];
    [_displaying appendString:[NSString stringWithFormat:@"%lu",digit]];
    _display.text = _displaying;
}

- (void)judgeSign:(NSUInteger) digit
{
    if (_equalTag) {
        _equalTag = false;
        _display.text = @"0";
    }
    if ([_displaying isEqualToString:@"0"] || [_displaying isEqualToString:@"-0"]) {
        [self clearButton];
        if ([_displaying isEqualToString:@"0"]) {
            [_displaying setString:@""];
        }else{
            [_displaying setString:@"-"];
        }
        if (_zeroTag == 0) {
            if (_leftBracketTag) {
                [_expression addObject:[_symbolLabel copy]];
                [_symbolLabel setString:@""];
                 _rightBracketTag = true;
            }
            _leftBracketTag = true;
            
        }
        _zeroTag++;
    }
}



- (IBAction)insertNumber:(id)sender {
    if ([_displaying length] < 9 || (_isMinus && [_displaying length] < 10)||
        (!_pointTag && [_displaying length] < 10)
        || (!_pointTag&&_isMinus && [_displaying length] < 11)) {
        NSUInteger digit = [sender tag];
        [self printDigit:digit];
    }
}

- (IBAction)percent:(id)sender {
    
    if (_symbolTag) {
        double s = [_display.text doubleValue];
        s = s/100.0;
        NSMutableString * answer = [NSMutableString stringWithFormat:@"%.8f",s];
        [_displaying setString:[self clearZero:answer]];
        _display.text = _displaying;
        NSRange range= [_displaying rangeOfString:@"."];
        if (range.location == NSNotFound) {
        }else{
            _pointTag = false;
        }
    }else{
        _zeroTag = 0;
        [_displaying setString:@"0"];
        _display.text = _displaying;
        [self judgeSign:0];
        
        _symbolTag = true;
    }
}

- (IBAction)symbolControl:(UIButton *)sender {
    _zeroTag = 0;
    if (_equalTag) {
        [_displaying setString:[NSMutableString stringWithFormat:@"%@",_display.text]];
        _equalTag = false;
    }
    
    if (_rightBracketTag && _symbolTag) {
        [_expression addObject:[_displaying copy]];
        [_displaying setString:@"0"];
        
        _pointTag = true;
        _commaTag = 0;
    }
    [self setButtonBounds:sender];
    _symbolTag = false;
    switch (sender.tag) {
        case 1://"+"
            [_symbolLabel setString:@"+"];
            break;
        case 2://"-"
            [_symbolLabel setString:@"-"];
            break;
        case 3://"x"
            [_symbolLabel setString:@"x"];
            break;
        case 4://"÷"
            [_symbolLabel setString:@"/"];
            break;
        break;
    }
   
}

- (void)setButtonBounds:(UIButton *) sender{
    [self clearButton];
    [sender.layer setMasksToBounds:YES];
    [sender.layer setBorderWidth:1.0];
    CGColorRef colorref =  [UIColor blackColor].CGColor;
    [sender.layer setBorderColor:colorref];
    
}


- (IBAction)positiveOrNegative:(id)sender {
    if (_equalTag) {
        [_displaying setString:_display.text];
    }
    NSString *test = [_displaying substringToIndex:1];
    if ([test isEqualToString:@"-"]) {
        [_displaying deleteCharactersInRange:NSMakeRange(0, 1)];
        _isMinus = false;
    }else{
        [_displaying insertString:@"-" atIndex:0];
        _isMinus = true;
    }
        _display.text = _displaying;
}
- (IBAction)rightBracket:(id)sender {
    if(_rightBracketCount < _leftBracketCount)
    {
        _rightBracketCount++;
    _rightBracketTag = false;
    [_expression addObject:[_displaying copy]];
    [_displaying setString:@"0"];
    _pointTag = true;
    _commaTag = 0;
    [_expression addObject:@")"];
    }
}
- (IBAction)leftBracket:(id)sender {
    if(!_symbolTag)
    {
        [_expression addObject:[_symbolLabel copy]];
        _symbolTag = true;
    }
    _leftBracketCount++;
    [_expression addObject:@"("];
    _leftBracketTag = false;
    
}

- (IBAction)point:(id)sender {
    
    if (_pointTag) {
        if ([_displaying isEqualToString:@"0"] || [_displaying isEqualToString:@"-0"]) {
            [self clearButton];
            if (_leftBracketTag) {
                [_expression addObject:[_symbolLabel copy]];
                [_symbolLabel setString:@""];
            }
            _rightBracketTag = true;
            _leftBracketTag =true;
        }
        [_displaying appendString:@"."];
        _display.text = _displaying;
        _pointTag = false;
    }
    
}

- (IBAction)delete:(id)sender {
    if (_equalTag) {
        [_displaying setString:_display.text];
    }
    NSRange range;
    range.length = 1;
    range.location = [_displaying length] - 1;
    [_displaying deleteCharactersInRange:range];
    if([_displaying isEqualToString:@""] || [_displaying isEqualToString:@"-"])
    {
       [_displaying setString:@"0"];
    }
    _display.text = _displaying;
}

- (IBAction)allClean:(id)sender {
    [self clearButton];
    [_displaying setString:@"0"];
    _display.text = _displaying;
    _pointTag = true;
    _commaTag = 0;
    [_expression removeAllObjects];
    _zeroTag = 0;
    _symbolTag = true;
}

- (void)clearButton{
    [_addButton.layer setBorderWidth:0];
    [_subButton.layer setBorderWidth:0];
    [_mulButton.layer setBorderWidth:0];
    [_divButton.layer setBorderWidth:0];
    [_modButton.layer setBorderWidth:0];
}


- (IBAction)equalAnswer:(id)sender {
    while (_leftBracketCount != _rightBracketCount) {
        [_expression addObject:@")"];
        _rightBracketCount++;
    }
    if (!_equalTag) {
        if (_rightBracketTag) {
            [_expression addObject:[_displaying copy]];
        }
        _rightBracketTag = true;
        [self middleToPostfix];
        _equalTag = true;
        [_display setText:[self finalResult]];
        [self backToInit];
    }
    
    
    
//    for(NSString *test in _postfixExpression)
//    {
//        NSLog(@"%@",test);
//    }
}

- (void)backToInit
{
    [self clearButton];
    _symbolTag = true;
    [_displaying setString:@"0"];
    _pointTag = true;
    _commaTag = 0;
    _zeroTag = 0;
    [_expression removeAllObjects];
    [_postfixExpression removeAllObjects];
}
- (NSString *)finalResult
{
    NSMutableString * finalResult;
    Stack *stack = [[Stack alloc] init];
    for(NSString *test in _postfixExpression)
    {
        if ([self isNumber:test]) {
            [stack push:test];
        }else
        {
            NSString * x = [stack pop];
            NSString * y = [stack pop];
            NSString * result = [self match:x andSec:y andSymbol:test];
            if ([result isEqualToString:@"Error"]) {
                return result;
            }
            [stack push:result];
        }
    }
    finalResult = [NSMutableString stringWithFormat:@"%@",[stack pop]];
    [self formatResult:finalResult];
    return  finalResult;
}

- (NSMutableString *)formatResult:(NSMutableString *)finalResult
{
    NSRange range = [finalResult rangeOfString:@"."];
//    NSMutableString *result;
    if(range.location == NSNotFound)
    {
        [finalResult appendString:@"."];
         range = [finalResult rangeOfString:@"."];
    }
    if (range.location > 8 ||
        (range.location > 7 &&[finalResult length] > 9)||
    ( [finalResult rangeOfString:@"-"].location != NSNotFound && [finalResult length] > 10 )
        ||     ( [finalResult rangeOfString:@"-"].location == NSNotFound && [finalResult length] > 9 ))
    {
        [finalResult deleteCharactersInRange:range];
        if ([finalResult rangeOfString:@"-"].location == NSNotFound) {
            [finalResult insertString:@"." atIndex:1];
            NSString *s = [finalResult substringWithRange:NSMakeRange(0, 8)];
            [finalResult setString:s];
            [finalResult appendString:@"e"];
            [finalResult appendFormat:@"%lu",range.location - 1];
            
        }else{
            [finalResult insertString:@"." atIndex:2];
            NSString *s = [finalResult substringWithRange:NSMakeRange(0, 9)];
            [finalResult setString:s];
            [finalResult appendString:@"e"];
            [finalResult appendFormat:@"%lu",range.location - 1];
        }
    }else{
        [finalResult deleteCharactersInRange:range];
    }
    NSLog(@"finalResult = %@",finalResult);
    return finalResult;
}
- (NSString *)match:(NSString *)first andSec:(NSString *)second andSymbol:(NSString *)symbol
{
    NSMutableString *answer;
    double x = [first doubleValue];
    double y = [second doubleValue];
    NSLog(@"x = %.1f y = %.1f",x,y);
    double matchResult = 0;
    const char * tag = [symbol UTF8String];
    switch (tag[0]) {
        case '+':
            matchResult = x + y;
            break;
        case '-':
            matchResult = y - x;
            break;
        case 'x':
            matchResult = x * y;
            break;
        case '/':
            if(x == 0)
                return @"Error";
            matchResult = y / x;
            break;
    }
    answer = [NSMutableString stringWithFormat:@"%.8f",matchResult];
    NSLog(@"answer = %@",answer);
    
    return [self clearZero:answer];
}

- (NSString *)clearZero:(NSMutableString *)mutableAnswer
{
    NSString * result;
    while ([mutableAnswer characterAtIndex:[mutableAnswer length] - 1] == '0') {
        [mutableAnswer deleteCharactersInRange:NSMakeRange([mutableAnswer length] - 1, 1)];
    }
    
    if ([mutableAnswer characterAtIndex:[mutableAnswer length] - 1] == '.') {
        [mutableAnswer deleteCharactersInRange:NSMakeRange([mutableAnswer length] - 1, 1)];
    }
    result = (NSString *)mutableAnswer;
    return result;
}
- (void)middleToPostfix
{
    Stack *stack = [[Stack alloc] init];
    for(NSString *test in _expression)
//        for(int i = 0 ; i < [_expression count]; i++)
    {
        NSLog(@"%@",test);
        if ([self isNumber:test]) {
//            NSLog(@"comein");
            [_postfixExpression addObject:test];
        }else{
            if ([stack isEmpty]) {//栈空
                NSLog(@"empty push %@",test);
                [stack push:test];
            }else if([test isEqualToString:@")"])//判断右括号
            {
                NSString *topString = [stack pop];
                NSLog(@"topString = %@",topString);
                while (![topString isEqualToString:@"("]) {
                    NSLog(@"top = %lu",stack.stackTop);
                    NSLog(@"topString = %@",topString);
                    [_postfixExpression addObject:[topString copy]];
                    topString = [stack pop];
                }
            }else if ([self judgePriority:[stack getTop]] < [self judgePriority:test] || [self judgePriority:[stack getTop]] == 3) //大于栈内符号优先级
            {
                NSLog(@"push %@",test);
                [stack push:test];
            }else if ([self judgePriority:[stack getTop]] >= [self judgePriority:test] && ![[stack getTop] isEqualToString:@"("])//小于栈内符号优先级
            {
                [_postfixExpression addObject:[stack pop]];
                while (![stack isEmpty] &&
                       [self judgePriority:[stack getTop]] >= [self judgePriority:test]
                       && ![[stack getTop] isEqualToString:@"("]) {
                    [_postfixExpression addObject:[stack pop]];
                }
                [stack push:test];
            }
        }
        
    }
    while (![stack isEmpty]) {
        [_postfixExpression addObject:[stack pop]];
    }
    NSLog(@"oveerr");
//    return _postfixExpression;
}

- (BOOL)isNumber:(NSString *)test
{
    if ([test isEqualToString:@"+"] ||
        [test isEqualToString:@"-"] ||
        [test isEqualToString:@"x"] ||
        [test isEqualToString:@"/"] ||
        [test isEqualToString:@"%"] ||
        [test isEqualToString:@"("] ||
        [test isEqualToString:@")"] ) {
        return NO;
    }else{
        return YES;
    }
}

- (NSUInteger)judgePriority:(NSString *)symbol
{
    const char * tag = [symbol UTF8String];
    switch (tag[0]) {
        case '+':
        case '-':
            return 1;
        case 'x':
        case '%':
        case '/':
            return 2;
        case '(':
        case ')':
            return 3;
    }
    return 0;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
