//
//  ViewController.h
//  Calculator
//
//  Created by 顾准新 on 14-11-3.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import <UIKit/UIKit.h>
#define maxNumberCount 10

#define KMemoryClear 20
#define KMemoryPlus 21
#define KMemorySub 22
#define KMemoryR 23

@interface ViewController : UIViewController{
    double currentNum;
    
    //NSDictionary *priority;
    NSString *memory;
    NSMutableArray *digitalStack;
    NSMutableArray *operatorStack;
    NSMutableArray *resultStack;
    NSMutableArray *right;

}

@property (weak, nonatomic) IBOutlet UILabel *resultDisplay;
@property (weak, nonatomic) IBOutlet UILabel *processDisplay;

@end

//创建Stack
@interface NSMutableArray (myStack)

-(void)push:(NSObject*)parm;
-(id)peek;
-(id)pop;
-(void) insertAtHead:(NSObject*)param;
-(id) peekAtHead;
-(id) popAtHead;
-(void)clear;

@end



