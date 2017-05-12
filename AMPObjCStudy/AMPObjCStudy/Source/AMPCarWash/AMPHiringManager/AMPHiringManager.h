//
//  AMPHiringManager.h
//  AMPObjCStudy
//
//  Created by pilotns on 07.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPHiringManager;
@class AMPHuman;

@protocol AMPHiringManagerDelegate <NSObject>

- (NSArray *)hiringManager:(AMPHiringManager *)manager observersForEmployee:(AMPHuman *)employee;

@end

@interface AMPHiringManager : NSObject
@property (nonatomic, assign) id<AMPHiringManagerDelegate> delegate;

- (void)hireEmployees:(NSArray *)employees;

- (id)employeeWithClass:(Class)class;
- (NSSet *)employeesWithClass:(Class)class;

@end
