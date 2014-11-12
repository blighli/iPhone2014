//
//  print_result.h
//  project1
//
//  Created by Frank Yuan on 10/25/12.
//  Copyright (c) 2012 Frank Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface print_result : NSObject
@property int m_year,m_month;
-(void)showResult;
-(BOOL)isValid;
-(id)init;
@end
