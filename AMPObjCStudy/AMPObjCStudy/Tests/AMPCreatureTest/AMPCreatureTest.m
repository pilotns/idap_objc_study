//
//  AMPCreatureTest.m
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCreatureTest.h"

#import "AMPCreatureMale.h"
#import "AMPCreatureFemale.h"

#import "NSString+AMPRandom.h"
#import "NSObject+AMPExtension.h"
#import "NSArray+AMPExtension.h"

static const NSUInteger AMPMaximumChildrenCount = 10;

NSArray *AMPCreaturesWithCount(NSUInteger count);
Class AMPCreatureRandomClass(void);

void AMPCreatureWarOrBirthTest(void) {
    NSArray *creatures = AMPCreaturesWithCount(10);
    for (AMPCreature *creature in creatures) {
        [creature perfomGenderSpecificOperation];
    }
}

void AMPCreatureSayHelloTest(void) {
    NSArray *creatures = AMPCreaturesWithCount(10);
    for (AMPCreature *creature in creatures) {
        [creature sayHello];
    }
}

NSArray *AMPCreaturesWithCount(NSUInteger count) {
    return [NSArray arrayWithObjectsCount:count factoryBlock:^id{
        @autoreleasepool {
            Class currentClass = AMPCreatureRandomClass();
            AMPCreature *creature = [currentClass object];
            [creature addChildren:[AMPCreature objectsWithCount:arc4random_uniform(AMPMaximumChildrenCount)]];
            
            return [creature retain];
        }
    }];
}

Class AMPCreatureRandomClass(void) {
    return arc4random_uniform(2) ? [AMPCreatureMale class] : [AMPCreatureFemale class];
}
