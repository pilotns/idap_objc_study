//
//  AMPWasher.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPWasher.h"

#import "AMPCar.h"

@interface AMPWasher ()

- (void)washCar:(AMPCar *)car;

@end

@implementation AMPWasher

#pragma mark -
#pragma mark Public

- (void)handleObject:(id<AMPMoneyFlow>)object {
    NSLog(@"Washer start working...");
    [super handleObject:object];
    NSLog(@"finish working.");
}

- (void)finishProcessingObject:(id<AMPMoneyFlow>)object {
    [self washCar:object];
    self.state = AMPEmployeeDidFinishWork;
}

- (void)finishProcessing {
    self.state = AMPEmployeeDidBecomeFree;
}

#pragma mark -
#pragma mark Private Methods

- (void)washCar:(AMPCar *)car {
    car.clean = YES;
}

@end
