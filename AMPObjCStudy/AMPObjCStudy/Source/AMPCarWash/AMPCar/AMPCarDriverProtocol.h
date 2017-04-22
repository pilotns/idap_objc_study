//
//  AMPCarDriverProtocol.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPCar;

@protocol AMPCarDriverProtocol <NSObject>
@property (nonatomic, retain) AMPCar  *car;

- (NSUInteger)payForCarWashWithPrice:(NSUInteger)price;

@end
