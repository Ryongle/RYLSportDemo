//
//  NSDate+RYLCompareDate.m
//  SinaWeiboForOC
//
//  Created by 任永乐 on 16/9/28.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NSDate+RYLCompareDate.h"

@implementation NSDate (RYLCompareDate)
+ (NSDate *)r_dateWithStr:(NSString *)dateStr{
    NSDateFormatter *dt = [[NSDateFormatter alloc]init];
    dt.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
    dt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    NSDate *date = [dt dateFromString:dateStr];
    
    return date;
    
}

- (NSString *)r_compareDate{
    NSDateFormatter *dt = [[NSDateFormatter alloc]init];
    
    dt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    if([self isThisYearWithDate:self]){
        
        NSCalendar *currenCalender = [NSCalendar currentCalendar];
        if([currenCalender isDateInToday:self]){
            NSTimeInterval timeItv = self.timeIntervalSinceNow;
            if(timeItv < 60){
                
                return @"刚刚";
            }else if(timeItv < 3600){
                int result = timeItv / 60;
                return [NSString stringWithFormat:@"%d分钟前",result];
                
            }else{
                int result = timeItv / 3600;
                
                return [NSString stringWithFormat:@"%d小时前",result];
                
            }
            
            
        }else if([currenCalender isDateInYesterday:self]){
            
            dt.dateFormat = @"昨天 HH:mm";
        }else {
            
            dt.dateFormat = @"MM-dd HH:mm";
        }
        
        
        
    }else {
        
        dt.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    
    return [dt stringFromDate:self];
    
}

- (BOOL)isThisYearWithDate:(NSDate *)date{
    NSDateFormatter *dt = [[NSDateFormatter alloc]init];
    dt.dateFormat = @"yyyy";
    dt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSString *atYear = [dt stringFromDate:date];
    NSString *currentYear = [dt stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    
    
    return [atYear isEqualToString:currentYear];
    
}

@end
