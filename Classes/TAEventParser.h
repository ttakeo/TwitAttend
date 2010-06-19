//
//  TAEventParser.h
//  TwitAttend
//
//  Created by 竹尾 哲也 on 10/06/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "TAEvent.h"

@interface TAEventParser : NSObject {
    NSMutableArray *events;
    TAEvent *currentEvent;
}
- (NSArray *)eventsForLocation:(CLLocation *)aLocation;

@end
