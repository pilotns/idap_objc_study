//
//  AMPCarWashRoom.m
//  AMPObjCStudy
//
//  Created by pilotns on 20.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCarWashRoom.h"

#import "AMPWasher.h"

@interface AMPCarWashRoom ()
@property (nonatomic, retain)   AMPCar *car;

@end

@implementation AMPCarWashRoom

#pragma mark -
#pragma mark - Initializations and Deallocations

- (void)dealloc {
    self.car = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark - Public Methods

- (void)addCar:(AMPCar *)car {
    self.car = car;
    AMPWasher *washer = (AMPWasher *)[self employeeWithClass:[AMPWasher class]];
    [washer performWashWithCar:car];
    [self removeCar:car];
}

- (void)removeCar:(AMPCar *)car {
    self.car = nil;
}

@end
