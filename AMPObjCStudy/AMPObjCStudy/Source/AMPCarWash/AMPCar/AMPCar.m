//
//  AMPCar.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCar.h"

#import "AMPRandom.h"

@interface AMPCar ()
@property (nonatomic, assign)   NSUInteger  money;

@end

@implementation AMPCar

#pragma mark -
#pragma mark Initializationa and Deallocations

- (instancetype)init {
    self = [super init];
    [self receiveMoney:AMPRandomValueWithRange(NSMakeRange(300, 200))];
    
    return self;
}

#pragma mark -
#pragma mark AMPMoneyFlow

- (NSUInteger)giveMoney {
    NSUInteger money = self.money;
    self.money = 0;
    
    return money;
}

- (void)receiveMoney:(NSUInteger)money {
    self.money += money;
}

@end
