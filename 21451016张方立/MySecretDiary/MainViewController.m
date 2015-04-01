//
//  MainViewController.m
//  MySecretDiary
//
//  Created by icy on 15-1-8.
//  Copyright (c) 2015年 icy. All rights reserved.
//

#import "MainViewController.h"
#import "BookViewController.h"
#import "BookFrontView.h"
#import "RootContainerViewController.h"
#import "User.h"
#import "Diary.h"

@interface MainViewController ()
-(void)scrollViewDidScroll:(UIScrollView *)sender;
-(NSInteger)currentPage;
//-(void) easterEgg:(User *)newBook;
@end

@implementation MainViewController

@synthesize bookScrollView;
@synthesize books;
@synthesize context;
@synthesize users;
@synthesize parent;
@synthesize sliderPageControl;

#pragma mark - View lifecycle

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)cntxt
{
    self =  [self init];
    if(self)
    {
        self.context = cntxt;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* Create a scroll view for the books */
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [scrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"padded.png"]]];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setDirectionalLockEnabled:YES];
    [scrollView setDelegate:self];
    [self setBookScrollView:scrollView];
    [self.view addSubview:self.bookScrollView];
    
    /* Retreive all Opponents to help setup the Controller */
    self.users = [User allDiariesSortedBy:@"date"];
    [self resizeScrollView];    // Resize to fit number of Users
    
    /* view controllers are created lazily
     in the meantime, load the array with placeholders which will be replaced on demand */
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [self.users count] + 1; i++)
    {
        [controllers addObject:[NSNull null]];
    }
    self.books = controllers;
    
    /* Load the first few Book Covers on the ScrollView */
    if ([self.users count] == 0)
        [self loadScrollViewWithPage:0 ];
    else
    {
        for (int i = 0; i <= [self.users count] && i < 3; i++)
        {
            [self loadScrollViewWithPage:i ];
        }
    }
    
    [self setupSlider];


    
}


-(void)setupSlider
{
    self.sliderPageControl = [[SliderPageControl  alloc] initWithFrame:CGRectMake(0,[self.view bounds].size.height-20,[self.view bounds].size.width,20)];
    [self.sliderPageControl addTarget:self action:@selector(onPageChanged:) forControlEvents:UIControlEventValueChanged];
    [self.sliderPageControl setDelegate:self];
    [self.sliderPageControl setShowsHint:YES];
    [self.view addSubview:self.sliderPageControl];
    
    [self.sliderPageControl setNumberOfPages:[self.users count] + 1];
    [self.sliderPageControl setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    
    [self changeToPage:0 animated:NO];
}

#pragma mark - Scroll View Functions

/*
 This function is a modified function from an Apple example named : ScrollViewWithPaging
 The purpose of this funtion is to supply the Page-enabled ScrollView with new viewcontrollers
 */
- (void)loadScrollViewWithPage:(NSInteger)page
{
    /* if the page being requested is out of bounds, leave the function */
    if (page < 0 || page > [users count] )
        return;
    if (page == [books count])
        [books addObject:[NSNull null]];
    
    
    /* We will take our lazily loaded controllers, test for null and init
     new Book View controllers to supply to the ScrollView */
    BookViewController *controller = [books objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        /* If the requested page is equal to the number of opponents
         the correct page to supply is an add new page.
         Initing with a nil opponent causes it to be set up as an add new page */
        if (page == [self.users count])
        {
            controller = [[BookViewController alloc] initWithUser:nil];
        }
        else
        {
            controller = [[BookViewController alloc] initWithUser:[self.users objectAtIndex:page]];
        }
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didSelectBook:)];
        tapGesture.delegate = self;
        for (UIGestureRecognizer *gesture in self.bookScrollView.gestureRecognizers) {
            [tapGesture requireGestureRecognizerToFail:gesture];
        }
        
        
        [controller.frontView addGestureRecognizer:tapGesture];
        controller.delegate = self;
        [books replaceObjectAtIndex:page withObject:controller];
    }
    
    /* Add the controller's view to the scroll view */
    if (controller.view.superview == nil)
    {
        CGRect frame = bookScrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.bookScrollView addSubview:controller.view];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 This function is a modified function from an Apple example named : ScrollViewWithPaging
 This scrollView delegate function determines which page the the scrollView is on
 and loads the viewcontrollers to the left and right to make the user expierience seamless.
 The example function did not include the section where pages are being nulled out.
 This was done for memory savings and to allow infinite pages without slow down.
 */
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    NSUInteger page = [self currentPage];
    
    /* load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling) */
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    /* update our sliderControl */
    [sliderPageControl setCurrentPage:page animated:YES];
    
    // Apple : A possible optimization would be to unload the views+controllers which are no longer visible
    /* Me    : We Shall */
    for (NSUInteger i = 0; i < [books count]; i++)
    {
        if( i == page - 1 || i == page || i == page + 1)
        {
            /* ignore the pages currently surrounding the page in view */
        }
        else
        {
            /* If this Book is not null, then it will become null */
            BookViewController *testBook = [books objectAtIndex:i];
            
            if ((NSNull*)testBook != [NSNull null])
            {
                /* if the book is a subview of another view then remove it */
                if (testBook.view.superview != nil )
                {
                    [testBook.view removeFromSuperview];
                }
                
                [books replaceObjectAtIndex:i withObject:[NSNull null]];
            }
        }
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}


