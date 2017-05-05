//
//  AMPObservableObject.h
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPObservableObject : NSObject
@property (nonatomic, assign)   NSUInteger  state;
@property (nonatomic, readonly) NSSet       *observers;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (BOOL)isObserver:(id)observer;

- (SEL)selectorForState:(NSUInteger)state;

@end
