//
//  AMPCar.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPMoneyFlow.h"

@class AMPCarDriver;

typedef NS_ENUM(NSUInteger, AMPCarState) {
    AMPCarDirty,
    AMPCarClean
};

@interface AMPCar : NSObject <AMPMoneyFlow>
@property (nonatomic, assign)   AMPCarState state;

@end
