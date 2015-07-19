//
//  DrawPictureViewController.m
//  Project4
//
//  Created by jingcheng407 on 14-11-23.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import "DrawPictureViewController.h"
#import "MyNote.h"
#import "AppDelegate.h"
@interface DrawPictureViewController ()

@end

@implementation DrawPictureViewController
int mouseSwiped;
int mouseMoved = 0;
CGPoint lastPoint;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_num!=nil) {
        NSString *imagePath =((MyNote*)[_param.TableViewListArray objectAtIndex:[_num integerValue]]).text;
        self.ImageView.image=[[UIImage alloc]initWithContentsOfFile: imagePath];
        _SaveButton.enabled=FALSE;
    }else{
        
    }
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

- (IBAction)SaveButton:(id)sender {
    UIImage* myImage = _ImageView.image;
    NSString *imageDIRPath =  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString: @"/images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:imageDIRPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter* nsdateformat=[[NSDateFormatter alloc] init];
    [nsdateformat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *imageFilePath = [imageDIRPath stringByAppendingFormat:@"/%@.%@", [nsdateformat stringFromDate: [NSDate new]], @"jpg"];
    NSData *imageData = UIImageJPEGRepresentation(myImage, 1);
    if ([imageData writeToFile:imageFilePath atomically:YES] ) {
        AppDelegate* myAppDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate] ;//获取委托
        MyNote *myNote = [NSEntityDescription insertNewObjectForEntityForName:@"MyNote" inManagedObjectContext:[myAppDelegate managedObjectContext]];
        myNote.text = imageFilePath;
        NSDateFormatter* nsdateformat=[[NSDateFormatter alloc] init];
        [nsdateformat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        myNote.time = [nsdateformat stringFromDate: [NSDate new]];
        myNote.type=@"pic";
        NSError *error = nil;
        BOOL isSave =   [[myAppDelegate managedObjectContext] save:&error];
        if (!isSave) {
            NSLog(@"error:%@,%@",error,[error userInfo]);
        }
        else{
            NSLog(@"保存成功");
            [_param.TableViewListArray addObject:myNote];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        //保存失败
        NSLog(@"保存失败");
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 2) {
        _ImageView.image = nil;
        return;
    }
    lastPoint = [touch locationInView:self.view];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [_ImageView.image drawInRect:CGRectMake(0, 0, _ImageView.frame.size.width, _ImageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 1.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    _ImageView.image = UIGraphicsGetImageFromCurrentImageContext();
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
        _ImageView.image = nil;
        return;
    }
    
    if(!mouseSwiped) {
        //if color == green
        UIGraphicsBeginImageContext(self.view.frame.size);
        [_ImageView.image drawInRect:CGRectMake(0, 0, _ImageView.frame.size.width, _ImageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 1.0, 0.0, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        _ImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
}
@end
