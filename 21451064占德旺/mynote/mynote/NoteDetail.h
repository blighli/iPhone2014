//
//  NoteDetail.h
//  mynote
//
//  Created by Devon on 14/11/21.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface NoteDetail : UIViewController

@property(nonatomic,retain)AppDelegate* myAppDelegate;
@property (nonatomic, strong)NSString *noteIndex;

@end
