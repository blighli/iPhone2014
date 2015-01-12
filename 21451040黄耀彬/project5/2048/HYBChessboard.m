//
//  HYBChessboard.m
//  2048
//
//  Created by hyb on 14/12/30.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import "HYBChessboard.h"


#define ROW_LIMIT       4
#define SECTION_LIMIT   4
#define CARD_SIZE       CGSizeMake(60, 60)
#define INTERVAL        10

@implementation HYBChessboard

#pragma mark - Operation

- (void)animateCard:(HYBCard *)card toCard:(HYBCard *)desCard{
    NSIndexPath *fromIndexPath = card.indexPath;
    desCard.currentAdded = YES;
    [self.cardIndexPaths removeObject:fromIndexPath];
    [self.leftIndexPaths addObject:fromIndexPath];
    
    NSInteger timeMultiplier = (NSInteger)fabs((card.indexPath.row - desCard.indexPath.row) + (card.indexPath.section - desCard.indexPath.section));
    [desCard addExpWithDelay:0.1f * timeMultiplier];
    [UIView animateWithDuration:0.1f * timeMultiplier
                     animations:^{
                         [card setFrame:desCard.frame];
                     }
                     completion:^(BOOL finished) {
                         [card removeFromSuperview];
                     }
     ];
}

- (void)animateCard:(HYBCard *)card toIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *originIndexPath = card.indexPath;
    [self.leftIndexPaths addObject:originIndexPath];
    [self.leftIndexPaths removeObject:indexPath];
    [self.cardIndexPaths removeObject:originIndexPath];
    [self.cardIndexPaths addObject:indexPath];
    card.indexPath = indexPath;
    
    NSInteger timeMultiplier = (NSInteger)fabs((originIndexPath.row - indexPath.row) + (originIndexPath.section - indexPath.section));
    [UIView animateWithDuration:0.1f * timeMultiplier
                     animations:^{
                         [card setFrame:[self cardFrameForIndexPath:indexPath]];
                     }
                     completion:^(BOOL finished) {
                         
                     }
     ];
}

