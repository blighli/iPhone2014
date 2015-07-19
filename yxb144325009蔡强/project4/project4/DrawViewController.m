//
//  DrawViewController.m
//  project4
//
//  Created by zack on 14-11-22.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import "DrawViewController.h"
#import "ViewController.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

int mouseSwiped;
int mouseMoved = 0;
CGPoint lastPoint;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 2) {
        _imageView.image = nil;
        return;
    }
    lastPoint = [touch locationInView:self.view];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [_imageView.image drawInRect:CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), [((AppDelegate *)[[UIApplication sharedApplication] delegate]).size floatValue]);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 1.0, 0.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
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
        _imageView.image = nil;
        return;
    }
    
    if(!mouseSwiped) {
        //if color == green
        UIGraphicsBeginImageContext(self.view.frame.size);
        [_imageView.image drawInRect:CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), [((AppDelegate *)[[UIApplication sharedApplication] delegate]).size floatValue]);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 1.0, 0.0, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
}

- (IBAction)save:(id)sender {
    UIImage *image = _imageView.image;
    NSString* imageDirPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString: @"/images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:imageDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHHmmss"];
    NSDate* nowDate = [NSDate new];
    NSString *imageFilePath = [imageDirPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate: nowDate], @"jpg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    if ([imageData writeToFile:imageFilePath atomically:YES] ) {
        Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:((ViewController*)_delegate).context];
        note.content = imageFilePath;
        note.type = @"手绘";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
        NSDate* nowDate = [NSDate new];
        note.time = [dateFormatter stringFromDate: nowDate];
        NSError *error = nil;
        if ([((ViewController*)_delegate).context save:&error]) {
            [((ViewController*)_delegate).notesArray addObject:note];
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"保存成功");
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
            NSLog(@"error:%@,%@",error,[error userInfo]);
        }
        
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }
}
@end
