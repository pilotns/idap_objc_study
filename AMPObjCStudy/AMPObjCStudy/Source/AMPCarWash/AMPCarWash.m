//
//  AMPCarWash.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCarWash.h"

#import "AMPCarWashController.h"
#import "AMPCar.h"

#import "NSObject+AMPExtensions.h"

@interface AMPCarWash ()
@property (nonatomic, retain)   AMPCarWashController    *controller;

@end

@implementation AMPCarWash;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.controller = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.controller = [AMPCarWashController object];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)washCarsWithCount:(NSUInteger)count {
    AMPCarWashController *controller = self.controller;
    for (NSUInteger iterator = 0; iterator < count; iterator++) {
        [controller washCar:[AMPCar object]];
    }
}

@end
