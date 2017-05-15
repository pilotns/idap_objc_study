//
//  AMPDispatcherWorkingProcess.h
//  AMPObjCStudy
//
//  Created by pilotns on 15.05.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AMPDispatcherWorkingProcess <NSObject>
@property (nonatomic, readonly) NSUInteger  state;

- (void)performProcessingObject:(id)object;

@end
