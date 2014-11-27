//
//  MyTableViewCell.m
//  TaskList
//
//  Created by 焦守杰 on 14/11/6.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell
@synthesize textField;
@synthesize tableViewController;
- (void)awakeFromNib {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressRecognizer:)];
 //   [longPressGesture setMinimumPressDuration:1];
    [self addGestureRecognizer:longPressGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tapGestureHandler:(UIGestureRecognizer *)sender{          //修改事件
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alert setTag:1];
    [alert show];
    UITextField *tf=[alert textFieldAtIndex:0];
   // [tf becomeFirstResponder];
}
-(IBAction)longPressRecognizer:(id)sender{                 //删除事件
    UILongPressGestureRecognizer *g=(UILongPressGestureRecognizer*)sender;
    if(g.state==UIGestureRecognizerStateBegan){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除此项任务？" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alert setTag:2];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView tag]==1){
        if(buttonIndex==1){
            UITextField *tf=[alertView textFieldAtIndex:0];
            [tf becomeFirstResponder];
            NSString *s=[tf text];
            NSString* res = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if([res length]!=0)
                [tableViewController modifyObject:res At:rowNum];
            [tf resignFirstResponder];

        }
    }else{
        if(buttonIndex==1)
            [tableViewController deleteObjectAt:rowNum];
    }
}
-(void)setRowNum:(int)_rowNum{
    rowNum=_rowNum;
}

@end
