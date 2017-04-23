//
//  AMPCarWashMoneyFlowProtocol.h
//  AMPObjCStudy
//
//  Created by pilotns on 19.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPHuman;

@protocol AMPMoneyFlow <NSObject>
@property (nonatomic, readonly) NSUInteger money;

@optional
- (void)giveMoneyToEmployee:(id<AMPMoneyFlow>)employee;
- (void)takeMoneyFromSender:(id<AMPMoneyFlow>)sender;

@end
