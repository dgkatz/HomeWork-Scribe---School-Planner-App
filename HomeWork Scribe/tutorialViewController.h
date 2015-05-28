//
//  tutorialViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/27/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tutorialViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UIImageView *contentImageView;
@property NSUInteger pageIndex;
@property NSString *txtTitle;
@property NSString *imgFile;
@end
