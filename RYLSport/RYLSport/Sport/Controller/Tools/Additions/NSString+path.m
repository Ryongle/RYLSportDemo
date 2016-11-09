//
//  NSObject+path.m
//  DownLoadData
//
//  Created by 任永乐 on 16/8/20.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

- (NSString *)r_filePath{
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *name = [self lastPathComponent];
    
    NSString *file = [path stringByAppendingPathComponent:name];
    return file;
}
@end