- (void)moveUp{
    [self refreshCardIndexStatus];
    BOOL moved = NO;
    
    for (NSInteger section = 0; section < SECTION_LIMIT; section ++){
        for (NSInteger row = 0; row < ROW_LIMIT; row ++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            HYBCard *card = [self cardForIndexPath:indexPath];
            if (card){
                if (card.indexPath.section > 0){
                    for (NSInteger tmpSection = card.indexPath.section - 1; tmpSection >= 0; tmpSection --){
                        HYBCard *desCard = [self cardForIndexPath:[NSIndexPath indexPathForRow:row inSection:tmpSection]];
                        if (desCard){
                            if (desCard.exp == card.exp && !desCard.currentAdded){
                                moved = YES;
                                [self animateCard:card toCard:desCard];
                                continue;
                            }else{
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
    
    for (NSInteger section = 0; section < SECTION_LIMIT; section ++){
        for (NSInteger row = 0; row < ROW_LIMIT; row ++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            HYBCard *card = [self cardForIndexPath:indexPath];
            if (card){
                if (card.indexPath.section > 0){
                    BOOL canSlide = NO;
                    NSInteger desSection = -1;
                    for (NSInteger tmpSection = card.indexPath.section - 1; tmpSection >= 0; tmpSection --){
                        HYBCard *desCard = [self cardForIndexPath:[NSIndexPath indexPathForRow:row inSection:tmpSection]];
                        if (desCard){

                        }
                        else{
                            desSection = tmpSection;
                            canSlide = YES;
                            continue;
                        }
                    }
                    if (canSlide && desSection >= 0){
                        NSIndexPath *desIndexPath = [NSIndexPath indexPathForRow:row inSection:desSection];
                        [self animateCard:card toIndexPath:desIndexPath];
                        moved = YES;
                    }
                }
            }
        }
    }


    if (!moved){
        return;
    }
    self.userInteractionEnabled = NO;
    [self performSelector:@selector(addRandomCard) withObject:nil afterDelay:0.1f];
}

- (void)moveDown{
    [self refreshCardIndexStatus];
    BOOL moved = NO;
    
    for (NSInteger section = SECTION_LIMIT - 1; section >= 0; section --){
        for (NSInteger row = 0; row < ROW_LIMIT; row ++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            HYBCard *card = [self cardForIndexPath:indexPath];
            if (card){
                if (card.indexPath.section < SECTION_LIMIT - 1){
                    for (NSInteger tmpSection = card.indexPath.section + 1; tmpSection < SECTION_LIMIT; tmpSection ++){
                        HYBCard *desCard = [self cardForIndexPath:[NSIndexPath indexPathForRow:row inSection:tmpSection]];
                        if (desCard){
                            if (desCard.exp == card.exp  && !desCard.currentAdded){
                                moved = YES;
                                [self animateCard:card toCard:desCard];
                                continue;
                            }else{
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
    
    for (NSInteger section = SECTION_LIMIT - 1; section >= 0; section --){
        for (NSInteger row = 0; row < ROW_LIMIT; row ++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            HYBCard *card = [self cardForIndexPath:indexPath];
            if (card){
                if (card.indexPath.section < SECTION_LIMIT - 1){
                    BOOL canSlide = NO;
                    NSInteger desSection = -1;
                    for (NSInteger tmpSection = card.indexPath.section + 1; tmpSection < SECTION_LIMIT; tmpSection ++){
                        HYBCard *desCard = [self cardForIndexPath:[NSIndexPath indexPathForRow:row inSection:tmpSection]];
                        if (desCard){
                            
                        }
                        else{
                            desSection = tmpSection;
                            canSlide = YES;
                            continue;
                        }
                    }
                    if (canSlide && desSection >= 0){
                        NSIndexPath *desIndexPath = [NSIndexPath indexPathForRow:row inSection:desSection];
                        [self animateCard:card toIndexPath:desIndexPath];
                        moved = YES;
                    }
                }
            }
        }
    }
    
    if (!moved){
        return;
    }
    self.userInteractionEnabled = NO;
    [self performSelector:@selector(addRandomCard) withObject:nil afterDelay:0.1f];
}

- (void)moveLeft{
    [self refreshCardIndexStatus];
    BOOL moved = NO;
    for (NSInteger row = 0; row < ROW_LIMIT; row ++){
        for (NSInteger section = 0; section < SECTION_LIMIT; section ++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            HYBCard *card = [self cardForIndexPath:indexPath];
            if (card){
                if (card.indexPath.row > 0){
                    for (NSInteger tmpRow = card.indexPath.row - 1; tmpRow >= 0; tmpRow --){
                        HYBCard *desCard = [self cardForIndexPath:[NSIndexPath indexPathForRow:tmpRow inSection:section]];
                        if (desCard){
                            if (desCard.exp == card.exp && !desCard.currentAdded){
                                moved = YES;
                                [self animateCard:card toCard:desCard];
                                continue;
                            }else{
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
    for (NSInteger row = 0; row < ROW_LIMIT; row ++){
        for (NSInteger section = 0; section < SECTION_LIMIT; section ++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            HYBCard *card = [self cardForIndexPath:indexPath];
            if (card){
                if (card.indexPath.row > 0){
                    BOOL canSlide = NO;
                    NSInteger desRow = -1;
                    for (NSInteger tmpRow = card.indexPath.row - 1; tmpRow >= 0; tmpRow --){
                        HYBCard *desCard = [self cardForIndexPath:[NSIndexPath indexPathForRow:tmpRow inSection:section]];
                        if (desCard){
                            
                        }
                        else{
                            desRow = tmpRow;
                            canSlide = YES;
                            continue;
                        }
                    }
                    if (canSlide && desRow >= 0){
                        NSIndexPath *desIndexPath = [NSIndexPath indexPathForRow:desRow inSection:section];
                        [self animateCard:card toIndexPath:desIndexPath];
                        moved = YES;
                    }
                }
            }
        }
    }
    if (!moved){
        return;
    }
    self.userInteractionEnabled = NO;
    [self performSelector:@selector(addRandomCard) withObject:nil afterDelay:0.1f];
}

- (void)moveRight{
    [self refreshCardIndexStatus];
    BOOL moved = NO;
    for (NSInteger row = ROW_LIMIT - 1; row >= 0; row --){
        for (NSInteger section = 0; section < SECTION_LIMIT; section ++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            HYBCard *card = [self cardForIndexPath:indexPath];
            if (card){
                if (card.indexPath.row < ROW_LIMIT - 1){
                    for (NSInteger tmpRow = card.indexPath.row + 1; tmpRow < ROW_LIMIT; tmpRow ++){
                        HYBCard *desCard = [self cardForIndexPath:[NSIndexPath indexPathForRow:tmpRow inSection:section]];
                        if (desCard){
                            if (desCard.exp == card.exp && !desCard.currentAdded){
                                moved = YES;
                                [self animateCard:card toCard:desCard];
                                continue;
                            }else{
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
    for (NSInteger row = ROW_LIMIT - 1; row >= 0; row --){
        for (NSInteger section = 0; section < SECTION_LIMIT; section ++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            HYBCard *card = [self cardForIndexPath:indexPath];
            if (card){
                if (card.indexPath.row < ROW_LIMIT - 1){
                    BOOL canSlide = NO;
                    NSInteger desRow = -1;
                    for (NSInteger tmpRow = card.indexPath.row + 1; tmpRow < ROW_LIMIT; tmpRow ++){
                        HYBCard *desCard = [self cardForIndexPath:[NSIndexPath indexPathForRow:tmpRow inSection:section]];
                        if (desCard){
                            
                        }
                        else{
                            desRow = tmpRow;
                            canSlide = YES;
                            continue;
                        }
                    }
                    if (canSlide && desRow >= 0){
                        NSIndexPath *desIndexPath = [NSIndexPath indexPathForRow:desRow inSection:section];
                        [self animateCard:card toIndexPath:desIndexPath];
                        moved = YES;
                    }
                }
            }
        }
    }
    if (!moved){
        return;
    }
    self.userInteractionEnabled = NO;
    [self performSelector:@selector(addRandomCard) withObject:nil afterDelay:0.1f];
}

- (void)addRandomCard{
    if (![self.leftIndexPaths count]){
        return;
    }
    NSInteger i = arc4random() % [self.leftIndexPaths count];
    NSIndexPath *newIndexPath = [self.leftIndexPaths objectAtIndex:i];
    CGRect frame = [self cardFrameForIndexPath:newIndexPath];
    frame.size = CGSizeZero;
    HYBCard *newCard = [[HYBCard alloc] initWithFrame:frame];
    newCard.delegate = self;
    newCard.exp = 1;
    newCard.indexPath = newIndexPath;
    [self.cardIndexPaths addObject:newIndexPath];
    [self.leftIndexPaths removeObject:newIndexPath];
    [self addSubview:newCard];
    [UIView animateWithDuration:0.2
                     animations:^{
                         [newCard setFrame:[self cardFrameForIndexPath:newIndexPath]];
                     }
                     completion:^(BOOL finished) {
    
                     }];

    self.userInteractionEnabled = YES;
}

- (HYBCard *)cardForIndexPath:(NSIndexPath *)indexPath{
    if (![self.cardIndexPaths containsObject:indexPath]){
        return nil;
    }
    for (HYBCard *tmpCard in self.subviews){
        if (![tmpCard isKindOfClass:[HYBCard class]]){
            continue;
        }
        if ([tmpCard.indexPath isEqual:indexPath]){
            return tmpCard;
        }
    }
    return nil;
}

- (CGRect)cardFrameForIndexPath:(NSIndexPath*)indexPath{
    CGRect resultFrame = CGRectZero;
    resultFrame.size = CARD_SIZE;
    CGPoint origin = CGPointZero;
    origin.x = INTERVAL + indexPath.row * (INTERVAL + CARD_SIZE.width);
    origin.y = INTERVAL + indexPath.section * (INTERVAL + CARD_SIZE.height);
    resultFrame.origin = origin;
    return resultFrame;
}

#pragma mark - init

- (void)initGestureRecognizer{
    UISwipeGestureRecognizer *swipeRightRecognizer;
    swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveRight)];
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRightRecognizer];
    
    UISwipeGestureRecognizer *swipeLeftRecognizer;
    swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveLeft)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeftRecognizer];
    
    UISwipeGestureRecognizer *swipeUpRecognizer;
    swipeUpRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveUp)];
    swipeUpRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUpRecognizer];
    
    UISwipeGestureRecognizer *swipeDownRecognizer;
    swipeDownRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveDown)];
    swipeDownRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDownRecognizer];
}

- (void)refreshCardIndexStatus{
    for (NSInteger section = 0; section < SECTION_LIMIT; section ++){
        for (NSInteger row = 0; row < ROW_LIMIT; row ++){
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            HYBCard *card = [self cardForIndexPath:newIndexPath];
            if (card){
                card.currentAdded = NO;
            }
        }
    }
}

- (void)initCardIndexPaths{
    self.cardIndexPaths = [NSMutableArray array];
    self.leftIndexPaths = [NSMutableArray array];
    for (NSInteger section = 0; section < SECTION_LIMIT; section ++){
        for (NSInteger row = 0; row < ROW_LIMIT; row ++){
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [self.leftIndexPaths addObject:newIndexPath];
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"HYBChessboard" owner:self options:nil];
        if (nibs){
            self = nibs[0];
        }
        self.layer.cornerRadius = 6;
        [self setFrame:frame];
        [self initCardIndexPaths];
        [self initGestureRecognizer];
        for (NSInteger section = 0; section < SECTION_LIMIT; section ++){
            for (NSInteger row = 0; row < ROW_LIMIT; row ++){
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
                UIView *cover = [[UIView alloc] initWithFrame:[self cardFrameForIndexPath:newIndexPath]];
                cover.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:192.0/255.0 blue:180.0/255.0 alpha:1.f];
                cover.layer.cornerRadius = 4;
                [self addSubview:cover];
            }
        }
        
        [self addRandomCard];
        [self addRandomCard];
    }
    return self;
}

#pragma mark - HYBCard Delegate

- (void)cardDidPressed:(HYBCard *)card{
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = card.imageView.image;
    imageInfo.referenceRect = card.frame;
    imageInfo.referenceView = self.superview;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundStyle_ScaledDimmedBlurred];
    
    // Present the view controller.
    [self.delegate chessboard:self didPerformAction:HYBChessboardActionSelectCard withObject:imageViewer];
//    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

@end
