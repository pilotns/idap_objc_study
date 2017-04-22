//
//  AMPRoom.h
//  AMPObjCStudy
//
//  Created by pilotns on 20.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPCarWashEmplyeeProtocol.h"

@class AMPHuman;

@interface AMPRoom : NSObject
@property (nonatomic, readonly) NSSet   *staff;

- (void)addEmployee:(AMPHuman<AMPCarWashEmplyeeProtocol> *)employee;
- (void)removeEmployee:(AMPHuman<AMPCarWashEmplyeeProtocol> *)employee;

- (AMPHuman *)employeeWithClass:(Class)aClass;

@end
