//
//  NSString+AMPRandom.m
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSString+AMPRandom.h"

static const NSUInteger AMPDefaultLength = 10;

NSRange AMPMakeCharacterRange(unichar firstCharacter, unichar lastCharacter) {
    return NSMakeRange(firstCharacter, lastCharacter - firstCharacter + 1);
}

@implementation NSString (AMPRandom)

+ (instancetype)randomString {
    return [self randomStringWithLength:AMPDefaultLength characterRange:AMPMakeCharacterRange('a', 'z')];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length {
    return [self randomStringWithLength:length characterRange:AMPMakeCharacterRange('a', 'z')];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length characterRange:(NSRange)characterRange {
    NSMutableString *resultString = [NSMutableString stringWithCapacity:length];
    for (NSUInteger iterator = 0; iterator < length; iterator++) {
        unichar character = arc4random_uniform((unichar)characterRange.length) + characterRange.location;
        [resultString appendFormat:@"%c", character];
    }
    
    return [self stringWithString:resultString];
}

@end
