

#import <Foundation/Foundation.h>

@interface CalCore : NSObject {
    IBOutlet NSTextField * dispbox;
    IBOutlet NSTextField * st_Cache;

    double op1; // 存储操作数 1
    double op2; // 存储操作数 2
    double cache;   // 缓存
    double result;  // 上一次计算的结果缓存
    
    NSString * opc; // 当前操作数
    
    NSInteger lastOp;   // 上一次操作
    NSInteger isError;  // 是否存在错误
    int opi;        // 当前操作数序号
    bool hasPoint;   // 是否输入了小数点
    int lastInput;  // 最后输入的类型

    BOOL hasCache; // 是否有缓存
    
    BOOL debug; // 调度选项
}

// --------------------------------------------
-(id) init;
-(void)dealloc;

// 调试输出
-(void) debugInfo:(NSString*)info;

// 重置状态
-(void) reset;
-(void) resetAll;

// 通用的显示刷新
-(void) display: (NSString * ) display;
-(void) displayResult: (NSString * ) Result;
-(void) displayError: (NSInteger) ErrorID;

-(void) setStatusInfo: (id) ctrl title: (NSString * ) title;

// 缓存操作
-(void) saveCache;
-(void) readCache;
-(void) clearCache;

// 核心处理方法
-(void) inputACommand:(NSInteger) cmd;
-(void) inputANumber:(NSInteger) number;
-(void) inputAOperator:(NSInteger) opt;
-(void) inputAFunction:(NSInteger) fun;


// 计算结果
-(double) getResult
    :(double) number1
    :(double) number2
    :(NSInteger) operation;
// --------------------------------------------
// 按钮的回调
//-(IBAction) callDisplay:(id)sender;

-(IBAction) inputCommand:(id) sender;
-(IBAction) inputNumberic:(id) sender;
-(IBAction) inputOperator:(id) sender;
-(IBAction) inputFunction:(id) sender;


// --------------------------------------------
@end
