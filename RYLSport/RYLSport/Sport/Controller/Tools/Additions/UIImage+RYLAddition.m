//
//  UIImage+RYLAddition.m
//  SinaWeiboForOC
//
//  Created by 任永乐 on 16/10/4.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIImage+RYLAddition.h"

@implementation UIImage (RYLAddition)
+ (UIImage *)r_screenShot{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIGraphicsBeginImageContext(window.bounds.size);
    
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
- (UIImage *)r_scaleImageWithScaleWidth:(CGFloat)scaleWidth{
    CGFloat scaleHeight = scaleWidth / self.size.width * self.size.height;
    CGSize size = CGSizeMake(scaleWidth, scaleHeight);
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
@end
