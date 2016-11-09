//
//  RYLSportMainViewController.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/21.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportMainViewController.h"
#import "RYLSportTracking.h"
#import "RYLSportSportingViewController.h"

@interface RYLSportMainViewController ()

@end

@implementation RYLSportMainViewController
- (IBAction)sportBtnClick:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"RYLSportSportingView" bundle:nil];
    RYLSportSportingViewController *vc = [sb instantiateInitialViewController];
    
    vc.sportType = sender.tag;
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
