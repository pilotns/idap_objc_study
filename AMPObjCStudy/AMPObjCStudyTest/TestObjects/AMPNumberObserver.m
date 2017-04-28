//
//  AMPNumberObserver.m
//  AMPObjCStudy
//
//  Created by pilotns on 28.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPNumberObserver.h"

#import "AMPNumber.h"

@implementation AMPNumberObserver

- (void)dealloc {
    self.number = nil;
    
    [super dealloc];
}

- (void)setNumber:(AMPNumber *)number {
    if (_number != number) {
        [_number removeObserver:self];
        [_number release];
        
        _number = [number retain];
        
        [_number addObserver:self
                    forState:AMPNumberWillChangeState
                 withHandler:^(AMPNumberObserver *observer, AMPNumber *observableObject, id userInfo) {
                     [observer numberWillChangeWithUserInfo:userInfo];
                 }];
        
        [_number addObserver:self
                    forState:AMPNumberDidChangeState
                 withHandler:^(id observer, id observableObject, id userInfo) {
                     [observer numberDidChangeWithUserInfo:userInfo];
                 }];
    }
}

- (void)numberWillChangeWithUserInfo:(id)userInfo {
    
}

- (void)numberDidChangeWithUserInfo:(id)userInfo {
    
}

@end
