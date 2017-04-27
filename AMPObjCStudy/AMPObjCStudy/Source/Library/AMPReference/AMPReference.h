//
//  AMPReference.h
//  AMPObjCStudy
//
//  Created by pilotns on 27.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPReference : NSObject
@property (nonatomic, readonly) id  target;

+ (instancetype)retainReferenceWithTarget:(id)target;
+ (instancetype)assignReferenceWithTarget:(id)target;
+ (instancetype)copyReferenceWithTarget:(id)target;

- (instancetype)initWithTarget:(id)target;

- (BOOL)isEqualToReference:(AMPReference *)reference;

@end
