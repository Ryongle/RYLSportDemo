//
//  UIScreen+CZAddition.m
//  001-Meituan
//
//  Created by 刘凡 on 16/5/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIScreen+RYLAddition.h"

@implementation UIScreen (RYLAddition)

+ (CGFloat)r_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)r_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)r_scale {
    return [UIScreen mainScreen].scale;
}

@end
