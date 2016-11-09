//
//  RYLSportSportingViewController.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/21.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportSportingViewController.h"
#import "RYLSportMapViewController.h"
#import "RYLAdditions.h"
#import "RYLSportSpeaker.h"
#import "RYLSportCameraViewController.h"

@interface RYLSportSportingViewController ()<RYLSportMapViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *presentBtn;

@property(strong,nonatomic)RYLSportMapViewController *mapVc;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgSpeedLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stopBtnCenterXCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pauseBtnCenterXCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *continueBtnCenterXCons;

@end

@implementation RYLSportSportingViewController{
    RYLSportSpeaker *_sportSpeaker;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sportSpeaker = [[RYLSportSpeaker alloc]init];
    
    _sportSpeaker.unitDistance = 0.05;
    
    [self setMapViewUP];
    
    [self setupBackgroundLayer];
    
    
}

- (IBAction)cameraAction:(id)sender {
    RYLSportCameraViewController *vc = [[RYLSportCameraViewController alloc]init];
    
    [self presentViewController:vc animated:YES completion:nil];
}




- (IBAction)changeSportState:(UIButton *)sender{
    
    RYLSportState state = sender.tag;
    
    _mapVc.sportTracking.state = state;
    
    CGFloat offset = (state == RYLSportStatePause) ? -80: 80;
    
    _stopBtnCenterXCons.constant -= offset;
    _pauseBtnCenterXCons.constant += offset;
    _continueBtnCenterXCons.constant += offset;
    
    [UIView animateWithDuration:0.25 animations:^{
        _pauseBtn.alpha = (sender != _pauseBtn);
        
        [self.view layoutIfNeeded];
    }];
    
    
    
    
    [_sportSpeaker speakeWithState:state];
    
    
}

- (IBAction)presentMapBtnClick:(id)sender {
    
    [self presentViewController:_mapVc animated:YES completion:nil];
    
}

-(void)viewDidLayoutSubviews{
    
    _mapVc.mapView.compassOrigin = CGPointMake(_presentBtn.center.x - _mapVc.mapView.compassSize.width * 0.5, _presentBtn.center.y - _mapVc.mapView.compassSize.height * 0.5);
}




- (void)sportMapViewControllerDidChangeData:(RYLSportMapViewController *)vc{
    
    RYLSportTracking *model = vc.sportTracking;
    
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%.02f",model.totalDistance];
    self.timeLabel.text = model.totalTimeStr;
    self.avgSpeedLabel.text = [NSString stringWithFormat:@"%.02f",model.avgSpeed];
    
    if(model.state == RYLSportStatePause && _pauseBtn.alpha == 1){
        [self changeSportState:_pauseBtn];
    }
    
    if(model.state == RYLSportStateContinue && _pauseBtn.alpha == 0){
        [self changeSportState:_continueBtn];
    }
    
    
    [_sportSpeaker speakeWithDistance:model.totalDistance time:model.totalTime avgSpeed:model.avgSpeed];
    
    
}





- (void)setMapViewUP{
    
    
//    for (UIViewController *vc in self.childViewControllers) {
//        if([vc isKindOfClass:[RYLSportMapViewController class]]){
//            
//            _mapVc = (RYLSportMapViewController *)vc;
//            break;
//        }
//    }

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RYLSportSportingView" bundle:nil];
    _mapVc = [sb instantiateViewControllerWithIdentifier:@"RYLSportMapVC"];
    
    _mapVc.sportTracking = [[RYLSportTracking alloc]initWithSportType:_sportType state:RYLSportStateContinue];
    _mapVc.delegate = self;
    
    [_sportSpeaker speakeWithType:_sportType];
    
    
//    RYLSportMapViewController *vc = [[RYLSportMapViewController alloc] init];
//    [self addChildViewController:vc];
//    
//    [self.view addSubview:vc.view];
//    vc.view.frame = self.view.bounds;
//    
//    vc.sportTracking = [[RYLSportTracking alloc]initWithSportType:_sportType state:RYLSportStateContinue];
//    
//    
//    [vc didMoveToParentViewController:self];
    
}

- (void)setupBackgroundLayer{
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.bounds = self.view.bounds;
    layer.position = self.view.center;
    
    CGColorRef color1 = [UIColor r_colorWithHex:0x0e1428].CGColor;
    CGColorRef color2 = [UIColor r_colorWithHex:0x406479].CGColor;
    CGColorRef color3 = [UIColor r_colorWithHex:0x406578].CGColor;
    
    layer.colors = @[(__bridge UIColor *)color1,(__bridge UIColor *)color2,(__bridge UIColor *)color3];
    layer.locations = @[@0,@0.6,@1];
    
    [self.view.layer insertSublayer:layer atIndex:0];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
