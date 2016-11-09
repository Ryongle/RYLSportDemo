//
//  RYLSportPopoverViewController.h
//  RYLSport
//
//  Created by 任永乐 on 16/10/26.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
@interface RYLSportPopoverViewController : UIViewController

@property(copy,nonatomic)void (^didSelectedMapMode)(MAMapType type);
@property(nonatomic,assign)MAMapType currentMapType;

@end
