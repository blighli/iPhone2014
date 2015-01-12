//
//  HYBCard.h
//  2048
//
//  Created by hyb on 14/12/30.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBCard;
@protocol HYBCardDelegate <NSObject>

- (void)cardDidPressed:(HYBCard *)card;

@end

@interface HYBCard : UIView

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic) NSInteger number;
@property (assign, nonatomic) NSInteger exp;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) BOOL currentAdded;

@property (assign, nonatomic) id <HYBCardDelegate> delegate;

- (void)addExpWithDelay:(NSTimeInterval)time;
- (IBAction)pressed:(id)sender;

@end
