//
//  NSDate+RYLCompareDate.h
//  SinaWeiboForOC
//
//  Created by 任永乐 on 16/9/28.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RYLCompareDate)

+ (NSDate *)r_dateWithStr:(NSString *)dateStr;

- (NSString *)r_compareDate;

@end
