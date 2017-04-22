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
#pragma mark - AMPCarWashMoneyFlowProtocol

- (void)takeMoney:(NSUInteger)money fromEmployee:(AMPHuman *)employee {
    self.money += money;
}

@end
