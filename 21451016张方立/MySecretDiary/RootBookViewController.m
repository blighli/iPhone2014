//
//  RootBookViewController.m
//  MySecretDiary
//
//  Created by icy on 15-1-9.
//  Copyright (c) 2015年 icy. All rights reserved.
//

#import "RootBookViewController.h"
#import "AppDelegate.h"
#import "RootContainerViewController.h"
#import "Diary.h"
#import <CoreData/CoreData.h>

@interface RootBookViewController()

@property BOOL editable;

@end
@implementation RootBookViewController
@synthesize diaryContent;
@synthesize rightButton;
@synthesize topBook;
@synthesize user;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"padded.png"]];
    self.user = self.topBook.user;
    
    
    
    [diaryContent setBackgroundColor:[UIColor clearColor]];
    diaryContent.delegate = self;
    diaryContent.editable = false;
    
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Diary"];
    
    NSError *error = nil;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    NSLog(@"array count %ld",[array count]);
    
    for (NSInteger i=[array count]; i>0;i--) {
        NSString* name = [[(Diary *)[array objectAtIndex:i-1] user]name];
        if ([self.user.name isEqualToString:name]) {
            diaryContent.text = [(Diary *)[array objectAtIndex:i-1] content];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickButton:(id)sender {
    
    if (!diaryContent.editable) {
        [rightButton setImage: [UIImage imageNamed:@"donePageButton"] forState:UIControlStateNormal];
        diaryContent.editable = true;
    }else{
        [rightButton setImage: [UIImage imageNamed:@"editPageButton"] forState:UIControlStateNormal];
        diaryContent.editable = false;
    }
    [self.diaryContent resignFirstResponder];

  
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)backButtonClick:(id)sender {

    
     Diary *newDiary = [NSEntityDescription insertNewObjectForEntityForName:@"Diary" inManagedObjectContext:[self managedObjectContext]];
    newDiary.title = @"diary title";
    newDiary.content = self.diaryContent.text;
    newDiary.user = self.user;
    newDiary.date = [NSDate date];
    newDiary.picture = [[NSData alloc]init];
    self.diary = newDiary;
    
    [self save];

    [self closeBook];
}

-(bool)save{
    NSLog(@"save");
    
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    // Create a new managed object
    NSManagedObject *newDiary = [NSEntityDescription insertNewObjectForEntityForName:@"Diary" inManagedObjectContext:context];
    [newDiary setValue:self.diary.title forKey:@"title"];
    [newDiary setValue:self.diary.content forKey:@"content"];
    [newDiary setValue:self.diary.date forKey:@"date"];
    [newDiary setValue:self.diary.user forKey:@"user"];
    [newDiary setValue:self.diary.picture forKey:@"picture"];
    NSError *error = nil;
    [context save:&error];
    if(error)
    {
        NSLog(@"error %@\n", [error  description]);
        return NO;
    }
    return YES;
    
    
}


#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"ui textViewDidBeginEditing");

    
    [rightButton setImage: [UIImage imageNamed:@"donePageButton"] forState:UIControlStateNormal];
    
    rightButton.hidden = false;
    NSLog(@"textViewDidBeginEditing");
}

- (void)textViewDidEndEditing:(UITextView *)textView {
   
}

- (void)leaveEditMode {
    [self.diaryContent resignFirstResponder];
}


-(void)openBook{}
-(void)closeBook
{
    topBook.view.frame = CGRectMake(0, 0, 320, 460);
    [topBook refreshFrontView];
    //NSArray *viewControllers = [NSArray arrayWithObject:self.topBook];
    
    /* staying away from retain cycles */
    __block typeof(self) bself = self;
    
//    [self.pageViewController setViewControllers:viewControllers
//                                      direction:UIPageViewControllerNavigationDirectionReverse
//                                       animated:YES
//                                     completion:^(BOOL finished){
//                                         if(finished)
//                                             [bself.delegate closeBook:bself.topBook];
//                                     }];
    
    NSLog(@"closeBook");
    
    [self.delegate closeBook:bself.topBook];

}

-(void)flipToPage:(int)page animated:(bool)animated forward:(bool)forward{}



#pragma mark - UIPageViewController Helper Functions

-(void)setupPageViewController
{
    RKPageViewController *pageView = [[RKPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [pageView setDelegate:self];
    
    //~~~
    //[pageView setDataSource:self];
    
    [self addChildViewController:pageView];
    [self.view insertSubview:pageView.view atIndex:1];
    self.view.gestureRecognizers = pageView.gestureRecognizers;
    //[self.view addSubview:pageView.view];
    
    //[self.view sendSubviewToBack:pageView.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    // CGRect pageViewRect = self.view.bounds;
    pageView.view.frame = CGRectMake(0, 11, 305, 438);
    self.pageViewController = pageView;
    [self.pageViewController didMoveToParentViewController:self];
    
    
}




@end
