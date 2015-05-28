//
//  subjectDetailViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/23/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "subjectDetailViewController.h"
#import "dataClass.h"
@interface subjectDetailViewController ()

@end
NSArray *colorArray;
NSArray *menu;
@implementation subjectDetailViewController

-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    menu = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    colorArray = [[NSArray alloc]initWithObjects:[UIColor colorWithRed:224/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f],[UIColor colorWithRed:109/255.0 green:158/255.0 blue:235/255.0 alpha:1.0f],[UIColor colorWithRed:106/255.0 green:168/255.0 blue:79/255.0 alpha:1.0f],[UIColor colorWithRed:255/255.0 green:217/255.0 blue:102/255.0 alpha:1.0f],[UIColor colorWithRed:246/255.0 green:178/255.0 blue:107/255.0 alpha:1.0f],[UIColor colorWithRed:204/255.0 green:65/255.0 blue:37/255.0 alpha:1.0] ,[UIColor colorWithRed:118/255.0 green:165/255.0 blue:175/255.0 alpha:1.0f],[UIColor colorWithRed:142/255.0 green:124/255.0 blue:195/255.0 alpha:1.0f],[UIColor colorWithRed:194/255.0 green:123/255.0 blue:160/255.0 alpha:1.0f],nil];
    dataClass *obj = [dataClass getInstance];
    self.subjectLabel.text = obj.subject;
    self.view.backgroundColor = obj.defaultColor;
    // Do any additional setup after loading the view.
}

-(void)colorClicked: (id)sender{
    //nslog(@"Color clicked");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        NSString *identifier = [menu objectAtIndex:indexPath.row];
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
        return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.colorCollectionView cellForItemAtIndexPath:indexPath];
    self.view.backgroundColor = cell.backgroundColor;
    NSMutableArray *savedColorArray = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"usersColors"]];
    NSMutableArray *savedSubjectArray = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"usersSubjects"]];
    int subjectIndex = (int)[savedSubjectArray indexOfObject:self.subjectLabel.text];
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:cell.backgroundColor];
    [savedColorArray replaceObjectAtIndex:subjectIndex withObject:colorData];
    [[NSUserDefaults standardUserDefaults]setObject:savedColorArray forKey:@"usersColors"];
    [[NSUserDefaults standardUserDefaults]synchronize];
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
