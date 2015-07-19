//
//  DrawViewController.m
//  NoteBook
//
//  Created by Mz on 14-11-23.
//  Copyright (c) 2014年 pxy. All rights reserved.
//

#import "DrawViewController.h"
#import "PaintView.h"
#import "Note.h"
#import "ViewController.h"
@interface DrawViewController ()
@property (nonatomic) PaintView *paint;
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    frame.origin.x += 10;
    frame.origin.y += 10 + navBarHeight;
    frame.size.width -= 20;
    frame.size.height -= 20 + navBarHeight;
    self.paint = [[PaintView alloc] initWithFrame:frame];
    [self.view addSubview:self.paint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveDraw:(id)sender {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"docpath = %@", docPath);
    NSString *imagePath = [docPath stringByAppendingPathComponent:@"images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss_SSSS"];
    NSString* nowDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString *imageFilePath = [imagePath stringByAppendingFormat:@"/%@.%@", nowDate, @"jpg"];
    NSData *imageData = UIImageJPEGRepresentation([self.paint getImage], 1);
    if([imageData writeToFile:imageFilePath atomically:YES]) {
        Note *note = [Note MR_createEntity];
        note.date = [NSDate date];
        note.content = imageFilePath;
        note.type = [NSNumber numberWithInt:NoteTypeDarwing];
        [self.mainView.noteData insertObject:note atIndex:0];
        [self.mainView.tableView reloadData];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
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
