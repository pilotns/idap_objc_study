//
//  AMPTimerServiceObject.h
//  AMPObjCStudy
//
//  Created by pilotns on 23.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kAMPTimerHandlerKey = @"kAMPTimerHandlerKey";

@interface AMPTimerServiceObject : NSObject

- (void)fireTimer:(NSTimer *)timer;

@end
