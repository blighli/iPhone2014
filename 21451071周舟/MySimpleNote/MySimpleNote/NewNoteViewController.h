//
//  NewNoteViewController.h
//  MySimpleNote
//
//  Created by 周舟 on 24/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface NewNoteViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *manageedObjectContext;
@end
