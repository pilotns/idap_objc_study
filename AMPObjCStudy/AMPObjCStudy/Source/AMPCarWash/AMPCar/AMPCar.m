//
//  AMPCar.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCar.h"

#import "AMPCarDriverProtocol.h"

@interface AMPCar ()
@property (nonatomic, assign)   AMPCarDriver    *driver;

@end

@implementation AMPCar

#pragma mark -
#pragma mark - Initializationa and Deallocations

- (void)dealloc {
    self.driver = nil;
    
    [super dealloc];
}

- (instancetype)initWithDriver:(AMPCarDriver *)driver {
    self = [super init];
    self.driver = driver;
    self.clean = NO;
    
    return self;
}

#pragma mark -
#pragma mark - Accessors

- (void)setDriver:(AMPCarDriver *)driver {
    if (_driver != driver) {
        [_driver setCar:nil];
        
        [driver setCar:self];
        _driver = driver;
    }
}

@end
