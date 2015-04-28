//
//  DetailController.m
//  Notes
//
//  Created by 陈聪荣 on 14/11/18.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "DetailStringViewController.h"

@implementation DetailStringViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化note类型
    if(self.detailItem){
        [self.txtView setText:[(Note*)self.detailItem content]];
    }
    //给textview对象添加圆角边框
    self.txtView.layer.borderColor = UIColor.grayColor.CGColor;
    self.txtView.layer.borderWidth = 1;
    self.txtView.layer.cornerRadius = 6;
    self.txtView.layer.masksToBounds = YES;
    //[self.txtView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
}
- (void)viewDidAppear:(BOOL)animated{
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.txtView becomeFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveOnclick:(id)sender
{
    NSMutableDictionary *dic = nil;
    NoteBiz *bl = [[NoteBiz alloc] init];
    if(self.detailItem){ //编辑状态
        Note *note = (Note*)self.detailItem;
        note.content = self.txtView.text;
        dic = [bl edit: note];
    }else{//新增状态
        Note *note = [[Note alloc] init];
        note.date = [[NSDate alloc] init];
        note.content = self.txtView.text;
        note.type = 1;
        dic = [bl createNote: note];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:nil userInfo:nil];
    [self.txtView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
