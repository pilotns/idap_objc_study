//
//  AMPNumberObserver.h
//  AMPObjCStudy
//
//  Created by pilotns on 28.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPNumber;

@interface AMPNumberObserver : NSObject
@property (nonatomic, retain) AMPNumber *number;

- (void)numberWillChangeWithUserInfo:(id)userInfo;
- (void)numberDidChangeWithUserInfo:(id)userInfo;

@end
