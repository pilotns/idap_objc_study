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

- (void)performWorkWithObject:(id<AMPMoneyFlow>)object {
    self.state = AMPEmployeeDidBecomeBusy;
    [self performWashWithCar:object];
    self.state = AMPEmployeeDidFinishWork;
}

#pragma mark -
#pragma mark AMPCarWashWasher

- (void)performWashWithCar:(AMPCar<AMPMoneyFlow> *)car {
    if (car.money && [car respondsToSelector:@selector(giveMoneyToEmployee:)]) {
        car.clean = YES;
        [car giveMoneyToEmployee:self];
    }
}

@end
