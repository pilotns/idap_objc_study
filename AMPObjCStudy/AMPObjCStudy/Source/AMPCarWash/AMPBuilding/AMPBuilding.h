//
//  AMPBuilding.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPRoom;

@interface AMPBuilding : NSObject
@property (nonatomic, readonly) NSSet   *rooms;

- (instancetype)initWithRooms:(NSArray *)rooms;
- (AMPRoom *)roomWithClass:(Class)aClass;

@end
