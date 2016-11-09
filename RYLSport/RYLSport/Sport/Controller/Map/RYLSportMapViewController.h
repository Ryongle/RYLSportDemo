//
//  RYLSportMapViewController.h
//  RYLSport
//
//  Created by 任永乐 on 16/10/21.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYLSportTracking.h"
@class RYLSportMapViewController;
@protocol RYLSportMapViewControllerDelegate <NSObject>

- (void)sportMapViewControllerDidChangeData:(RYLSportMapViewController *)vc;

@end



@interface RYLSportMapViewController : UIViewController

@property(nonatomic,strong)RYLSportTracking *sportTracking;

@property(weak,nonatomic,readonly)MAMapView *mapView;

@property (weak, nonatomic) id<RYLSportMapViewControllerDelegate> delegate;

@end
