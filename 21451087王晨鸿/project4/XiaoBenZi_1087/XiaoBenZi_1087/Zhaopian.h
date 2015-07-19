//
//  Zhaopian.h
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-23.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import<UIKit/UIKit.h>
#import "OnePiece.h"


@interface Zhaopian : UIViewController<UITableViewDelegate,UITableViewDataSource,NSCoding>
{
    IBOutlet UITableView * talbeView;
    NSMutableArray * arrayOnePiece;
}

@end
