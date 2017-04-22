//
//  AMPCarWashMoneyFlowProtocol.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPHuman;

@protocol AMPCarWashMoneyFlowProtocol <NSObject>

- (void)takeMoney:(NSUInteger)money fromEmployee:(AMPHuman *)employee;

@end
