//
//  Assignment.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/21/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Assignment : NSObject
    @property(retain) NSString *description;
    @property NSNumber *due_date;
    @property NSString *subject;
    @property UIImage *img;

+(NSArray *)getSortedList:(NSArray *) array;

@end
