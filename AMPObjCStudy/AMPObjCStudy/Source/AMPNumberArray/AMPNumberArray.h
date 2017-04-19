//
//  AMPNumberArray.h
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPNumberArray : NSObject <NSFastEnumeration>
@property (nonatomic, readonly) NSUInteger count;

+ (instancetype)numberArrayWithFirstNumber:(NSUInteger)firstNumber lastNumber:(NSUInteger)lastNumber;
+ (instancetype)numberArrayWithNumbers:(NSNumber *)firstNumber, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype)numberArrayWithNumberArrays:(NSArray *)numberArrays;

- (instancetype)initWithFirstNumber:(NSUInteger)firstNumber lastNumber:(NSUInteger)lastNumber;
- (instancetype)initWithNumbers:(NSNumber *)firstNumber, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype)initWithNumberArrays:(NSArray *)numberArrays;

- (NSNumber *)numberAtIndex:(NSUInteger)index;
- (NSNumber *)firstNumber;
- (NSNumber *)lastNumber;

- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)index;

@end
