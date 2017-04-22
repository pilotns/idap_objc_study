//
//  AMPCarWashWasherProtocol.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPCar;
@class AMPAccountant;

@protocol AMPCarWashWasherProtocol <NSObject>
@property (nonatomic, assign) NSUInteger washingCost;

- (void)performWashWithCar:(AMPCar *)car;

@end
