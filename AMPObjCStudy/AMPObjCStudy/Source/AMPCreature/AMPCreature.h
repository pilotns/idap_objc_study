//
//  AMPCreature.h
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPCreature : NSObject
@property (nonatomic, copy)     NSString            *name;
@property (nonatomic, assign)   double              weight;
@property (nonatomic, assign)   NSUInteger          age;

@property (nonatomic, readonly)     NSArray     *children;

- (void)addChild:(AMPCreature *)child;
- (void)removeChild:(AMPCreature *)child;

- (void)addChildren:(NSArray *)children;
- (void)removeChildren:(NSArray *)children;

- (NSUInteger)childrenCount;

- (void)perfomGenderSpecificOperation;
- (void)sayHello;

@end
