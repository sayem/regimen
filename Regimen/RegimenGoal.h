//
//  RegimenGoal.h
//  Regimen
//
//  Created by Sayem Khan on 12/15/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RegimenTime.h"


@class RegimenTime;

@interface RegimenGoal : RegimenTime

@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) RegimenTime *time;

@end

/*
#import <Foundation/Foundation.h>

@interface RegimenGoal : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic) BOOL completed;

-(id)initWithText:(NSString*)text;

+(id)goalWithText:(NSString*)text;

@end
*/