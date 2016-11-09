//
//  RYLSportCameraMaskView.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/28.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportCameraMaskView.h"
#import "RYLAdditions.h"
@interface RYLSportCameraMaskView()
@property (nonatomic, weak) IBOutlet UIImageView *imageV;
@end

@implementation RYLSportCameraMaskView


- (void)drawRect:(CGRect)rect {
    {
        [[UIColor r_colorWithHex:0x24282e] setFill];
    
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
        
        [path fill];
    }
    
    {
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
        [[UIColor r_colorWithHex:0x1a1a1a] setStroke];
        
        [path stroke];
        
        
    }

    
    CGContextClearRect(UIGraphicsGetCurrentContext(), CGRectInset(_imageV.frame, 1, 1));
    
}

@end
