//
//  AMPCarWashWasherProtocol.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPMoneyFlow.h"

@class AMPCar;

@protocol AMPCarWashWasher <NSObject>

- (void)performWashWithCar:(AMPCar<AMPMoneyFlow> *)car;

@end
