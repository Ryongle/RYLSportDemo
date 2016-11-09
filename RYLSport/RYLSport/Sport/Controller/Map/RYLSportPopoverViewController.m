//
//  RYLSportPopoverViewController.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/26.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportPopoverViewController.h"

@interface RYLSportPopoverViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *mapModeBtn;

@end

@implementation RYLSportPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIButton *btn in _mapModeBtn) {
        btn.selected = (btn.tag == _currentMapType);
    }
    
    
}
- (IBAction)changeMapMode:(UIButton *)sender {
    
    if(_currentMapType == sender.tag){
        return;
    }
    
    _currentMapType = sender.tag;
    
    
    if(_didSelectedMapMode != nil){
        _didSelectedMapMode(_currentMapType);
    }
    
    
    
    for (UIButton *btn in _mapModeBtn) {
        btn.selected = (sender == btn);
    }
    
    
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
