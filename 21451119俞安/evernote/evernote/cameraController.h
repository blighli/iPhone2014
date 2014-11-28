//
//  cameraController.h
//  evernote
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface cameraController : UIViewController<UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

- (IBAction)takePhoto:(id)sender;
- (IBAction)add:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *photoTable;
-(void)findobject;
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
-(void)saveToSandbox:(UIImage*)image withimgname:(NSString*)imgname;
@end
