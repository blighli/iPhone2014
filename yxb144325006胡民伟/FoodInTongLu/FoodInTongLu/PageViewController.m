//
//  PageViewController.m
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/16.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "PageViewController.h"
#import "PageContentViewController.h"

@interface PageViewController ()
@property (strong, nonatomic) NSArray *pageHeadings;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSArray *pageSubHeadings;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageHeadings = @[@"Personalize", @"Locate", @"Discover"];
    self.pageImages = @[@"homei", @"mapintro", @"fiveleaves"];
    self.pageSubHeadings = @[@"Pin your favourite restaurants and create your own food guide", @"Search and locate your favourite restaurant on Maps", @"Find restaurants pinned by your friends and other foodies around the world"];
    
    // Set the data source to itself
    self.dataSource = self;
 
    // Create the first walkthrough screen
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    if (startingViewController) {
        [self setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
   
    int index = ((PageContentViewController *)viewController).index;
    index++;
    return [self viewControllerAtIndex:index];
}


-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    int index = ((PageContentViewController *)viewController).index;
    index--;
    return [self viewControllerAtIndex:index];
}

-(PageContentViewController *)viewControllerAtIndex:(int) index{
    
    if (index < 0 || index >= self.pageHeadings.count) {
        return nil;
    }
    
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    if (pageContentViewController != nil) {
        
        pageContentViewController.imageFile = self.pageImages[index];
        pageContentViewController.heading = self.pageHeadings[index];
        pageContentViewController.subHeading = self.pageSubHeadings[index];
        pageContentViewController.index = index;
        
        return  pageContentViewController;
    }
    
    
    return nil;
}

- (void) forward:(int)index{
    PageContentViewController *nextViewController = [self viewControllerAtIndex:index+1];
    if (nextViewController) {
        [self setViewControllers:@[nextViewController] direction:(UIPageViewControllerNavigationDirectionForward) animated:true completion:nil];
    }
}

@end
