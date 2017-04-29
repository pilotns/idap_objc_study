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

- (void)performWashWithCar:(AMPCar *)car;

@end

@implementation AMPWasher

#pragma mark -
#pragma mark Public

- (void)handlingObject:(id<AMPMoneyFlow>)object {
    [self performWashWithCar:object];
    
    [super handlingObject:object];
}

#pragma mark -
#pragma mark Private Methods

- (void)performWashWithCar:(AMPCar *)car {
    NSLog(@"%@ start working...", [self description]);
    car.clean = YES;
    NSLog(@"finish working.");
}

@end
