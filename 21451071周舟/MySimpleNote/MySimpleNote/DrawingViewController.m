//
//  DrawingViewController.m
//  MySimpleNote
//
//  Created by 周舟 on 25/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "DrawingViewController.h"
#import "CanvasView.h"
#import <CoreData/CoreData.h>
#import "Entity.h"


@interface DrawingViewController ()

@property (weak, nonatomic) IBOutlet CanvasView *drwingView;

@end

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drwingView.color = [UIColor blackColor];
    NSLog(@"view:%@",self.drwingView);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view:%@",self.drwingView);

    
}

- (IBAction)save:(id)sender {
    
    
    NSString* imageDirPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString: @"/images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:imageDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHHmmss"];
    
    NSDate* nowDate = [NSDate new];
    NSString *imageFilePath = [imageDirPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate: nowDate], @"png"];
    
    if ([_drwingView saveToPNGFile:imageFilePath])
    {
        Entity* entity;
        //创建一个新的Data类型note
        entity= (Entity *)[NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:self.manageedObjectContext];
        entity.content = nil;
        entity.date = [NSDate new];
        entity.imagepath = imageFilePath;
        
        //将数据写入
        NSError *error = nil;
        if (![entity.managedObjectContext save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"图片保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}


@end
