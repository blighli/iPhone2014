//
//  DrawPhotoViewController.h
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoodleView.h"
#import "passImageValueDelegate.h"

@interface DrawPhotoViewController : UIViewController
{
    
}
@property(nonatomic,strong)DoodleView * myView;
@property(nonatomic,assign)NSObject<passImageValueDelegate> *delegate;
@end
