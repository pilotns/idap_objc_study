//
//  AMPQueue.h
//  AMPObjCStudy
//
//  Created by pilotns on 04.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPQueue : NSObject
@property (nonatomic, readonly) NSUInteger count;

- (void)pushObject:(id)object;
- (id)popObject;

@end
