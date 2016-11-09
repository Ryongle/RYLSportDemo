//
//  RYLSportAnimator.m
//  RYLSport
//
//  Created by 任永乐 on 16/10/24.
//  Copyright © 2016年 ryl. All rights reserved.
//

#import "RYLSportAnimator.h"
@interface RYLSportAnimator ()<UIViewControllerAnimatedTransitioning,UIApplicationDelegate>

@end
@implementation RYLSportAnimator{
    BOOL _isPresent;
    __weak id <UIViewControllerContextTransitioning> _transitionContext;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _isPresent = YES;
    return self;
    
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _isPresent = NO;
    return self;
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 2;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerV = [transitionContext containerView];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *view = _isPresent? toView : fromView;
    if(_isPresent){
        [containerV addSubview:view];
    }
    
    [self animationWithView:view];
    
    
    _transitionContext = transitionContext;
    
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_transitionContext completeTransition:YES];
}

- (void)animationWithView:(UIView *)view{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    CGFloat topMargin = 28;
    CGFloat rightMargin = 16;
    CGFloat radio = 30;
    CGFloat viewH = view.bounds.size.height;
    CGFloat viewW = view.bounds.size.width;
    
    
    CGRect startRect = CGRectMake(viewW - rightMargin - radio, topMargin, radio, radio);
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithOvalInRect:startRect];

    layer.path = beginPath.CGPath;
    
    CGFloat maxRadio = sqrt(viewW * viewW + viewH * viewH);
    
    CGRect endRect = CGRectInset(startRect, -maxRadio, -maxRadio);
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    view.layer.mask = layer;
    
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    
    if(_isPresent){
        anim.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
        anim.toValue = (__bridge id _Nullable)(endPath.CGPath);
    }else {
        anim.fromValue = (__bridge id _Nullable)(endPath.CGPath);
        anim.toValue = (__bridge id _Nullable)(beginPath.CGPath);
    }
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.duration = [self transitionDuration:_transitionContext];
    
    anim.delegate = self;
    
    [layer addAnimation:anim forKey:nil];
 
}



@end
