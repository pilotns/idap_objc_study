//
//  AMPHuman.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPHuman.h"

#import "NSString+AMPRandom.h"

@interface AMPHuman ()
@property (nonatomic, copy)     NSString    *name;

@end

@implementation AMPHuman

@synthesize carWash = _carWash;

#pragma mark -
#pragma mark - Initializations and Deallocations

- (void)dealloc {
    self.name = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.name = [NSString randomString];
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods

- (void)takeSalary:(NSUInteger)salary {
    self.money += salary;
}

@end
