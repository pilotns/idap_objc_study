//
//  AMPCarWash.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCarWash.h"

#import "AMPBuilding.h"
#import "AMPCarWashBuilding.h"
#import "AMPCarWashAdministration.h"
#import "AMPCarWashRoom.h"
#import "AMPAccountant.h"
#import "AMPDirector.h"
#import "AMPWasher.h"

#import "NSObject+AMPExtensions.h"

@interface AMPCarWash ()
@property (nonatomic, retain) NSMutableArray *mutableBuildings;
@property (nonatomic, retain) NSMutableArray *mutableCarQueue;

- (void)prepareHierarchy;
- (AMPHuman<AMPMoneyFlow> *)employeeWithClass:(Class)employeeClass
                          inBuildingWithClass:(Class)buildingClass;

- (id)buildingWithClass:(Class)aClass;
- (AMPCar *)nextCar;

@end

@implementation AMPCarWash

@dynamic buildings;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableBuildings = nil;
    self.mutableCarQueue = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableBuildings = [NSMutableArray array];
    self.mutableCarQueue = [NSMutableArray array];
    [self prepareHierarchy];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)buildings {
    return [[self.mutableBuildings copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)addCarInQueue:(AMPCar *)car {
    if (car) {
        [self.mutableCarQueue addObject:car];
        [self performWork];
    }
}

- (void)removeCarFromQueue:(AMPCar *)car {
    [self.mutableCarQueue removeObject:car];
}

- (void)performWork {
    NSMutableArray *carQueue = self.mutableCarQueue;
    while (carQueue.count) {
        id car = [self nextCar];
        id washer = [self employeeWithClass:[AMPWasher class]
                        inBuildingWithClass:[AMPCarWashBuilding class]];
        [washer performWashWithCar:car];
        id accountant = [self employeeWithClass:[AMPAccountant class]
                                        inBuildingWithClass:[AMPCarWashAdministration class]];
        
        [washer giveMoneyToEmployee:accountant];
        
        id director = [self employeeWithClass:[AMPDirector class]
                          inBuildingWithClass:[AMPCarWashAdministration class]];
        
        [accountant giveMoneyToEmployee:director];
        
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)prepareHierarchy {
    AMPDirector *director = [AMPDirector object];
    AMPAccountant *accountant = [AMPAccountant object];
    
    AMPRoom *administationRoom = [AMPRoom object];
    [administationRoom addEmployee:director];
    [administationRoom addEmployee:accountant];
    AMPCarWashAdministration *administrationBuilding =
                                [[AMPCarWashAdministration alloc] initWithRooms:@[administationRoom]];
    
    [self.mutableBuildings addObject:administrationBuilding];
    
    AMPWasher *washer = [AMPWasher object];
    
    AMPCarWashRoom *carWashRoom = [AMPCarWashRoom object];
    [carWashRoom addEmployee:washer];
    AMPCarWashBuilding *carWashBuilding = [[AMPCarWashBuilding alloc] initWithRooms:@[carWashRoom]];

    [self.mutableBuildings addObject:carWashBuilding];
}

- (id<AMPMoneyFlow>)employeeWithClass:(Class)employeeClass
                          inBuildingWithClass:(Class)buildingClass
{
    AMPBuilding *building = [self buildingWithClass:buildingClass];
    
    return [building employeeWithClass:employeeClass];
}

- (id)buildingWithClass:(Class)aClas {
    return [self.mutableBuildings objectWithClass:aClas];
}

- (AMPCar *)nextCar {
    NSMutableArray *carsQueue = self.mutableCarQueue;
    AMPCar *car = [carsQueue objectAtIndex:0];
    [self removeCarFromQueue:car];
    
    return car;
}

@end
