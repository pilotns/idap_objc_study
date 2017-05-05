//
//  AMPCarWashController.h
//  AMPObjCStudy
//
//  Created by pilotns on 04.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPCar;
@class AMPQueue;

@interface AMPCarWashController : NSObject
@property (nonatomic, retain)   AMPQueue        *carQueue;

- (void)washCar:(AMPCar *)car;
- (void)performWork;

@end
