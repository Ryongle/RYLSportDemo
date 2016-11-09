//
//  RYLSportCameraViewController.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/28.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#define CaptureAnimationDuration 0.25

@interface RYLSportCameraViewController ()
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *maskViewCons;


@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIButton *captureBtn;
@property (weak, nonatomic) IBOutlet UIButton *rotateSharedBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoImgV;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation RYLSportCameraViewController{
    
    AVCaptureDeviceInput *_input;
    
    AVCaptureStillImageOutput *_output;
    
    AVCaptureSession *_session;
    
    AVCaptureVideoPreviewLayer *_layer;
    
    UIImage *_capturePicture;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self setupCaptureSession];
    
}
- (IBAction)closeCamera:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)startCapture{
    [_session startRunning];
}

- (void)stopCapture{
    [_session stopRunning];
}


- (void)setupCaptureSession{
    
    
    AVCaptureDevice *device = [self captureDevice];
    
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
    
    _output = [[AVCaptureStillImageOutput alloc]init];
    
    
    _session = [[AVCaptureSession alloc]init];
    
    if(![_session canAddInput:_input]){
        return ;
    }
    if(![_session canAddOutput:_output]){
        return;
    }
    [_session addInput:_input];
    [_session addOutput:_output];
    
    _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    _layer.position = _previewView.center;
    _layer.bounds = _previewView.bounds;
    
    
    
    
    _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_previewView.layer insertSublayer:_layer atIndex:0];
    
    
    [self startCapture];
}



- (IBAction)cameraBtnClick:(UIButton *)sender {
    
    if(!_session.isRunning){
        
        [self rotateButtonsAnimation];
    }
    
    
    [self maskViewAnimationWithIsClose:YES];
    
    [self capturePicture];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CaptureAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self maskViewAnimationWithIsClose:NO];
    });
    
 
    
    
}

- (void)capturePicture{
    AVCaptureConnection *conn = _output.connections.firstObject;
    
    if(conn == nil){
        return;
        
    }
    
    
    [_output captureStillImageAsynchronouslyFromConnection:conn completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if(imageDataSampleBuffer == nil){
            NSLog(@"error = %@",error);
            return;
        }
       NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        UIImage *image = [UIImage imageWithData:data];
        
        CGRect rect = self.previewView.bounds;
        
        CGFloat offset = (self.view.bounds.size.height - rect.size.height) * 0.5;
        
        
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
        
        [image drawInRect:CGRectInset(rect, 0, -offset)];
        
        [self.logoImgV.image drawInRect:self.logoImgV.frame];
        
        [self.distanceLabel.attributedText drawInRect:self.distanceLabel.frame];
        
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        
        UIGraphicsEndImageContext();
        
        UIImageWriteToSavedPhotosAlbum(result, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
    }];
    
    
    
    
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSString *msg = (error == nil) ? @"照片保存成功" : @"照片保存失败";
    
    self.tipLabel.text = msg;
    
    
    [self stopCapture];
    
    double duration = 1.0;
    
    [UIView animateWithDuration:duration delay:CaptureAnimationDuration options:0 animations:^{
        self.tipLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:duration animations:^{
            
            self.tipLabel.alpha = 0;
        }];
        
        
    }];
    
    
    _capturePicture = image;
    
    
    
}





- (void)rotateButtonsAnimation{
    
    
    BOOL isEmpty = (_captureBtn.currentTitle == nil);
    NSString *title = isEmpty ? @"✓" : nil;
    [_captureBtn setTitle:title forState:UIControlStateNormal];
    
    
    UIViewAnimationOptions option = isEmpty ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft;
    
    [UIView transitionWithView:_captureBtn duration:CaptureAnimationDuration options:option animations:nil completion:^(BOOL finished) {
       
        if(title == nil){
            [self startCapture];
        }
        
    }];
    
    
    NSString *imageName = isEmpty ? @"ic_waterprint_share" : @"ic_waterprint_revolve";
    
    [_rotateSharedBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [UIView transitionWithView:_rotateSharedBtn duration:CaptureAnimationDuration options:option animations:nil completion:nil];
    
    
}




- (void)maskViewAnimationWithIsClose:(BOOL)isClose{
    if(isClose){
        
        [NSLayoutConstraint deactivateConstraints:_maskViewCons];
        
    }else{
        [NSLayoutConstraint activateConstraints:_maskViewCons];
        [self rotateButtonsAnimation];
    }
    
    [UIView animateWithDuration:CaptureAnimationDuration animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
    
    
}


- (AVCaptureDevice *)captureDevice {
    AVCaptureDevicePosition position = _input.device.position;
    
    position = (position != AVCaptureDevicePositionBack) ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
    
    
    NSArray *arr = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *device;
    for (AVCaptureDevice *obj in arr) {
        if(obj.position == position){
            device = obj;
        }
    }
    return device;
}

- (IBAction)switchCamera:(id)sender {
    
    if(!_session.isRunning){
        
        [self sharedPicture];
        
        return;
    }
    
    
    AVCaptureDevice *device = [self captureDevice];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
    
    [self stopCapture];
    
    [_session removeInput:_input];
    
    if([_session canAddInput:input]){
        _input = input;
    }
    
    
    [_session addInput:_input];
    
    [self startCapture];
    
    
}

- (void)sharedPicture{

    
    
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(BOOL)prefersStatusBarHidden{
    return YES;
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
