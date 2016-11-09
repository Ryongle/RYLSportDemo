//
//  RYLSportTracking.h
//  RYLSport
//
//  Created by 任永乐 on 16/10/21.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RYLSportTrackingLine.h"

extern NSString * const RYLSportGPSStateNotification;
/// 运动类型枚举
typedef enum: NSInteger{
    RYLSportTypeRun = 1,
    RYLSportTypeWalk,
    RYLSportTypeBike

}RYLSportType;

/// 运动状态枚举
typedef enum : NSUInteger {
    RYLSportStatePause = 1,
    RYLSportStateContinue,
    RYLSportStateFinish,
} RYLSportState;

typedef enum : NSUInteger {
    RYLSportGPSStateDisconnect,
    RYLSportGPSStateBad,
    RYLSportGPSStateNormal,
    RYLSportGPSStateGood
} RYLSportGPSState;
/**
 单次运动轨迹追踪模型
 */
@interface RYLSportTracking : NSObject

/**
 使用运动类型实例化追踪模型
 
 @param type type
 
 @return 追踪模型
 */
- (instancetype)initWithSportType:(RYLSportType)type state:(RYLSportState)state;

/**
 运动类型
 */
@property (nonatomic,assign,readonly)RYLSportType sportType;

/**
 运动状态
 */
@property (nonatomic,assign)RYLSportState state;

/**
 运动图像
 */
@property (nonatomic,strong,readonly)UIImage *image;

/**
 运动的起点
 */
@property(nonatomic,strong,readonly)CLLocation *startSportLocation;

/**
 平均速度
 */
@property (nonatomic,readonly)double avgSpeed;

/**
 最大速度
 */
@property (nonatomic,readonly)double maxSpeed;

/**
 总时长
 */
@property (nonatomic,readonly)double totalTime;

/**
 总距离
 */
@property (nonatomic,readonly)double totalDistance;
/**
 总时长  00:00:00 格式的字符串
 */
@property (nonatomic,copy,readonly)NSString *totalTimeStr;


/**
 追加用户当前位置，返回折线模型
 
 @param location location
 
 @return 折线模型
 */
- (RYLSportPolyline *)appendLocation:(CLLocation *)location;

@end
