//
//  AMPCreatureMale.m
//  AMPObjCStudy
//
//  Created by pilotns on 14.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCreatureMale.h"

@interface AMPCreatureMale ()

- (void)goWar;

@end

@implementation AMPCreatureMale

#pragma mark -
#pragma mark Public Methods

- (void)perfomGenderSpecificOperation {
    [self goWar];
}

#pragma mark -
#pragma mark Private Methods

- (void)goWar {
    NSLog(@"Name - %@, class - %@   - go to war",
          self.name, NSStringFromClass([self class]));
}

@end
