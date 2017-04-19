//
//  AMPRangeNumberArray.m
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPRangeNumberArray.h"

NSRange AMPMakeRange(NSUInteger firstNumber, NSUInteger lastNumber);

NSRange AMPMakeRange(NSUInteger firstNumber, NSUInteger lastNumber) {
    NSUInteger minValue = MIN(firstNumber, lastNumber);
    NSUInteger maxValue = MAX(firstNumber, lastNumber);
    
    return NSMakeRange(minValue, maxValue - minValue + 1);
}

@interface AMPRangeNumberArray ()
@property (nonatomic, assign) NSRange numbers;

@end

@implementation AMPRangeNumberArray

#pragma mark -
#pragma mark - Initialization and Deallocations

- (instancetype)initWithFirstNumber:(NSUInteger)firstNumber lastNumber:(NSUInteger)lastNumber {
    self = [super init];
    self.numbers = AMPMakeRange(firstNumber, lastNumber);
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods

- (NSNumber *)numberAtIndex:(NSUInteger)index {
    NSAssert(index < self.count, NSRangeException);
    
    return @(self.numbers.location + index);
}

- (NSUInteger)count {
    return self.numbers.length;
}

@end
