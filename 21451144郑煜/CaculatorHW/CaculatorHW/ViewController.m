//
//  ViewController.m
//  CaculatorHW
//
//  Created by StarJade on 14-11-8.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"
@interface ViewController (){
    DataModel *dataHandle;
}


// 定义一种枚举类型
enum s_preChar {num, op, bracketL, bracketR,blank};

// 添加类
@property (weak, nonatomic) IBOutlet UILabel *resultOut;
@property (weak, nonatomic) IBOutlet UILabel *expressionOut;
@property (weak, nonatomic) IBOutlet UILabel *memoryTagOut;

// 数字与小数点
- (IBAction)num0:(id)sender;
- (IBAction)num1:(id)sender;
- (IBAction)num2:(id)sender;
- (IBAction)num3:(id)sender;
- (IBAction)num4:(id)sender;
- (IBAction)num5:(id)sender;
- (IBAction)num6:(id)sender;
- (IBAction)num7:(id)sender;
- (IBAction)num8:(id)sender;
- (IBAction)num9:(id)sender;
- (IBAction)decimalPoint:(id)sender;


// 加减乘除与取余

//-
- (IBAction)opSub:(id)sender;
//+
- (IBAction)opAdd:(id)sender;
//÷
- (IBAction)opDivision:(id)sender;
//×
- (IBAction)opMultiplication:(id)sender;
// mod
- (IBAction)opMod:(id)sender;


// = 、 MC 、 M+ 、 M- 、 MR 、 ±

//=
- (IBAction)calResult:(id)sender;
//MC
- (IBAction)calMC:(id)sender;
//MR
- (IBAction)calMR:(id)sender;
//M+
- (IBAction)calMAdd:(id)sender;
//M-
- (IBAction)calMSub:(id)sender;
//±
- (IBAction)calOppositeNum:(id)sender;

// 括号

- (IBAction)addBracketL:(id)sender;
- (IBAction)addBracketR:(id)sender;

- (IBAction)allClean:(id)sender;

@end

@implementation ViewController


// 定义一个枚举变量 preChar
enum s_preChar preChar = blank;

// 动作过滤函数

//数字与小数点
- (void)numberActionFilter:(char)ch{
    
    //    按键失效条件
    if(preChar == bracketR) return;
    preChar = num;
    
    
    //    处理
    [dataHandle addDigit:ch];
    
    
    // 更新
    
    /// 表达式更新
    self.expressionOut.text = [dataHandle expression];
    /// 显示结果更新
    self.resultOut.text = [dataHandle resultStr];
    
    
}
//操作符
- (void)opActionFilter:(char)ch{
    
    // 按键失效条件
    if(preChar == op || preChar == bracketL) return;
    preChar = op;
    
    // 处理
    [dataHandle addOperator:ch];
    
    // 更新
    
    /// 表达式更新
    self.expressionOut.text = [dataHandle expression];
    /// 显示结果更新
    self.resultOut.text = [dataHandle resultStr];
}


// 系统函数

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化成员变量
    preChar = blank;
    memory = 0;
    
    // 初始化显示状态
    self.memoryTagOut.text = @"";
    self.expressionOut.text = @"";
    self.resultOut.text = @"0";
    
    //
    dataHandle = [[DataModel alloc] init];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 数字与小数点
- (IBAction)num0:(id)sender {
    [self numberActionFilter:'0'];
}

- (IBAction)num1:(id)sender {
    [self numberActionFilter:'1'];
}
- (IBAction)num2:(id)sender {
    [self numberActionFilter:'2'];
}
- (IBAction)num3:(id)sender {
    [self numberActionFilter:'3'];
}
- (IBAction)num4:(id)sender {
    [self numberActionFilter:'4'];
}
- (IBAction)num5:(id)sender {
    [self numberActionFilter:'5'];
}
- (IBAction)num6:(id)sender {
    [self numberActionFilter:'6'];
}
- (IBAction)num7:(id)sender {
    [self numberActionFilter:'7'];
}
- (IBAction)num8:(id)sender {
    [self numberActionFilter:'8'];
}
- (IBAction)num9:(id)sender {
    [self numberActionFilter:'9'];
}

