//
//  AMPRoom.m
//  AMPObjCStudy
//
//  Created by pilotns on 20.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPRoom.h"

#import "AMPHuman.h"

#import "NSObject+AMPExtensions.h"

@interface AMPRoom ()
@property (nonatomic, retain) NSMutableSet   *mutableStaff;

@end

@implementation AMPRoom

@dynamic staff;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableStaff = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableStaff = [NSMutableSet set];
    }
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)staff {
    return [[self.mutableStaff copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)addEmployee:(AMPHuman *)employee {
    [self.mutableStaff addObject:employee];
}

- (void)removeEmployee:(AMPHuman *)employee {
    [self.mutableStaff removeObject:employee];
}

@end
