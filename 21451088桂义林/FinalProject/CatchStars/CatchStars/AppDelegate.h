//
//  AppDelegate.h
//  CatchStars
//
//  Created by YilinGui on 14-12-19.
//  Copyright Yilin Gui 2014年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

NSString *docPath(void);

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*__unsafe_unretained director_;							// weak ref
    
    NSMutableArray *scoreArray;
    //NSString *testStr;
}

@property (nonatomic, strong) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

//- (NSString *)getTestStr;

- (NSMutableArray *)getScores;

- (void)setScores:(NSMutableArray *)scores;

- (void)writeScoresToFile;

@end
