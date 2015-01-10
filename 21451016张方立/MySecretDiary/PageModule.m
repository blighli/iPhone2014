//
//  PageModule.m
//  MySecretDiary
//
//  Created by icy on 15-1-9.
//  Copyright (c) 2015年 icy. All rights reserved.
//

#import "PageModule.h"
#import "DiaryPageViewController.h"
#import "BookViewController.h"
#import "RootBookViewController.h"
@interface PageModule()
@property (strong, nonatomic) NSArray *diaries;
@end

@implementation PageModule

@synthesize rvc;






- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc]initWithKey:@"date" ascending:YES];
    self.diaries = [self.user.diaries sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    
   

    // Return the data view controller for the given index.
    if ( index > [self.diaries count] )
    {
        DiaryPageViewController *diaryPage = [[DiaryPageViewController alloc] init];       diaryPage.delegate = self.rvc;
    }
    
    if (index == 0)
    {    }
    
    //
    DiaryPageViewController *diaryPage = [[DiaryPageViewController alloc] init];       diaryPage.delegate = self.rvc;
    
    return diaryPage;
    
    /*
     // Create a new view controller and pass suitable data.
     DataViewController *dataViewController = [[DataViewController alloc] initWithNibName:@"DataViewController" bundle:nil];
     dataViewController.dataObject = [self.pageData objectAtIndex:index];
     return dataViewController;
     */
    
    
    
    
    
    
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    /*
     Return the index of the given data view controller.
     For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
     */
    NSUInteger index = 1;
    return index;
    
}

#pragma mark - Page View Controller Data Source
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound)
    {
        return nil;
    }
    if(index == 0)
    {
        return [self.rvc topBook];
        
    }
    
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController respondsToSelector:@selector(refreshFrontView)]) {
        return [self viewControllerAtIndex:0];
    }
    
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    
    index++;
    
    if (index > [self.diaries count] + 1) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}
@end
