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

@interface AMPCar : NSObject <AMPMoneyFlow>
@property (nonatomic, assign, getter=isClean)   BOOL    clean;

@end
