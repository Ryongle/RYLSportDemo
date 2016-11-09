//
//  RYLSportTrackingLine.h
//  RYLSport
//
//  Created by 任永乐 on 16/10/22.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "RYLSportPolyline.h"
@interface RYLSportTrackingLine : NSObject

- (instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation;

@property (nonatomic, strong, readonly) CLLocation *startLocation;
@property (nonatomic, strong, readonly) CLLocation *endLocation;

@property (nonatomic, readonly)RYLSportPolyline *polyline;

@property (nonatomic, readonly) double speed;

@property (nonatomic, readonly) NSTimeInterval time;

@property (nonatomic, readonly) double distance;

@property(nonatomic,assign)CGFloat factor;
@end
