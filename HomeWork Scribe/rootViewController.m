//
//  rootViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/27/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "rootViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = nil;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithTitle:@"End Tutorial" style:UIBarButtonItemStylePlain target:self action:@selector(doneCLicked)];
    barButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = barButton;
    _arrPageImages =@[@"iphone52.png",@"iphone53.png",@"iphone54.png",@"iphone55.png"];
    _arrPageTitles =@[@"View all you assignments color coded by subjects",@"Clck the plus button to add an assignment",@"Click and assignment to view its details",@"Find your calendar in the menu"];
    self.PageViewController = (UIPageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.PageViewController.dataSource = self;
    tutorialViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.PageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    // Change the size of page view controller
    self.PageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:self.PageViewController];
    [self.view addSubview:self.PageViewController.view];
    [self.PageViewController didMoveToParentViewController:self];
    // Do any additional setup after loading the view.
}

-(void)doneCLicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((tutorialViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((tutorialViewController*) viewController).pageIndex;
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    if (index == [self.arrPageImages count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (tutorialViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.arrPageImages count] == 0) || (index >= [self.arrPageImages count])) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    tutorialViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imgFile = self.arrPageImages[index];
    pageContentViewController.pageIndex = index;
    pageContentViewController.label.text = self.arrPageTitles[index];
    return pageContentViewController;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.arrPageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
