//
//  AMPAccountant.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPAccountant.h"

#import "AMPCarWash.h"

@implementation AMPAccountant

#pragma mark -
#pragma mark Override Methods

- (void)handleObject:(AMPHuman<AMPMoneyFlow> *)object {
    NSLog(@"Accountant start calculating...");
    [super handleObject:object];
    NSLog(@"finish calculating - %lu$", self.money);
}

@end
