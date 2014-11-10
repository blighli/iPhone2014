//
//  printcalendar.h
//  HomeworkOne
//
//  Created by HJ on 14-10-8.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#ifndef HomeworkOne_printcalendar_h
#define HomeworkOne_printcalendar_h


#endif
#import <Cocoa/Cocoa.h>
@interface Printcalendar : NSObject
{
    @private
    int whitchyear;
    int witchmounth;
}
-(void)Printmounthcalendar: (int) whitchyear : (int) witchmounth;
-(void)Printyearcalendar: (int) whitchyear;
-(int)weekday: (int)whitchyear : (int)witchmounth;
-(int)day:(int) whitchyear : (int) witchmounth;
@end