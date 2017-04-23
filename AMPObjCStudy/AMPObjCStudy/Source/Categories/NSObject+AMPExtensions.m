//
//  NSObject+AMPExtensions.m
//  AMPObjCStudy
//
//  Created by pilotns on 14.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSObject+AMPExtensions.h"

#import "NSArray+AMPExtensions.h"

@implementation NSObject (AMPExtensions)

+ (instancetype)object {
    return [[[self alloc] init] autorelease];
}

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    return [NSArray arrayWithObjectsCount:count factoryBlock:^id{
        return [self object];
    }];
}

- (id)objectWithClass:(Class)aClass {
    return [[self objectsWithClass:aClass] firstObject];
}

- (NSArray *)objectsWithClass:(Class)aClass {
    if ([self conformsToProtocol:@protocol(NSFastEnumeration)] && [self respondsToSelector:@selector(count)]) {
        id reciever = self;
        NSMutableArray *result = [NSMutableArray arrayWithCapacity:[reciever count]];
        for (id object in reciever) {
            if ([object isMemberOfClass:aClass]) {
                [result addObject:object];
            }
        }
        
        return result.count ? [[result copy] autorelease] : nil;
    }
    
    return nil;
}

@end
