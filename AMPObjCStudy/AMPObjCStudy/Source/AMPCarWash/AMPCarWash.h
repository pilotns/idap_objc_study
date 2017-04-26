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

@interface AMPCarWash : NSObject

- (void)addCarInQueue:(AMPCar *)car;
- (void)removeCarFromQueue:(AMPCar *)car;

- (void)hireEmployee:(AMPHuman<AMPMoneyFlow> *)employee;
- (void)dismissEmployee:(AMPHuman<AMPMoneyFlow> *)employee;

- (void)performWork;

@end
