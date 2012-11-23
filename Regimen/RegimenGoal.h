//
//  RegimenGoal.h
//  Regimen
//
//  Created by Sayem Islam on 11/8/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegimenGoal : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic) BOOL completed;

-(id)initWithText:(NSString*)text;

+(id)goalWithText:(NSString*)text;

@end
