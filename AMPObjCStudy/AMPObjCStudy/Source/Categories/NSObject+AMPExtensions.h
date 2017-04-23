//
//  NSObject+AMPExtensions.h
//  AMPObjCStudy
//
//  Created by pilotns on 14.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AMPExtensions)

+ (instancetype)object;
+ (NSArray *)objectsWithCount:(NSUInteger)count;

- (id)objectWithClass:(Class)aClass;
- (NSArray *)objectsWithClass:(Class)aClass;

@end
