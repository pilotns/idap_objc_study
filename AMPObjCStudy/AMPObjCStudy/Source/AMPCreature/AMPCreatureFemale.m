//
//  AMPCreatureFemale.m
//  AMPObjCStudy
//
//  Created by pilotns on 14.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCreatureFemale.h"

@interface AMPCreatureFemale ()

- (AMPCreature *)giveBirth;

@end

@implementation AMPCreatureFemale

#pragma mark -
#pragma mark - Public Methods

- (void)perfomGenderSpecificOperation {
    [self giveBirth];
}

#pragma mark -
#pragma mark - Prinvate Methods

- (AMPCreature *)giveBirth {
    NSLog(@"Name - %@, class - %@ - go to birth",
          self.name, NSStringFromClass([self class]));
    
    return [[[self class] new] autorelease];
}


@end
