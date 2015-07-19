//
//  ChakanWenzi.h
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-21.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import<UIKit/UIKit.h>
#import "OnePiece.h"

@interface ChakanWenzi : UIViewController
{

    IBOutlet UITextView * content;
}

@property (retain, nonatomic) IBOutlet UITextField * titleField;
@property (nonatomic,assign) IBOutlet UITextView* content;
-(IBAction)finishClick;
-(IBAction)deleteClick;
-(BOOL)querySql:(NSString *)sql database:(NSString *)databaseName;
@end
