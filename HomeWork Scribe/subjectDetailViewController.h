//
//  subjectDetailViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/23/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subjectDetailViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *colorCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;

@end
