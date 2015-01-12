//
//  HYBViewController.h
//  2048
//
//  Created by hyb on 14/12/30.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBChessboard.h"

@interface HYBGameController : UIViewController <HYBChessboardDelegate>

@property (strong, nonatomic) HYBChessboard *chessboard;

@end
