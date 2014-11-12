//
//  DetailViewController.h
//  MyToDoList
//
//  Created by alwaysking on 14/11/9.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@protocol DetailViewControllerDelegate <NSObject>
- (void)addItemViewController:(DetailViewController *)controller didFinishEnteringItem:(NSDictionary *)item;
@end


@interface DetailViewController : UIViewController <UITextViewDelegate>

@property IBOutlet UIBarButtonItem *btnItemDone;
@property IBOutlet UITextView *textview;
@property (nonatomic, weak) id <DetailViewControllerDelegate> delegate;
@property (nonatomic,retain) NSDictionary *dictionary;

- (IBAction)btnDone:(id)sender;
- (IBAction)btnCanle:(id)sender;

@end
