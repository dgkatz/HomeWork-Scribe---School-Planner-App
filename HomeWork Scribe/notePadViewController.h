//
//  notePadViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/24/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface notePadViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textField;

@end
