//
//  HYBChessboard.h
//  2048
//
//  Created by hyb on 14/12/30.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBCard.h"

#import "JTSImageViewController.h"
#import "JTSImageInfo.h"

typedef enum{
    HYBChessboardActionSelectCard
}HYBChessboardAction;

@class HYBChessboard;
@protocol HYBChessboardDelegate <NSObject>

- (void)chessboard:(HYBChessboard *)chessboard didPerformAction:(HYBChessboardAction)action withObject:(id)object;

@end

@interface HYBChessboard : UIView <HYBCardDelegate>

@property (strong, atomic) NSMutableArray *cardIndexPaths;
@property (strong, atomic) NSMutableArray *leftIndexPaths;

@property (assign, nonatomic) id <HYBChessboardDelegate> delegate;

//- (void)moveWithDirection:(CGPoint)direction;

@end
