//
//  AppDelegate.h
//  Project4-Note
//
//  Created by  ws on 11/20/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

