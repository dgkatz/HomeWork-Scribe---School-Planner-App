//
//  rootViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/27/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tutorialViewController.h"
@interface rootViewController : UIViewController <UIPageViewControllerDataSource>
@property (nonatomic,strong) UIPageViewController *PageViewController;
@property (nonatomic,strong) NSArray *arrPageTitles;
@property (nonatomic,strong) NSArray *arrPageImages;

- (tutorialViewController *)viewControllerAtIndex:(NSUInteger)index;

@end
