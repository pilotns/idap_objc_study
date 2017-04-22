//
//  AMPCar.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPCarDriver;

@interface AMPCar : NSObject
@property (nonatomic, readonly)                 AMPCarDriver    *driver;
@property (nonatomic, assign, getter=isClean)   BOOL            clean;

- (instancetype)initWithDriver:(AMPCarDriver *)driver;

@end
