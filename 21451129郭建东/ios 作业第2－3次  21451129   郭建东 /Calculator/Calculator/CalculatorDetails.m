//
//   CalculatorDetails.m
//   Calculator
//
//  Created by GUO on 14-11-05.
//  Copyright (c) 2014年 GUO
//

#import "CalculatorDetails.h"

@interface CalculatorDetails ()

    @property (nonatomic,strong)NSMutableArray        *dealedArray;
    @property (nonatomic,strong)NSDictionary          *PriorityArray;
    @property(nonatomic,strong)NSMutableArray        *brakectArray;
    @property BOOL Singlebrakect;
@end

@implementation CalculatorDetails
-(id)init

{
    
    if (self =  [super  init]){
                                     //优先级设置 规定0优先级最大，依次减小
        _PriorityArray=@{@"(":@0, @"^":@1,@"x":@2,@"/":@2, @"+":@3, @"-":@3,@")":@4,  @"#": @5 };
    }
    _Singlebrakect = NO;
    return  self;
}

-(NSString*)calculatingWithString:(NSString *)str andAnswerString:(NSString *)answerString
{
   
    if (_Singlebrakect) {
        _brakectArray = [NSMutableArray arrayWithArray:_dealedArray];
    }

    [self handleInputString:str andAnswerString:answerString];
 
    [_dealedArray    addObject:@"#"];
    [_dealedArray   insertObject:@"#"atIndex:0];
    
    NSInteger   count = [_dealedArray  count];
    
    NSString *finalResult = [NSString  string];
    for (int i= (int)count - 2; i>= 0;i--)
    { 
        
        NSString *str1 = [_dealedArray  objectAtIndex:i];
        if ([str1    isEqualToString:@"#"]) {
            finalResult = [_dealedArray   objectAtIndex:1];
            if ([_dealedArray   count]>3) {
                finalResult =@"error";
            }
            return finalResult;
        }
        if ([str1  isEqualToString:@"("])
        {
            
            
            NSString *subResult = [NSString  string];
            for (NSInteger j = i + 1; j <= count - 1; j++)
            {
                NSString *str2 = [_dealedArray   objectAtIndex:j];
                
                if ([str2   isEqualToString:@"#"]) {
                    finalResult =@"error";
                    return   finalResult;
                }
                
                if ([str2    isEqualToString:@")"])
                {
                    NSRange range =NSMakeRange(i+1, j-i-1);
                   
                    NSArray *subArray = [_dealedArray   subarrayWithRange:range];
                    NSMutableArray *arr = [NSMutableArray    arrayWithArray:subArray];
                    subResult = [self calculateNumbers:arr];
                    if ([subResult    isEqualToString:@"error"]) {
                        finalResult =@"error";
                        return  finalResult;
                    }
            
                    range =NSMakeRange(i,j - i +1);
                    [_dealedArray    replaceObjectsInRange:range
                                    withObjectsFromArray: [NSArray arrayWithObject:subResult]];
                    count = [_dealedArray  count];
                    i = (int)count - 1 ;
                    break;
                }
            }
        }
    }
    return finalResult;   
}




- (void)handleInputString:(NSString *)inputStr andAnswerString:(NSString *)answerString{
    long int  length = [inputStr  length];
    _dealedArray =  [NSMutableArray array];
    int  i  =  0;
    UniChar c = [inputStr  characterAtIndex:0];
    if (c =='-'|| c == '+'||c == 'x'||c =='/'|| c== '^')
    {
       
        if (length >1)
        {
            UniChar c1 = [inputStr  characterAtIndex:1];
            if (c1 >='0'&&c1 <= '9')
            {
                [_dealedArray addObject:answerString];
                [_dealedArray addObject:[NSString   stringWithCharacters:&c  length:1]];
                i++;
            }
        }
    }
    NSMutableString *mString = [NSMutableString  string];
    while (i< length)
    {
        c = [inputStr   characterAtIndex:i];
        if ((c >='0'&&c <= '9') || c =='.')
        {
        
            [mString  appendFormat:@"%c",c];
            if (i == length -1) {
                [_dealedArray addObject:mString];
               // clean the string
                mString = [NSMutableString   string];
            }
        }
        else
        {
            if (![mString isEqualToString:@""]) {
                
                [_dealedArray  addObject:mString];
                mString = [NSMutableString  string];
            }
            if (c =='(')
            {
                if (i>0)
                {
                    UniChar xc = [inputStr   characterAtIndex:i-1];
                    if (xc >='0'&&xc <= '9') {  //"7（8+2）"这种省略乘号的写法，要将乘号补充完整
                        [_dealedArray   addObject:@"x"];
                        [_dealedArray   addObject:@"("];
                        i++;
                        continue;
                    }
                }
                if (i< length -1)
                    
                {
                    UniChar c1 = [inputStr  characterAtIndex:i+1];
                    if (c1 =='-'|| c1 == '+')
                    {// the situation of the negaitive -
                        [_dealedArray addObject:@"("];
                        [_dealedArray addObject:@"0"];
                        i++;
                        continue;
                    }
                }
            }
            else  if (c == ')')
            {
                if (i< length -1)
                {
                    UniChar xc = [inputStr   characterAtIndex:i + 1];
                    if (xc >='0'&&xc <= '9') {
                        //the situation of *
                        [_dealedArray   addObject:@")"];
                        [_dealedArray  addObject:@"x"];
                        i++;
                        continue;
                    }
                }
            }
            else if (c == 'c' || c == 's'|| c == 'l'){
                NSString *tempStr = [NSString string];
                NSString *single = [NSString string];
                for (int j = i + 1; j < length ;j++ ) {
                    UniChar tempx = [inputStr characterAtIndex:j];
                    if ((tempx >='0'&&tempx <= '9') || tempx =='.') {
                       tempStr = [tempStr stringByAppendingString:[NSString stringWithFormat:@"%c",tempx]];
                    }else if (tempx == '('){
                        _Singlebrakect = YES;
                        NSString *string = [inputStr substringFromIndex:j];
                        for (int k = j+1; k < length; k++) {
                            
                            if ([string rangeOfString:@")"].location) {
                                int location = (int)[string rangeOfString:@")"].location;
                                NSRange range = NSMakeRange(0, location + 1);
                                string = [string substringWithRange:range];
                                single =string;
                                break;
                            }
                        }
                        tempStr = [self calculatingWithString:string andAnswerString:answerString];
                        _dealedArray = [NSMutableArray arrayWithArray:_brakectArray];
                        break;
                    }
                    else
                        break;
                }
                if (tempStr.length >0 &&![tempStr isEqualToString:@"error"]) {
                    if (_Singlebrakect) {
                        i += single.length + 1;
                        _Singlebrakect = NO;
                    }else{
                        i = i + (int)[tempStr length] + 1;
                    }
                    double temp =[tempStr doubleValue];
                    switch (c) {
                            //cos
                        case 'c':
                            temp = cos(temp * M_PI/180.0);
                            break;
                            //sin
                        case 's':
                            temp = sin(temp * M_PI/180.0);
                            break;
                        case 'l':
                            temp = log10(temp);
                            break;
                       default:
                            break;
                    }
                    [_dealedArray addObject:[NSString stringWithFormat:@"%g",temp]];
                    continue;
                }
                
            }
            [_dealedArray addObject:[NSString stringWithCharacters:&c length:1] ];
        }
        i++;
    }
    [_dealedArray   insertObject:@"("atIndex:0];
    [_dealedArray   addObject:@")"];
    
}

