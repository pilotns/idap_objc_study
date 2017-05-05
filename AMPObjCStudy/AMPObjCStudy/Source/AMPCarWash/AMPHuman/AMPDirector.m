//
//  AMPDirector.m
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDirector.h"

@implementation AMPDirector

#pragma mark -
#pragma mark Override Methods

- (void)handlingObject:(AMPHuman<AMPMoneyFlow> *)object {
    [super handlingObject:object];
    NSLog(@"Director take profit - %lu$", self.money);
}

@end
