//
//  AMPCarWashTest.m
//  AMPObjCStudy
//
//  Created by pilotns on 20.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCarWashTest.h"

#import "AMPCarWash.h"
#import "AMPCar.h"

#import "NSObject+AMPExtensions.h"

static const NSUInteger AMPDefaultCarCount = 50;

void AMPCarWashTest() {
    AMPCarWash *carWash = [AMPCarWash object];
    
    [carWash washCarsWithCount:AMPDefaultCarCount];
}
