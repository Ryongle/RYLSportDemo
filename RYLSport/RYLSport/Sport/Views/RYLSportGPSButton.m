//
//  RYLSportGPSButton.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/26.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportGPSButton.h"
#import "RYLSportTracking.h"
@implementation RYLSportGPSButton
- (void)awakeFromNib{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sportGPSChangeNotify:) name:RYLSportGPSStateNotification object:nil];
    
}

- (void)sportGPSChangeNotify:(NSNotification *)noti{
    RYLSportGPSState state = [noti.object integerValue];
    
    NSString *title;
    NSString *imageName = (self.tag == 10) ? @"ic_sport_gps_map_":@"ic_sport_gps_";
    
    switch (state) {
        case RYLSportGPSStateDisconnect:
            title = @" GPS信号已断开";
            imageName = [imageName stringByAppendingString:@"disconnect"];
            break;
        case RYLSportGPSStateBad:
            title = @" 请绕开高楼大厦";
            imageName = [imageName stringByAppendingString:@"connect_1"];
            break;
        case RYLSportGPSStateNormal:
            imageName = [imageName stringByAppendingString:@"connect_2"];
            break;
        case RYLSportGPSStateGood:
            imageName = [imageName stringByAppendingString:@"connect_3"];
            break;
 
    }

    
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UIEdgeInsets inset = self.contentEdgeInsets;
    inset.right = (title == nil) ? 4 : 8;
    
    self.contentEdgeInsets = inset;
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
