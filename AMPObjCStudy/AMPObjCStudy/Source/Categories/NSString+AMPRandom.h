//
//  NSString+AMPRandom.h
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

NSRange AMPMakeCharacterRange(unichar firstCharacter, unichar lastCharacter);

@interface NSString (AMPRandom)

+ (instancetype)randomString;
+ (instancetype)randomStringWithLength:(NSUInteger)length;
+ (instancetype)randomStringWithLength:(NSUInteger)length characterRange:(NSRange)characterRange;

@end
