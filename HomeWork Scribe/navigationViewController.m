//
//  navigationViewController.m
//  slideOutMenu
//
//  Created by Family on 1/3/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#import "navigationViewController.h"
#import "SWRevealViewController.h"
#import "SDiPhoneVersion.h"
#import <BFPaperTableViewCell/BFPaperTableViewCell.h>
#import <UIColor+BFPaperColors.h>
@interface navigationViewController ()

@end

@implementation navigationViewController{
    NSArray *menu;
}

//-(void)viewWillDisappear:(BOOL)animated{
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//}
//-(void)viewDidAppear:(BOOL)animated{
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//
//}
-(void)viewWillAppear:(BOOL)animated{
//    for (NSString *i in menu){
//        [self.tableView registerClass:[BFPaperTableViewCell class] forCellReuseIdentifier:i];
//    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
        self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    //self.tableView.contentInset = UIEdgeInsetsMake(-22, 0, 0, 0);
    menu = @[@"third",@"first",@"5",@"6",@"4",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17"];
    self.tableView.scrollEnabled = NO;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( IDIOM == IPAD ) {
        return 80;
    }
    else{
        return 60;
    }
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
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
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
        label.image = [UIImage imageNamed:@"banner45.png"];
        //nslog(@"smallest");
    }
    else if ([SDiPhoneVersion deviceSize] == iPhone4inch){
        label.image = [UIImage imageNamed:@"banner45.png"];
        //nslog(@"smallest");

    }
    else if ([SDiPhoneVersion deviceSize] == iPhone47inch){
        label.image = [UIImage imageNamed:@"banner6.png"];
        //nslog(@"medium");
    }
    else if ([SDiPhoneVersion deviceSize] == iPhone55inch){
        label.image = [UIImage imageNamed:@"banner6plus.png"];
        //nslog(@"large");
    }
    else {
        label.image = [UIImage imageNamed:@"banner45.png"];
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
