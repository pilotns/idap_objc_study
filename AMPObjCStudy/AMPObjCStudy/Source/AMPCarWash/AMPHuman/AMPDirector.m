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

- (void)handleObject:(AMPWorker<AMPMoneyFlow> *)object {
    [super handleObject:object];
    NSLog(@"Director take profit - %lu$", self.money);
}

#pragma mark -
#pragma mark AMPMoneyFlow

- (NSUInteger)giveMoney {
    return 0;
}

- (void)finishProcessing {
    self.state = AMPEmployeeDidBecomeFree;
}

@end
