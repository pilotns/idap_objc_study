//
//  AMPDirector.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDirector.h"

#import "AMPAccountant.h"

@implementation AMPDirector

#pragma mark -
#pragma mark Override Methods

- (void)handleObject:(AMPHuman<AMPMoneyFlow> *)object {
    [super handleObject:object];
    NSLog(@"Director take profit - %lu$", self.money);
}

- (void)finishProcessingObject:(AMPHuman *)object {
    [super finishProcessingObject:object];
    self.state = AMPEmployeeDidBecomeFree;
}

#pragma mark -
#pragma mark AMPMoneyFlow

- (NSUInteger)giveMoney {
    return 0;
}

@end
