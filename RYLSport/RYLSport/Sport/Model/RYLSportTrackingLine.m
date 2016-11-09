//
//  RYLSportTrackingLine.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/22.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportTrackingLine.h"

@implementation RYLSportTrackingLine

- (instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation{
    if(self = [super init]){
        
        _startLocation = startLocation;
        _endLocation = endLocation;
        
        
    }
    return self;
}

- (RYLSportPolyline *)polyline{
    CLLocationCoordinate2D coords[2];
    
    coords[0] = _startLocation.coordinate;
    coords[1] = _endLocation.coordinate;
    
    
    CGFloat red = self.factor * self.speed / 255.0;
    
    UIColor *color = [UIColor colorWithRed:red green:1 blue:0 alpha:1];
    
    
    return [RYLSportPolyline polylineWithCoordinates:coords count:2 color:color];
}


- (NSTimeInterval)time{
    
    return [_endLocation.timestamp timeIntervalSinceDate:_startLocation.timestamp];
}

- (double)speed{
    return (_startLocation.speed + _endLocation.speed) * 0.5 * 3.6;
}

- (double)distance{
    return [_endLocation distanceFromLocation:_startLocation] * 0.001;
}

@end
