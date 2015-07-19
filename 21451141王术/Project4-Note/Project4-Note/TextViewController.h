//
//  TextViewController.h
//  Project4-Note
//
//  Created by  ws on 11/21/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController
@property (weak, nonatomic) NSNumber* noteIndex;
@property (weak, nonatomic) id delegate;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@end
