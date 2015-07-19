//
//  ImageViewController.h
//  Project4-Note
//
//  Created by  ws on 11/23/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
@property (weak, nonatomic) NSNumber* noteIndex;
@property (weak, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@end
