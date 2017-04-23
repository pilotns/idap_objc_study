//
//  AMPCarWash.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPMoneyFlow.h"

@class AMPCar;
@class AMPHuman;

@interface AMPCarWash : NSObject
@property (nonatomic, readonly) NSArray *buildings;

- (void)addCarInQueue:(AMPCar *)car;
- (void)removeCarFromQueue:(AMPCar *)car;

- (void)performWork;

@end
