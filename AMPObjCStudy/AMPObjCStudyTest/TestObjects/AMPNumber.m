//
//  AMPNumber.m
//  AMPObjCStudy
//
//  Created by pilotns on 28.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPNumber.h"

@implementation AMPNumber

- (void)dealloc {
    self.number = nil;
    
    [super dealloc];
}

- (void)setNumber:(NSNumber *)number {
    if (_number != number) {
        self.state = AMPNumberWillChangeState;
        
        id oldNumber = _number ? _number : [NSNull null];
        id newNumber = number ? number : [NSNull null];
        NSDictionary *userInfo = @{@"oldNumber" : oldNumber, @"newNumber" : newNumber};
        
        [_number release];
        _number = [number retain];
        [self setState:AMPNumberDidChangeState userInfo:userInfo];
    }
}

@end