- (IBAction)decimalPoint:(id)sender {
    [self numberActionFilter:'.'];
}


// 加减乘除与取余

//-
- (IBAction)opSub:(id)sender {
    [self opActionFilter:'-'];
}
//+
- (IBAction)opAdd:(id)sender {
    [self opActionFilter:'+'];
}
//÷
- (IBAction)opDivision:(id)sender   {
    [self opActionFilter:'/'];
}
//×
- (IBAction)opMultiplication:(id)sender {
    [self opActionFilter:'*'];
}
// mod
- (IBAction)opMod:(id)sender {
    [self opActionFilter:'m'];
}


// = 、 MC 、 M+ 、 M- 、 MR

//=
- (IBAction)calResult:(id)sender {
  
    // 计算
    [dataHandle caculate];
    
    // 更新
    
    /// 表达式更新
    self.expressionOut.text = [dataHandle expression];
    /// 显示结果更新
    self.resultOut.text = [dataHandle resultStr];
    
    // 初始化
    preChar = blank;
    
}


double memory;
//MC
- (IBAction)calMC:(id)sender {
    
//    处理
    [dataHandle clearNumberStr];
//    更新
    memory = 0;
    self.memoryTagOut.text = @"";
    self.resultOut.text = @"0";
}
//MR 读取暂存数
- (IBAction)calMR:(id)sender {
    
//    如果MR有效，那么点击它状态等效于输入一个数字
    NSComparisonResult r = [self.memoryTagOut.text compare:@"M"];
    if(r == NSOrderedSame)preChar = num;
    
//    存入数据
    NSString *str = [NSString stringWithFormat:@"%g",memory];
    [dataHandle setResultStr:str];
    
//    处理
    [dataHandle clearNumberStr];
    
//    更新
    self.resultOut.text = str;
}
//M+ 累加结果到暂存
- (IBAction)calMAdd:(id)sender {

    
    //    处理
    [dataHandle clearNumberStr];
    
    //    获取result
    double result = 0.0f;
    result = [[dataHandle resultStr] doubleValue];
    
    //    计算
    memory += result;
    
    //    更新
    if (memory == 0) {
        self.memoryTagOut.text = @"";
    }else{
        self.memoryTagOut.text = @"M";
    }
}
//M-
- (IBAction)calMSub:(id)sender {
    
    //    处理
    [dataHandle clearNumberStr];
    
    //    获取result
    double result = 0.0f;
    result = [[dataHandle resultStr] doubleValue];
    
    //    计算
    memory -= result;
    
    //    更新
    if (memory == 0) {
        self.memoryTagOut.text = @"";
    }else{
        self.memoryTagOut.text = @"M";
    }
}
//±
- (IBAction)calOppositeNum:(id)sender {
    [dataHandle clearNumberStr];// 清空number
    double r = [[dataHandle resultStr] doubleValue];
    r = r-2*r;
    [dataHandle setResultStr:[[NSString alloc] initWithFormat:@"%g",r]];
    self.resultOut.text = [dataHandle resultStr];
}


// 括号

- (IBAction)addBracketL:(id)sender {
    if (preChar == num || preChar == bracketR) return;
    preChar = bracketL;
    
    //    计算
    [dataHandle addBracket:'('];
    //    更新
    self.expressionOut.text = [dataHandle expression];
}

- (IBAction)addBracketR:(id)sender {
   
    if (preChar == op || preChar == blank || preChar == bracketL) return;
    preChar = bracketR;
    
    //    计算
    [dataHandle addBracket:')'];
    //    更新
    self.expressionOut.text = [dataHandle expression];
}

//AC
- (IBAction)allClean:(id)sender {
    
    //处理
    [dataHandle setExpression:@""];
    [dataHandle setResultStr:@"0"];
    [dataHandle clearNumberStr]; //清空number
    
    // 更新
    
    /// 表达式更新
    self.expressionOut.text = [dataHandle expression];
    /// 显示结果更新
    self.resultOut.text = [dataHandle resultStr];
    
    // 初始化
    preChar = blank;
    
}




@end