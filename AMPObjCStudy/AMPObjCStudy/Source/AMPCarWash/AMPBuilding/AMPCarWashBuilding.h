//
//  AMPCarWashBuilding.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPBuilding.h"

@class AMPCar;
@class AMPCarWashRoom;

@interface AMPCarWashBuilding : AMPBuilding

- (AMPCarWashRoom *)freeRoom;

@end
