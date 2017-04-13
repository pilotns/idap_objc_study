//
//  AMPCreature.m
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPCreature.h"

#import "NSString+AMPRandom.h"

@interface AMPCreature ()
@property (nonatomic, retain) NSMutableArray *mutableChilds;

@end

@implementation AMPCreature

@dynamic childs;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableChilds = nil;
    self.name = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = [NSString randomStringWithLength:6];
        self.gender = arc4random_uniform(2);
        self.mutableChilds = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark - Accessors

- (NSArray *)childs {
    return [[self.mutableChilds copy] autorelease];
}

#pragma mark -
#pragma mark - Public Methods

- (void)addChild:(AMPCreature *)child {
    [self.mutableChilds addObject:child];
}

- (void)removeChild:(AMPCreature *)child {
    [self.mutableChilds removeObject:child];
}

- (NSUInteger)childsCount {
    return [self.mutableChilds count];
}

- (void)goWar {
    NSLog(@"Name - %@, gender - %@   - go to war",
          self.name, self.gender ? @"Female" : @"Male");
}

- (AMPCreature *)giveBirth {
    NSLog(@"Name - %@, gender - %@ - go to birth",
          self.name, self.gender ? @"Female" : @"Male");
    
    return [[[self class] new] autorelease];
}

- (void)sayHello {
    NSLog(@"%@ says Hello", self.name);
    if ([self childsCount] > 0) {
        NSLog(@"---Childs of %@---", self.name);
        
        NSArray *childs = [self childs];
        for (AMPCreature *child in childs) {
            [child sayHello];
        }
        
        NSLog(@"---end childs.----");
        NSLog(@"");
    }
}

@end