- (NSString *)calculateNumbersWithOperator:(NSString *)operator betweenDouble:(double)x1 andDoule:(double)x2
{
    double  aresult =0;
    unichar  ch = [operator  characterAtIndex:0];
    NSString *string = [NSString  string];
    BOOL   isOK = YES;
    switch (ch)
    {
        case '+':
            aresult = x1 + x2;
            break;
        case '-':
            aresult = x1 - x2;
            break;
        case 'x':
            aresult = x1 * x2;
            break;
        case 'd':
            if (x2 ==0){
                string =@"error";
                isOK =NO;
            }
            aresult = x1 / x2;
            break;
        case '^':
            aresult = pow(x1, x2);
            break;
        default:
            isOK =NO;
            string =@"error";
            break;
    }
    if (isOK ==YES){
            string = [NSString stringWithFormat:@"%g",aresult];
    }
    return string;
}


- (NSString *)calculateNumbers:(NSMutableArray *)numberArray{
    NSMutableArray *operandStackArray = [NSMutableArray arrayWithObject:@"error"];// OPeration Stack
    NSMutableArray *stack2 = [NSMutableArray arrayWithObject:@"#"];
    
    NSString *result = [NSString string];
    
    [numberArray addObject:@"#"];

    while (1)
    {
        
        NSString *subStr1 = [numberArray    objectAtIndex:0];
        UniChar c = [subStr1   characterAtIndex:0];
     
        if ((subStr1.length > 1 && [subStr1 hasPrefix:@"-"])||(c >='0'&&c <= '9')) {
         
            [operandStackArray insertObject:subStr1 atIndex:0];
        
            [numberArray   removeObjectAtIndex:0];
        }
        else
        {
            
            NSString *topStack2 = [stack2   objectAtIndex:0];
            if ([subStr1   isEqualToString:@"#"] && [topStack2   isEqualToString:@"#"]){
               
                result = [operandStackArray  objectAtIndex:0];
                break;
            }
            
            NSInteger one = [[_PriorityArray objectForKey:subStr1]integerValue];
            
            NSInteger two = [[_PriorityArray objectForKey:topStack2]integerValue];
            
            if (one < two) {
                [stack2 insertObject:subStr1 atIndex:0];
                [numberArray   removeObjectAtIndex:0];
            }
            else
            {
                
                NSString *strX = [operandStackArray  objectAtIndex:0];
                if ([strX   isEqualToString:@"error"]) {
                    result =@"error";
                    break;
                }
                double x1 = [strX  doubleValue];
                [operandStackArray removeObjectAtIndex:0];
                strX = [operandStackArray  objectAtIndex:0];
                if ([strX   isEqualToString:@"error"]) {
                    result =@"error";
                    break;
                }
                double x2 = [strX doubleValue];
                [operandStackArray removeObjectAtIndex:0];
                [stack2 removeObjectAtIndex:0];
               
                result = [self calculateNumbersWithOperator:topStack2 betweenDouble:x2 andDoule:x1];
                if ([result   isEqualToString:@"error"]) {
                   
                    break;
                }
                [operandStackArray insertObject:result atIndex:0];
                
            }
        }
    }
    return result;
}

@end
