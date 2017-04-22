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

#import "NSObject+AMPExtension.h"

@interface AMPCarWash ()
@property (nonatomic, retain) NSMutableArray *mutableBuildings;
@property (nonatomic, retain) NSMutableArray *mutableCarQueue;

- (void)prepareHierarchy;
- (AMPBuilding *)buildingWithClass:(Class)aClass;

- (AMPCar *)nextCar;

@end

@implementation AMPCarWash

@dynamic buildings;

#pragma mark -
#pragma mark - Initializations and Deallocations

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
#pragma mark - Accessors

- (NSArray *)buildings {
    return [[self.mutableBuildings copy] autorelease];
}

#pragma mark -
#pragma mark - Public Methods

- (void)addCarInQueue:(AMPCar *)car {
    if (car) {
        [self.mutableCarQueue addObject:car];
        [self performWork];
    }
}

- (void)removeCarFromQueue:(AMPCar *)car {
    [self.mutableCarQueue removeObject:car];
}

- (AMPHuman *)accountant {
    return [[[self buildingWithClass:[AMPCarWashAdministration class]]
                                        roomWithClass:[AMPRoom class]]
                                    employeeWithClass:[AMPAccountant class]];
}

- (AMPHuman *)director {
    return [[[self buildingWithClass:[AMPCarWashAdministration class]]
                                      roomWithClass:[AMPRoom class]]
                                  employeeWithClass:[AMPDirector class]];
}

- (void)performWork {
    NSMutableArray *carQueue = self.mutableCarQueue;
    while (0 != [carQueue count]) {
        AMPCar *car = [self nextCar];
        AMPCarWashBuilding *carWashbuilding = (AMPCarWashBuilding *)[self buildingWithClass:[AMPCarWashBuilding class]];
        AMPCarWashRoom *carWashRoom = [carWashbuilding freeRoom];
        [carWashRoom addCar:car];
    }
}

#pragma mark -
#pragma mark - Private Methods

- (void)prepareHierarchy {
    AMPDirector *director = [AMPDirector object];
    director.carWash = self;
    
    AMPAccountant *accountant = [AMPAccountant object];
    accountant.carWash = self;
    
    AMPRoom *administationRoom = [AMPRoom object];
    [administationRoom addEmployee:director];
    [administationRoom addEmployee:accountant];
    AMPCarWashAdministration *administrationBuilding =
                                [[AMPCarWashAdministration alloc] initWithRooms:@[administationRoom]];
    
    [self.mutableBuildings addObject:administrationBuilding];
    
    AMPWasher *washer = [AMPWasher object];
    washer.carWash = self;
    washer.washingCost = arc4random_uniform(25);
    
    AMPCarWashRoom *carWashRoom = [AMPCarWashRoom object];
    [carWashRoom addEmployee:washer];
    AMPCarWashBuilding *carWashBuilding = [[AMPCarWashBuilding alloc] initWithRooms:@[carWashRoom]];

    [self.mutableBuildings addObject:carWashBuilding];
}

- (AMPBuilding *)buildingWithClass:(Class)aClas {
    for (AMPBuilding *building in self.mutableBuildings) {
        if ([building isMemberOfClass:aClas]) {
            return building;
        }
    }
    
    return nil;
}

- (AMPCar *)nextCar {
    NSMutableArray *carsQueue = self.mutableCarQueue;
    AMPCar *car = [carsQueue objectAtIndex:0];
    [self removeCarFromQueue:car];
    
    return car;
}

@end
