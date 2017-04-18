//
//  AMPArrayNumberArray.h
//  AMPObjCStudy
//
//  Created by pilotns on 16.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPNumberArray.h"

@interface AMPArrayNumberArray : AMPNumberArray
@property (nonatomic, readonly) NSUInteger count;

- (instancetype)initWithNumberArrays:(NSArray *)numberArrays;

@end
