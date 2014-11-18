//
//  PaintViewController.m
//  AnyNote
//
//  Created by 黄盼青 on 14/11/18.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "PaintViewController.h"

@interface PaintViewController ()

@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (IBAction)viewExit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearPaintView:(id)sender {
    [_paintView clearView];
}

- (IBAction)changeLineWidth:(UIStepper *)sender {
    float lineValue=[sender value];
    NSMutableString *newLabel=[NSMutableString stringWithFormat:@"画笔大小:%.0f",lineValue];
    _lineWidthLabel.title=newLabel;
    _paintView.lineWidth=lineValue;
}

- (IBAction)chooseColor:(UIBarButtonItem *)sender {
    UIColor *color=[sender tintColor];
    _paintView.lineColor=color;
}

//生成UUID
- (NSString *)createUUID
{
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    CFRelease(uuidObject);
    return uuidStr;
}

//保存绘图
- (IBAction)savePaint:(id)sender {
    ViewController *mainView=(ViewController *)_delegate;
    
    UIImage *img=[_paintView saveToImage];
    
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[path objectAtIndex:0];
    NSString *dataFilePath=[documentPath stringByAppendingPathComponent:[self createUUID]];
    dataFilePath=[dataFilePath stringByAppendingString:@".png"];
    
    //输出PNG文件，写入Documents内
    [UIImagePNGRepresentation(img) writeToFile:dataFilePath atomically:YES];
    
    NoteData *note=[NoteData MR_createEntity];
    note.type=@"画板";
    note.date=[NSDate date];
    note.contents=dataFilePath;
    
    [mainView.noteData insertObject:note atIndex:0];
    
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    [mainView.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
