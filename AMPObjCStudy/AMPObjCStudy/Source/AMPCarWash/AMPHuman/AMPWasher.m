//
//  AMPWasher.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPWasher.h"

#import "AMPCar.h"
#import "AMPCarDriver.h"
#import "AMPAccountant.h"
#import "AMPCarWash.h"

@implementation AMPWasher

@synthesize washingCost = _washingCost;

#pragma mark -
#pragma mark - AMPCarWashWasherProtocol

- (void)performWashWithCar:(AMPCar *)car {
    NSLog(@"Washing begin...");
    car.clean = YES;
    
    NSUInteger cash = [car.driver payForCarWashWithPrice:self.washingCost];
    [self.carWash.accountant takeMoney:cash fromEmployee:self];
    
    NSLog(@"Washing end.");
}

@end
