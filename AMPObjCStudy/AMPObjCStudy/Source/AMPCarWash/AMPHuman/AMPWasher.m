//
//  AMPWasher.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPWasher.h"

#import "AMPCar.h"

@implementation AMPWasher

#pragma mark -
#pragma mark Public

- (void)handleObject:(id<AMPMoneyFlow>)object {
    NSLog(@"Washer start working...");
    [super handleObject:object];
    NSLog(@"finish working.");
}
- (void)finishProcessingObject:(AMPCar *)object {
    object.state = AMPCarClean;
}

@end
