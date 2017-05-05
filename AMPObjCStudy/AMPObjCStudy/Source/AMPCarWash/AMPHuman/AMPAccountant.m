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

@implementation AMPAccountant

#pragma mark -
#pragma mark Override Methods

- (void)handlingObject:(AMPHuman<AMPMoneyFlow> *)object {
    NSLog(@"Accountant start calculating...");
    [super handlingObject:object];
    NSLog(@"finish calculating - %lu$", self.money);
    object.state = AMPEmployeeDidBecomeFree;
}

@end
