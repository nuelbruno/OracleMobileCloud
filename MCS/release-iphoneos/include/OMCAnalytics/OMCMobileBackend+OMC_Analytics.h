//
//  OMCMobileBackend+OMC_Analytics.h
//  OMCAnalytics
//
//  Copyright (c) 2015, Oracle Corp. All rights reserved. 
//

#import "OMCCore/OMCMobileBackend.h"
@class OMCAnalytics;
@class OMCMobileBackend;

/**
 Extends `OMCMobileBackend` with Analytics-specific methods.
 */
@interface OMCMobileBackend (OMC_Analytics)

/**
 Returns the receiver's analytics service.
 */
- (OMCAnalytics*)analytics;

/**
 Removes the receiver's analytics service.
 */
- (void)removeAnalytics;

@end
