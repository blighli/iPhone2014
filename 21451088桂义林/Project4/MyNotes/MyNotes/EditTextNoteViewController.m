//
//  EditTextNoteViewController.m
//  MyNotes
//
//  Created by YilinGui on 14-11-23.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "EditTextNoteViewController.h"
#import "TextTableViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Note.h"

@interface EditTextNoteViewController ()
@property UITextView *myTextView;
@property UITextField *textField;
@property UILabel *titleLabel;
@property (nonatomic, strong) Note *note;

@end

@implementation EditTextNoteViewController

- (void)passNote:(Note *)note {
    self.note = note;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, 40, 40)];
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 64, self.view.frame.size.width - 60, 40)];
    self.myTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 104, self.view.frame.size.width - 20, 480)];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.myTextView];
    
    [self.titleLabel setText:@"Title: "];
    [self.textField setText:self.note.title];
    [self.myTextView setBackgroundColor:[UIColor colorWithRed:0.84 green:0.93 blue:0.95 alpha:1.0]];
    [self.myTextView setText:self.note.message];
    [self.myTextView becomeFirstResponder];
    //[self.textField becomeFirstResponder];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClicked)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStyleDone target:self action:@selector(saveClicked)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;  // 为导航栏左侧添加取消按钮
    self.navigationItem.rightBarButtonItem = saveButton;  // 为导航栏右侧添加保存按钮
}

// 响应保存按钮
- (void)saveClicked {
    //NSString *textString = [self.myTextView text];  // 获取文本内容
    //NSLog(@"The content is %@", textString);
//    Note *note = [Note MR_createEntity];
    Note *note = self.note;
    note.title = self.textField.text;
    note.message = self.myTextView.text;
    note.date = [NSDate date];
    note.type = @"text";
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}

// 响应取消按钮
- (void)cancelClicked {
    //NSLog(@"Don't save this notes!");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
