//
//  AMPCarDriver.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCarDriver.h"

static const NSUInteger kAMPDefaultMoneyAmount = 300;

@implementation AMPCarDriver

@synthesize car = _car;

#pragma mark -
#pragma mark - Initialization and Deallocation

- (void)dealloc {
    self.car = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.money = kAMPDefaultMoneyAmount;
    }
    return self;
}

#pragma mark -
#pragma mark - AMPCarDriverProtocol

- (NSUInteger)payForCarWashWithPrice:(NSUInteger)price {
    if (self.money >= price) {
        self.money -= price;
        
        return price;
    }
    
    return 0;
}

@end
