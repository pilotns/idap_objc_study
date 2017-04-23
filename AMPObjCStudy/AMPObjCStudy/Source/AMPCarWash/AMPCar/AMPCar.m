//
//  AMPCar.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCar.h"

#import "AMPExtern.h"

@interface AMPCar ()
@property (nonatomic, assign)   NSUInteger  money;

@end

@implementation AMPCar

#pragma mark -
#pragma mark Initializationa and Deallocations

- (instancetype)init {
    self = [super init];
    self.money = AMPRandomValueWithRange(NSMakeRange(300, 200));
    
    return self;
}

#pragma mark -
#pragma mark AMPMoneyFlow

- (void)giveMoneyToEmployee:(id<AMPMoneyFlow>)employee {
    if ([employee respondsToSelector:@selector(takeMoneyFromSender:)]) {
        [employee takeMoneyFromSender:self];
        self.money = 0;
    }
}

@end
