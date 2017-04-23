//
//  AMPBuilding.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPBuilding.h"

#import "AMPRoom.h"

#import "NSObject+AMPExtensions.h"

@interface AMPBuilding ()
@property (nonatomic, retain)   NSMutableSet    *mutableRooms;

@end

@implementation AMPBuilding

@dynamic rooms;

#pragma mark -
#pragma mark Initializationa and Deallocations

- (void)dealloc {
    self.mutableRooms = nil;
    
    [super dealloc];
}

- (instancetype)initWithRooms:(NSArray *)rooms {
    self = [super init];
    self.mutableRooms = [NSMutableSet setWithArray:rooms];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (AMPRoom *)roomWithClass:(Class)aClass {
    return [self.mutableRooms objectWithClass:aClass];
}

- (id<AMPMoneyFlow>)employeeWithClass:(Class)aClass {
    return [[self employeesWithClass:aClass] firstObject];
}

- (NSArray *)employeesWithClass:(Class)aClass {
    NSMutableArray *employees = [NSMutableArray array];
    for (AMPRoom *room in self.mutableRooms) {
        [employees addObjectsFromArray:[room employeesWithClass:aClass]];
    }
    
    return employees.count ? [[employees copy] autorelease] : nil;
}

@end
