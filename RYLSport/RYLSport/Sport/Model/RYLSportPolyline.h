//
//  RYLSportPolyline.h
//  RYLSport
//
//  Created by 任永乐 on 16/10/22.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface RYLSportPolyline : MAPolyline

+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color;


@property (nonatomic, strong) UIColor *color;



@end
