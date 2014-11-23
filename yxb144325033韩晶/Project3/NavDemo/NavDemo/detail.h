//
//  detail.h
//  notes
//
//  Created by hanxue on 14/11/17.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#ifndef notes_detail_h
#define notes_detail_h


#endif
#import <UIKit/UIKit.h>

@interface Detailview : UIViewController<UITextViewDelegate,UIActionSheetDelegate>

{
    UITextView *textview;
    UIButton *imageBtn0;
    UIButton *imageBtn1;
    UIButton *imageBtn2;
    UIButton *imageBtn3;
}

@property  NSInteger identify;

@end