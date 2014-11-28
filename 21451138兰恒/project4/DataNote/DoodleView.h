//
//  DoodleView.h
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoodleView : UIView
{
    
}
@property(nonatomic,retain)NSMutableArray *lineArray;
-(void) undo;
@end
