//
//  AMPCreature.h
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    AMPCreatureGenderMale,
    AMPCreatureGenderFemale
    
} AMPCreatureGender;

@interface AMPCreature : NSObject
@property (nonatomic, copy)     NSString            *name;
@property (nonatomic, assign)   double              weigth;
@property (nonatomic, assign)   NSUInteger          age;
@property (nonatomic, assign)   AMPCreatureGender   gender;

@property (nonatomic, readonly)     NSArray     *childs;

- (void)addChild:(AMPCreature *)child;
- (void)removeChild:(AMPCreature *)child;
- (NSUInteger)childsCount;

- (void)goWar;
- (AMPCreature *)giveBirth;
- (void)sayHello;

@end
