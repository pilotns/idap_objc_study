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
@property (nonatomic, assign) NSUInteger processedCarCount;

@end

@implementation AMPWasher

#pragma mark -
#pragma mark Public

- (void)handleObject:(id<AMPMoneyFlow>)object {
    self.processedCarCount += 1;
    NSLog(@"Washer start working... %@ = %lu", self.name, self.processedCarCount);
    [super handleObject:object];
    NSLog(@"finish working.");
}
- (void)finishProcessingObject:(AMPCar *)object {
    object.state = AMPCarClean;
}

@end
