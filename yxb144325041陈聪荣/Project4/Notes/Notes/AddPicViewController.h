//
//  AddPicViewController.h
//  Notes
//
//  Created by 陈聪荣 on 14/12/6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AddPicViewController : UIImagePickerController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong , nonatomic) NoteBiz *noteBiz;
- (IBAction)returnOnclick:(id)sender;
- (IBAction)photoClick:(id)sender;

@end
