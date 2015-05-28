//
//  tutorialViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/27/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "tutorialViewController.h"
@interface tutorialViewController ()

@end

@implementation tutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentImageView.image = [UIImage imageNamed:self.imgFile];
    self.label.text = self.txtTitle;
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
