//
//  AMPCarWashRoom.h
//  AMPObjCStudy
//
//  Created by pilotns on 20.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPRoom.h"

typedef NS_ENUM(NSUInteger, AMPCarWashRoomState) {
    AMPCarWashRoomFree,
    AMPCarWashRoomBusy
};

@class AMPCar;

@interface AMPCarWashRoom : AMPRoom
@property (nonatomic, readonly) AMPCar              *car;
@property (nonatomic, readonly) AMPCarWashRoomState state;

- (void)addCar:(AMPCar *)car;
- (void)removeCar:(AMPCar *)car;

@end
