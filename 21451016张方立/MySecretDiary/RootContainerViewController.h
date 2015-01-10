//
//  RootContainerViewController.h
//  MySecretDiary
//
//  Created by icy on 14-12-22.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "RootBookViewController.h"
#import "BookViewController.h"

@interface RootContainerViewController : UIViewController
{
    NSManagedObjectContext *context;
    MainViewController *mainViewController;
    //RootBookViewController *rootViewController;
    CGRect aFrame;
}

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) RootBookViewController *rootViewController;

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)cntxt;

-(void)OpenBook:(BookViewController *)book;
-(void)closeBook:(BookViewController *)book;

@end
