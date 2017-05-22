//
//  AMPCarWashMoneyFlowProtocol.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPWorker;

@protocol AMPMoneyFlow <NSObject>
@property (nonatomic, readonly) NSUInteger money;

- (NSUInteger)giveMoney;
- (void)receiveMoney:(NSUInteger)money;

@optional
- (void)takeMoneyFormObject:(id<AMPMoneyFlow>)object;

@end
