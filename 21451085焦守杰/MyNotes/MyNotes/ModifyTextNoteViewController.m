//
//  ModifyTextNoteViewController.m
//  MyNotes
//
//  Created by 焦守杰 on 14/11/16.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "ModifyTextNoteViewController.h"



@implementation ModifyTextNoteViewController
@synthesize textNoteData;
//@synthesize textViewContent ;


//-(id)initWithTextViewContent:(NSString*)s{
//    self=[super init];
//    if(self){
//        self.textViewContent=s;
//    }
//    return self;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dbu=[[DatabaseUtil alloc]init];
    _textView=(UITextView*)[[self view] viewWithTag:1];
    NSLog(@"=-=-%@",textNoteData.note);
    [_textView resignFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    UITextView *textView=(UITextView*)[[self view] viewWithTag:1];
    textView.text=textNoteData.note;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickCancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickModifyButton:(id)sender {
    [_dbu updateNoteWithID:textNoteData.id note: _textView.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
