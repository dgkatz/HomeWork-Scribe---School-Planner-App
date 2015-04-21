//
//  Assignment.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/21/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "Assignment.h"

@implementation Assignment
@synthesize description;

- (NSComparisonResult)compare:(Assignment *)otherObject {
    return [self.due_date compare:otherObject.due_date];
}

+(NSArray *)getSortedList:(NSMutableArray *) array
{
    NSArray *sortedArray;
    sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    return(sortedArray);
}

@end
