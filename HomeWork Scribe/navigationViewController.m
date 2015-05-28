//
//  navigationViewController.m
//  slideOutMenu
//
//  Created by Family on 1/3/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "navigationViewController.h"
#import "SWRevealViewController.h"
#import "SDiPhoneVersion.h"
@interface navigationViewController ()

@end

@implementation navigationViewController{
    NSArray *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    menu = @[@"third",@"first",@"5",@"6",@"4",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14"];
    self.tableView.scrollEnabled = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [[cell textLabel] setHighlightedTextColor:[UIColor whiteColor]];
    
    // background image
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor orangeColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 140;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *CellIdentifier = @"header";
    UITableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UIImageView *label = (UIImageView *)[headerView.contentView viewWithTag:27];
    if ([SDiPhoneVersion deviceSize] == iPhone35inch) {
        label.image = [UIImage imageNamed:@"320X140Alt.png"];
        //nslog(@"smallest");
    }
    else if ([SDiPhoneVersion deviceSize] == iPhone4inch){
        label.image = [UIImage imageNamed:@"320X140Alt.png"];
        //nslog(@"smallest");

    }
    else if ([SDiPhoneVersion deviceSize] == iPhone47inch){
        label.image = [UIImage imageNamed:@"375X140Alt.png"];
        //nslog(@"medium");
    }
    else if ([SDiPhoneVersion deviceSize] == iPhone55inch){
        label.image = [UIImage imageNamed:@"414X140Alt"];
        //nslog(@"large");
    }
    if (section == 0) {
        if (headerView == nil){
            [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
        }
        
    }
    else{
        headerView = nil;
    }
    
    return headerView;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [segue isKindOfClass:[SWRevealViewControllerSegue class]]) {
        SWRevealViewControllerSegue *swSeque = (SWRevealViewControllerSegue *)segue;
        swSeque.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController*svc, UIViewController*dvc) {
            UINavigationController* navController = ( UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers:@[dvc] animated:NO];
            [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        };
    }



}

@end
