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
    NSMutableArray *creatures = [[[NSMutableArray alloc] initWithCapacity:count] autorelease];
    @autoreleasepool {
        for (NSUInteger iterator = 0; iterator < count; iterator++) {
            Class creatureClass = AMPCreatureRandomClass();
            AMPCreature *creature = [creatureClass object];
            
            for (NSUInteger iterator = 0; iterator < arc4random_uniform(4); iterator++) {
                creatureClass = AMPCreatureRandomClass();
                AMPCreature *child = [creatureClass object];
                [creature addChild:child];
            }
            
            [creatures addObject:creature];
        }
    }
    
    return [[creatures copy] autorelease];
}

Class AMPCreatureRandomClass(void) {
    return arc4random_uniform(2) ? [AMPCreatureMale class] : [AMPCreatureFemale class];
}
