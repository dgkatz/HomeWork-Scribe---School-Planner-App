//
//  selectdateSmallViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/7/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "selectdateSmallViewController.h"

@interface selectdateSmallViewController ()

@end
PDTSimpleCalendarViewController *calendarViewController;

@implementation selectdateSmallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [calendarViewController setDelegate:self];
    [[PDTSimpleCalendarViewCell appearance] setCircleTodayColor:[UIColor orangeColor]];
    [[PDTSimpleCalendarViewCell appearance] setCircleSelectedColor:[UIColor grayColor]];
    [[PDTSimpleCalendarViewHeader appearance] setSeparatorColor:[UIColor orangeColor]];
    self.view = calendarViewController.view;
    // Do any additional setup after loading the view.
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
