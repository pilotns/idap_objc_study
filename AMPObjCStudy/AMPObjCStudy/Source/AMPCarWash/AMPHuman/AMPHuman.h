//
//  AMPHuman.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPMoneyFlow.h"

@interface AMPHuman : NSObject <AMPMoneyFlow>
@property (nonatomic, readonly) NSString    *name;

@end
