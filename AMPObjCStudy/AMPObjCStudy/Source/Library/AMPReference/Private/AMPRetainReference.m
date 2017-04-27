//
//  AMPRetainReference.m
//  AMPObjCStudy
//
//  Created by pilotns on 27.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPRetainReference.h"

@interface AMPRetainReference ()
@property (nonatomic, retain)   id  target;

@end

@implementation AMPRetainReference

@synthesize target = _target;

@end
