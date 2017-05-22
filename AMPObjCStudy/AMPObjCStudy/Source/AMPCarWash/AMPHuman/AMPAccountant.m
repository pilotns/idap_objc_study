//
//  AMPAccountant.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPAccountant.h"

#import "AMPCarWash.h"
#import "AMPDirector.h"
#import "AMPQueue.h"

@implementation AMPAccountant

#pragma mark -
#pragma mark Override Methods

- (void)handleObject:(AMPWorker<AMPMoneyFlow> *)object {
    NSLog(@"Accountant start calculating... - %@", self.name);
    [super handleObject:object];
    NSLog(@"finish calculating - %lu$", self.money);
}

@end
