//
//  AddPhotoViewController.m
//  MyNotes
//
//  Created by YilinGui on 14-11-24.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "EditPhotoViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Note.h"

@interface EditPhotoViewController ()
@property UIImageView *imageView;
@property UITextField *textField;
@property UILabel *titleLabel;
@property (nonatomic, strong) Note *note;
@end

@implementation EditPhotoViewController

- (void)passNote:(Note *)note {
    self.note = note;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, 40, 40)];
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 64, self.view.frame.size.width - 60, 40)];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(36, 104, 240, 320)];
    //self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.imageView];
    
    [self.titleLabel setText:@"Title: "];
    [self.textField setText:self.note.title];
    NSString* imageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imageFilePath = [imageDirPath stringByAppendingString:self.note.message];
    UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
    self.imageView.image = image;
    //[self.textField becomeFirstResponder];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClicked)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStyleDone target:self action:@selector(saveClicked)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;  // 为导航栏左侧添加取消按钮
    self.navigationItem.rightBarButtonItem = saveButton;  // 为导航栏右侧添加保存按钮
}

// 响应保存按钮
- (void)saveClicked {
    Note *note = self.note;
    note.title = self.textField.text;  // 只修改标题
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [self.navigationController popViewControllerAnimated:YES];
}

// 响应取消按钮
- (void)cancelClicked {
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
