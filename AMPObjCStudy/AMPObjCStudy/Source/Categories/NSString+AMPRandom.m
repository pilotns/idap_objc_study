//
//  NSString+AMPRandom.m
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSString+AMPRandom.h"

@implementation NSString (AMPRandom)

+ (instancetype)randomStringWithLength:(NSUInteger)length {
    NSMutableString *resultString = [NSMutableString stringWithCapacity:length];
    
    NSRange charactersRange = NSMakeRange('a', 'z' - 'a');
    for (NSUInteger iterator = 0; iterator < length; iterator++) {
        unichar character = arc4random_uniform((unichar)charactersRange.length) + charactersRange.location;
        
        [resultString appendFormat:@"%c", character];
    }
    
    return [[self stringWithString:resultString] capitalizedString];
}

@end
