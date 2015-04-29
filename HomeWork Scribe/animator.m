//
//  animator.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/28/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "animator.h"
@implementation animator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect fromVCFrame = fromViewController.view.frame;
    
    CGFloat width = toViewController.view.frame.size.width;
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.frame = CGRectOffset(fromVCFrame, -width, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.frame = CGRectOffset(fromVCFrame, width, 0);
        toViewController.view.frame = fromVCFrame;
    } completion:^(BOOL finished) {
        fromViewController.view.frame = fromVCFrame;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
