//
//  RYLSportTracking.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/21.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportTracking.h"
NSString * const RYLSportGPSStateNotification = @"RYLSportGPSStateNotification";

@implementation RYLSportTracking{
    
    CLLocation *_startLocation;
    NSMutableArray <RYLSportTrackingLine *> *_trackingLines;
    CGFloat _factor;
    CLLocation *_gpsLocation;
}
- (instancetype)initWithSportType:(RYLSportType)type state:(RYLSportState)state{
    if(self = [super init]){
        _sportType = type;
        _state = state;
        _trackingLines = [NSMutableArray array];
    }
    return self;
}
- (UIImage *)image{
    UIImage *img;
    switch (_sportType) {
        case RYLSportTypeRun:
            img = [UIImage imageNamed:@"map_annotation_run"];
            _factor = 8;
            break;
        case RYLSportTypeWalk:
            img = [UIImage imageNamed:@"map_annotation_walk"];
            _factor = 12;
            break;
        case RYLSportTypeBike:
            img = [UIImage imageNamed:@"map_annotation_bike"];
            _factor = 5;
            break;
        default:
            break;
    }
    return img;
}

- (void)setState:(RYLSportState)state{
    _state = state;
    
    if(_state != RYLSportStateContinue){
        _startLocation = nil;
    }
    
    
}

- (CLLocation *)startSportLocation{
    return _trackingLines.firstObject.startLocation;
}

- (NSString *)totalTimeStr{
    
    NSInteger time = (NSInteger)self.totalTime;
    
    return [NSString stringWithFormat:@"%02zd:%02zd:%02zd",time / 3600,(time % 3600) / 60,time % 60];
}


- (RYLSportGPSState)gpsWithLocation:(CLLocation *)location{
    RYLSportGPSState state = RYLSportGPSStateBad;
    
    if(location.speed < 0){
        [self postNotificationWithState:state];
        return state;
    }
    if(_gpsLocation == nil){
        _gpsLocation = location;
        [self postNotificationWithState:state];
        return state;
    }
    
    NSTimeInterval detal = ABS([location.timestamp timeIntervalSinceDate:_gpsLocation.timestamp]);
    
    detal = ABS(detal - 1);
    
    if(detal < 0.05){
        state = RYLSportGPSStateGood;
        
    }else if(detal < 1){
        state = RYLSportGPSStateNormal;
    }
    
    [self postNotificationWithState:state];
    
    _gpsLocation = location;
    
    
    return state;
}

- (void)postNotificationWithState:(RYLSportGPSState)state{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:RYLSportGPSStateNotification object:@(state)];
    
}

- (void)checkSportStateWithLocation:(CLLocation *)location{
    
    if(self.startSportLocation == nil){
        return;
    }
    if(location.speed == 0 && _state == RYLSportStateContinue){
        _state = RYLSportStatePause;
    }
    
    if(location.speed > 0 && _state == RYLSportStatePause){
        _state = RYLSportStateContinue;
    }
    
    
}





- (RYLSportPolyline *)appendLocation:(CLLocation *)location{
    
    
    if([self gpsWithLocation:location] < RYLSportGPSStateNormal){
        return nil;
    }
    
    [self checkSportStateWithLocation:location];
    
    if(location.speed <= 0){
        return nil;
    }
    
    CGFloat factor = 2;
    if([[NSDate date] timeIntervalSinceDate:location.timestamp] > factor){
        return nil;
    }
    
    
    if(_startLocation == nil){
        _startLocation = location;
        return nil;
    }
    
    
    RYLSportTrackingLine *trackingLine = [[RYLSportTrackingLine alloc]initWithStartLocation:_startLocation endLocation:location];
    trackingLine.factor = _factor;
    [_trackingLines addObject:trackingLine];
    
    
    _startLocation = location;
    
    return trackingLine.polyline;
    
}

- (double)avgSpeed{
    return [[_trackingLines valueForKeyPath:@"@avg.speed"] doubleValue];
}
- (double)maxSpeed{
    return [[_trackingLines valueForKeyPath:@"@max.speed"] doubleValue];
}

- (double)totalTime{
    return [[_trackingLines valueForKeyPath:@"@sum.time"] doubleValue];
}

- (double)totalDistance{
    return [[_trackingLines valueForKeyPath:@"@sum.distance"] doubleValue];
}

@end
