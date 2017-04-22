//
//  AMPHuman.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPCarWashEmplyeeProtocol.h"

@class AMPCar;

@interface AMPHuman : NSObject <AMPCarWashEmplyeeProtocol>
@property (nonatomic, readonly) NSString    *name;
@property (nonatomic, assign)   NSUInteger  money;

- (void)takeSalary:(NSUInteger)salary;

@end
