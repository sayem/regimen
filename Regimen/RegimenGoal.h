//
//  RegimenGoal.h
//  Regimen
//
//  Created by Sayem Khan on 12/15/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RegimenGoal : NSManagedObject

@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSManagedObject *time;

@end
