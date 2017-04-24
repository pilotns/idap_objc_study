//
//  AMPRoom.h
//  AMPObjCStudy
//
//  Created by pilotns on 20.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPHuman;

@interface AMPRoom : NSObject
@property (nonatomic, readonly) NSSet   *staff;

- (void)addEmployee:(AMPHuman *)employee;
- (void)removeEmployee:(AMPHuman *)employee;

@end
