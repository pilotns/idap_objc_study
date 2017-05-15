//
//  AMPDispatcher.h
//  AMPObjCStudy
//
//  Created by pilotns on 15.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPDispatcherWorkingProcess.h"

@interface AMPDispatcher : NSObject

- (void)addWorkers:(NSArray<id<AMPDispatcherWorkingProcess>> *)workers;

- (void)addObjectForProcessing:(id)object;

@end