/*
 resizeScrollView - Since the book scroll view uses paging, it must be as wide as all
 of the pages. This function Updates its width with this in mind
 width = pageWidth * (numberOfOpponents + AddNewBook page)
 */
-(void)resizeScrollView
{
    self.bookScrollView.contentSize = CGSizeMake(320 * ([users count] + 1), self.bookScrollView.frame.size.height);
    [self.sliderPageControl setNumberOfPages:[self.users count] + 1];
}


-(NSInteger)currentPage
{
    CGFloat pageWidth = bookScrollView.frame.size.width;
    int page = floor((bookScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    return page;
}


-(void)reloadBooks
{
    [self loadScrollViewWithPage:[self currentPage]];
}

#pragma mark - BookViewController Delegate Functions

/*
 This delegate Function occurs when the user has completed
 entering a name on the AddNewBook. It creates a new opponent in
 Core Data, configures and saves it.
 */
-(void)nameBookFinishedWithName:(NSString *)oppName by:(BookViewController *)book
{
    
    if(!book.user)
    {
        if (self.context!=nil) {
            NSLog(@"self.context!=nil");
        }
        User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
        
        newUser.name = oppName;
        newUser.date = [NSDate date];
        
        /* If for some reason it does not save, show an alert asking the user
         to send an email with details */
//        if(![newUser save])
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Did not save" message:@"There is a problem with coredata " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", "Email", nil];
//            [alert show];
//        }
        
        self.users = [self.users arrayByAddingObject:newUser];
        book.user = newUser;
        
       // [self easterEgg:newUser];
        [book refreshFrontView];
        [self loadScrollViewWithPage:[books indexOfObject:book] + 1];
        [self resizeScrollView];
    }
    else
    {
        [book.user setName:oppName];
//        if(![book.user save])
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Did not save" message:@"There is a problem with coredata " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", "Email", nil];
//            [alert show];
//        }
    }
    
    
}


/*
 Delegate Function called when a user chooses the delete button
 on the flipside of the BookViewController
 */
-(void)deleteThisBook:(BookViewController *)bookToDelete
{
    /* Capture the bookToDeletes' frame for later use */
    CGRect bookToDeleteFrame = bookToDelete.view.frame;
    
    /* if the book is sucessfully Deleted from Core Data
     Remove it from the view, move the next book over and resize the view */
    if([User deleteUser:bookToDelete.user])
    {
        
        /* Book Deletion animation which causes the book to slide down
         offscreen and slide the next book to the right in its place */
        [UIView animateWithDuration:0.8f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             bookToDelete.view.frame = CGRectMake(bookToDeleteFrame.origin.x, 480, bookToDeleteFrame.size.width, bookToDeleteFrame.size.height);
                             bookToDelete.view.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             [bookToDelete.view removeFromSuperview];
                         }];
        self.users = [User allDiariesSortedBy:@"date"];
        
        /* Shift the next books' frame left to replace the one deleted */
        NSUInteger indexOfBookOnTheRight = [books indexOfObject:bookToDelete] + 1;
        BookViewController *bookOnTheRight = [books objectAtIndex:indexOfBookOnTheRight];
        
        /* This moves the book to the rights frame to where the deleted book was
         Since we saved the frame before we altered it, we can use it here */
        [UIView animateWithDuration:0.8f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             bookOnTheRight.view.frame = bookToDeleteFrame;
                         }
                         completion:nil];
        
        [books removeObject:bookToDelete];
        [self loadScrollViewWithPage:[books indexOfObject:bookOnTheRight] + 1 ];
    }
    /* Finally, since we have a new amount of books, resize the scroll view */
    
    [self resizeScrollView];
}


/*
 didSelectBook - Gets called when a user opens a book
 The purpose of this function is to expand the bookcover
 and pass control over to the parent view controller.
 */
-(void)didSelectBook:(UIGestureRecognizer *)gesture
{
    [self.parent OpenBook:[self.books objectAtIndex:[self currentPage]]];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    if ([touch.view isKindOfClass:[UIImageView class]])
    {
        return YES;
    }
    else return NO;
}


/*
 Slider page Control delegate Functions
 These functions are needed by the Slider Page control
 on the bottom of the page
 */
#pragma mark sliderPageControlDelegate

/* Returns the Title for the OverlayView when Choosing by SlideControl */
- (NSString *)sliderPageController:(id)controller hintTitleForPage:(NSInteger)page
{
    if( page == [self.users count] )
        return @"Create New";
    
    User  *currentUser = [self.users objectAtIndex:page];
    return currentUser.name;
}


- (void)onPageChanged:(id)sender
{
    pageControlUsed = YES;
    [self slideToCurrentPage:YES];
}


- (void)slideToCurrentPage:(bool)animated
{
    int page = sliderPageControl.currentPage;
    
    CGRect frame = bookScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.bookScrollView scrollRectToVisible:frame animated:animated];
}


- (void)changeToPage:(int)page animated:(BOOL)animated
{
    [sliderPageControl setCurrentPage:page animated:YES];
    [self slideToCurrentPage:animated];
}

#pragma mark - UIAlertViewDelegate functions

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2)
    {
        // do nothing temporarily
    }
}


@end
