//
//  ViewController.h
//  calc
//
//  Created by xufei on 14/11/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(retain,nonatomic)IBOutlet UILabel *label;
@property(retain,nonatomic)IBOutlet UILabel *flag_;

@property BOOL flag;
@property BOOL op;
@property double op1,op2;
@property long control;
@property NSString *keep;
@property BOOL isequal;
@property bool fuck;

-(IBAction)buttonInputNu:(id)sender;

-(IBAction)buttonInputOp:(id)sender;

-(IBAction)buttonInputflag:(id)sender;

-(IBAction)buttonInputDel:(id)sender;

-(IBAction)buttonsum:(id)sender;

//( )
-(IBAction)button90:(id)sender;


-(void)getnumberBy:(BOOL)o;

-(NSString *)calcByop:(NSString*)ope;

-(BOOL)clearscreen;


@end
