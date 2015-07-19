//
//  AddDrawViewController.m
//  MyNotes
//
//  Created by YilinGui on 14-11-23.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "AddDrawViewController.h"
#import "DoodleView.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Note.h"

@interface AddDrawViewController ()
@property UITextField *textField;
@property UILabel *titleLabel;
@property DoodleView *doodleView;

@end

@implementation AddDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, 40, 40)];
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 64, self.view.frame.size.width - 60, 40)];
    self.doodleView = [[DoodleView alloc] initWithFrame:CGRectMake(10, 104, self.view.frame.size.width - 20, 480)];
    self.doodleView.backgroundColor = [UIColor colorWithRed:0.84 green:0.93 blue:0.95 alpha:1.0];

    [self.view addSubview:self.doodleView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.textField];
    
    [self.titleLabel setText:@"Title: "];
    [self.textField setText:@"Untitled Notes"];
    [self.textField becomeFirstResponder];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClicked)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStyleDone target:self action:@selector(saveClicked)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;  // 为导航栏左侧添加取消按钮
    self.navigationItem.rightBarButtonItem = saveButton;  // 为导航栏右侧添加保存按钮
}

// 响应保存按钮
- (void)saveClicked {
    //NSString *textString = [self.myTextView text];  // 获取文本内容
    //NSLog(@"The content is %@", textString);
//    UIGraphicsBeginImageContext(self.doodleView.bounds.size);
//    [self.doodleView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);  // 保存到相册
    NSString* imageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHHmmss"];
    //NSLog(@"image Dir Path: %@", imageDirPath);
    
    Note *note = [Note MR_createEntity];
    note.title = self.textField.text;
    note.date = [NSDate date];
    NSString *imageFilePath = [imageDirPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate: note.date], @"png"];
    [self.doodleView saveToPNGFile:imageFilePath];
    //NSLog(@"%@", imageFilePath);
    note.message = [NSString stringWithFormat:@"/%@.%@", [dateFormatter stringFromDate: note.date], @"png"];  // 图片的相对路径(这里就是文件名)
    note.type = @"draw";
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
