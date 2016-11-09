//
//  RYLSportPolyline.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/22.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportPolyline.h"

@implementation RYLSportPolyline
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color{
    RYLSportPolyline *polyline = [RYLSportPolyline polylineWithCoordinates:coords count:count];
    polyline.color = color;
    return polyline;
}
@end
