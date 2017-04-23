//
//  NSArray+AMPExtensions.h
//  AMPObjCStudy
//
//  Created by pilotns on 15.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^AMPFactoryBlock)(void);

@interface NSArray (AMPExtensions)

+ (instancetype)arrayWithObjectsCount:(NSUInteger)count factoryBlock:(AMPFactoryBlock)block;

@end
