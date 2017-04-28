//
//  AMPNumber.h
//  AMPObjCStudy
//
//  Created by pilotns on 28.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPBlockObservableObject.h"

typedef NS_ENUM(NSUInteger, AMPNumberState) {
    AMPNumberWillChangeState,
    AMPNumberDidChangeState
};

@interface AMPNumber : AMPBlockObservableObject
@property (nonatomic, retain) NSNumber *number;

@end
