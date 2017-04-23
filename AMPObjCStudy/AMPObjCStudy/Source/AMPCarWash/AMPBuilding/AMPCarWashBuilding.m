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
#pragma mark Public Methods

- (AMPCarWashRoom *)freeRoom {
    NSSet *rooms = [self.rooms objectsPassingTest:^BOOL(AMPCarWashRoom *room, BOOL *stop) {
        if (AMPCarWashRoomFree == room.state) {
            *stop = true;
            return YES;
        }
        
        return NO;
    }];
    
    return [rooms anyObject];
}

@end
