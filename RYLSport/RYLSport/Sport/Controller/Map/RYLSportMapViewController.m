//
//  RYLSportMapViewController.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/21.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportMapViewController.h"
//#import <MAMapKit/MAMapKit.h>
#import "RYLSportPolyline.h"
#import "RYLSportAnimator.h"
#import "RYLSportPopoverViewController.h"

@interface RYLSportMapViewController ()<MAMapViewDelegate,UIPopoverPresentationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation RYLSportMapViewController{
    
    RYLSportAnimator *_animator;
    BOOL _hasSetStartLocation;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.modalPresentationStyle = UIModalPresentationCustom;
        _animator = [[RYLSportAnimator alloc]init];
        self.transitioningDelegate = _animator;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    if(!updatingLocation){
        return;
    }
 
    
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    
    if(!_hasSetStartLocation && _sportTracking.startSportLocation != nil){
    
        _hasSetStartLocation = YES;
        
        MAPointAnnotation *anno = [[MAPointAnnotation alloc] init];
        anno.coordinate = userLocation.location.coordinate;
    
        [mapView addAnnotation:anno];
    }
    
    
    [mapView addOverlay:[_sportTracking appendLocation:userLocation.location]];
    
    self.distanceLabel.text = [NSString stringWithFormat:@"%.02f",_sportTracking.totalDistance];
    self.timeLabel.text = _sportTracking.totalTimeStr;
    
    
    if([self.delegate respondsToSelector:@selector(sportMapViewControllerDidChangeData:)]){
        [self.delegate sportMapViewControllerDidChangeData:self];
    }
    
    
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    if(![overlay isKindOfClass:[MAPolyline class]]){
        return nil;
    }
    
    RYLSportPolyline *polyline = (RYLSportPolyline *)overlay;
    
    MAPolylineRenderer *renderer = [[MAPolylineRenderer alloc]initWithPolyline:polyline];
    renderer.lineWidth = 5;
    renderer.strokeColor = polyline.color;
    
    return renderer;
}




- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if(![annotation isKindOfClass:[MAPointAnnotation class]]){
        return nil;
    }
    static NSString *annoID = @"annoID";
    
    MAAnnotationView *annoV = [mapView dequeueReusableAnnotationViewWithIdentifier:annoID];
    if(annoV == nil){
        annoV = [[MAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annoID];
        
    }
    
    annoV.image = self.sportTracking.image;
    annoV.centerOffset = CGPointMake(0, -self.sportTracking.image.size.height * 0.5);
    
    return annoV;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if(![segue.destinationViewController isKindOfClass:[RYLSportPopoverViewController class]]){
        return;
    }
    RYLSportPopoverViewController *vc = (RYLSportPopoverViewController *)segue.destinationViewController;
    
    vc.popoverPresentationController.delegate = self;
    
    vc.preferredContentSize = CGSizeMake(0, 120);
    
    [vc setDidSelectedMapMode:^(MAMapType type) {
        _mapView.mapType = type;
    }];
    
    vc.currentMapType = _mapView.mapType;
    
    
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}



- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupUI{
    
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    [self.view insertSubview:mapView atIndex:0];
    
    mapView.showsScale = NO;
    
    mapView.showsUserLocation = YES;
    
    mapView.rotateCameraEnabled = NO;
    
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    //
    //
    mapView.allowsBackgroundLocationUpdates = YES;
    
    mapView.delegate = self;
    _mapView = mapView;
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
