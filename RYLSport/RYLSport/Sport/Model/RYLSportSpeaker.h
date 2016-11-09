//
//  RYLSportSpeaker.h
//  RYLSport
//
//  Created by 任永乐 on 16/10/27.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RYLSportTracking.h"
/**
 运动语音播报
 */
@interface RYLSportSpeaker : NSObject

/**
 开始指定类型的运动

 @param type 运动类型
 */
- (void)speakeWithType:(RYLSportType)type;


/**
 修改运动状态

 @param state 运动状态
 */
- (void)speakeWithState:(RYLSportState)state;


/**
 单位距离
 */
@property (nonatomic, assign) double unitDistance;


/**
 整体单位距离的播报

 @param distance 距离
 @param time     时间
 @param avgSpeed 速度
 */
- (void)speakeWithDistance:(double)distance time:(NSTimeInterval)time avgSpeed:(double)avgSpeed;



@end
