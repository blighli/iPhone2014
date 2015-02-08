//
//  MainViewController.m
//  MyNote
//
//  Created by Cocoa on 14/11/20.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "NewDoodleNoteViewController.h"
#import "AppDelegate.h"

@interface NewDoodleNoteViewController ()
@property (weak, nonatomic) AppDelegate *appdelegate;
@property (weak, nonatomic) IBOutlet UIImageView *doodleImageView;
@property (strong, nonatomic) NSMutableArray *allNotes;

@end

@implementation NewDoodleNoteViewController

int mouseSwiped;
int mouseMoved = 0;
CGPoint lastPoint;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 2) {
        self.doodleImageView.image = nil;
        return;
    }
    lastPoint = [touch locationInView:self.view];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [self.doodleImageView.image drawInRect:CGRectMake(0, 0, self.doodleImageView.frame.size.width, self.doodleImageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 8.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 1.0, 0.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.doodleImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
    
    mouseMoved++;
    
    if (mouseMoved == 10) {
        mouseMoved = 0;
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //Double click to clean the canvas
    UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 2) {
        self.doodleImageView.image = nil;
        return;
    }
    
    if(!mouseSwiped) {
        //if color == green
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.doodleImageView.image drawInRect:CGRectMake(0, 0, self.doodleImageView.frame.size.width, self.doodleImageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 8.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 1.0, 0.0, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.doodleImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
}

- (IBAction)save:(id)sender {
    UIImage *image = self.doodleImageView.image;
    NSString* imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString: @"/images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss-SSSS"];
    NSDate* nowDate = [[NSDate alloc] init];
    NSString *imageFilePath = [imagePath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate:nowDate], @"jpg"];
    
    NSLog(imageFilePath);
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    if ([imageData writeToFile:imageFilePath atomically:YES] ) {
        Note *newDoodleNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.appdelegate.managedObjectContext];
        newDoodleNote.content = imageFilePath;
        newDoodleNote.type = @"手绘";
        newDoodleNote.date = [NSDate new];
    
        NSError *error = nil;
        BOOL isSave =   [self.appdelegate.managedObjectContext save:&error];
        if (!isSave) {
            NSLog(@"error:%@,%@",error,[error userInfo]);
        }
        else{
            NSLog(@"保存成功");
            [self.allNotes addObject:newDoodleNote];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
         NSLog(@"image wiret to file failed, file is %@", imageFilePath);
    }
}
@end
