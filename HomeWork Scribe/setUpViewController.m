//
//  setUpViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/4/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "setUpViewController.h"

@interface setUpViewController ()

@end

@implementation setUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    NSArray *thesub = @[@"Math",@"Social Studies",@"Science",@"English",@"Language"];
    [[NSUserDefaults standardUserDefaults]setObject:thesub forKey:@"chosenSubjects"];
    [[NSUserDefaults standardUserDefaults]synchronize];
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
