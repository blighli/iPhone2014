
//  Created by GUO on 14-11-05.
//  Copyright (c) 2014年 GUO
//

#import <UIKit/UIKit.h>

#define kClear          10
#define kDel            11
#define kDevide         12
#define kMultiply       13
#define kSub            14
#define kPlus           15
#define kEqual          16
#define kRightBracket   17
#define kLeftBracket    18
#define kDot            19
#define kPower          20
#define kSin            21
#define kCos            22
#define kLog            24


@interface CalculatorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *totalResultLabel;
@property (weak, nonatomic) IBOutlet UITextField *resultText;


- (IBAction)tapAction:(UIButton *)sender;





@end
