//
//  AMPNumberArray.h
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPNumberArray : NSObject <NSFastEnumeration>

+ (instancetype)numberArrayWithRange:(NSUInteger)firstNumber lastNumber:(NSUInteger)lastNumber;
+ (instancetype)numberArrayWithNumbers:(NSUInteger *)numbers count:(NSUInteger)count;
+ (instancetype)numberArrayWithNumberArrays:(NSArray *)numberArrays;

- (instancetype)initWithRange:(NSUInteger)firstNumber lastNumber:(NSUInteger)lastNumber;
- (instancetype)initWithNumbers:(NSUInteger *)numbers count:(NSUInteger)count;
- (instancetype)initWithNumberArrays:(NSArray *)numberArrays;

- (NSNumber *)numberAtIndex:(NSUInteger)index;
- (NSNumber *)firstNumber;
- (NSNumber *)lastNumber;
- (NSUInteger)count;

- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)index;

@end
