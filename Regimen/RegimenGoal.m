//
//  RegimenGoal.m
//  Regimen
//
//  Created by Sayem Islam on 11/8/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenGoal.h"

@implementation RegimenGoal
- (id)initWithText:(NSString*) text
{
    self = [super init];
    if (self) {
        self.text = text;
    }
    return self;
}

+ (id)goalWithText:(NSString *)text
{
    return [[RegimenGoal alloc] initWithText:text];
}

@end
