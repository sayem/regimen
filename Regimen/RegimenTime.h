//
//  RegimenTime.h
//  Regimen
//
//  Created by Sayem Khan on 12/15/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RegimenGoal;

@interface RegimenTime : NSManagedObject

@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSSet *goals;
@end

@interface RegimenTime (CoreDataGeneratedAccessors)

- (void)addGoalsObject:(RegimenGoal *)value;
- (void)removeGoalsObject:(RegimenGoal *)value;
- (void)addGoals:(NSSet *)values;
- (void)removeGoals:(NSSet *)values;

@end
