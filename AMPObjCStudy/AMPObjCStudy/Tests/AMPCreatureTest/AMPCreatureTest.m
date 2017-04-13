//
//  AMPCreatureTest.m
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCreatureTest.h"

#import "AMPCreature.h"

#import "NSString+AMPRandom.h"

NSArray *AMPCreaturesWithCount(NSUInteger count);

void AMPCreatureWarOrBirthTest(void) {
    NSArray *creatures = AMPCreaturesWithCount(10);
    for (AMPCreature *creature in creatures) {
        if (AMPCreatureGenderMale == creature.gender) {
            [creature goWar];
        } else {
            [creature giveBirth];
        }
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

    for (NSUInteger iterator = 0; iterator < count; iterator++) {
        AMPCreature *creature = [[[AMPCreature alloc] init] autorelease];
        
        for (NSUInteger iterator = 0; iterator < arc4random_uniform(4); iterator++) {
            AMPCreature *child = [[[AMPCreature alloc] init] autorelease];
            
            [creature addChild:child];
        }
        
        [creatures addObject:creature];
    }
    
    return [[creatures copy] autorelease];
}
