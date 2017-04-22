//
//  AMPCarWashBuilding.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCarWashBuilding.h"

#import "AMPCar.h"
#import "AMPCarWashRoom.h"

@implementation AMPCarWashBuilding

#pragma mark -
#pragma mark - Public Methods

- (AMPCarWashRoom *)freeRoom {
    for (AMPCarWashRoom *carWashRoom in self.rooms) {
        if (AMPCarWashRoomFree == carWashRoom.state) {
            return carWashRoom;
        }
    }
    
    return nil;
}

@end
