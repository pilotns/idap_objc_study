//
//  AMPConcreteObserver.h
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPConcreteObservableObject.h"

@interface AMPConcreteObserver : NSObject <AMPObserver>
@property (nonatomic, retain)   AMPConcreteObservableObject *observableObject;

@end
