//
//  TAEvent.h
//  TwitAttend
//
//  Created by 竹尾 哲也 on 10/06/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TAEvent : NSObject {
    NSString *eventID;
    NSString *publicID;
    NSString *title;
    NSString *description;
    NSString *hashTag;
    NSString *hostedBy;
    BOOL canceled;
    NSInteger live;
    NSInteger liveTS;
    BOOL isPublic;
    NSInteger maxGuests;
    NSInteger maxGuestsNum;
    NSInteger postedToLocal;
    NSDate *startDate;
    NSDate *endDate;
    NSTimeZone *timeZone;
    NSString *locationName;
    NSString *locationAddress;
    NSString *locationThoroughfare;
    NSString *locationCity;
    NSString *locationRegion;
    NSString *locationCountry;
    NSString *locationCountryCode;
    NSString *locationZip;
    CLLocationDegrees locationLongitude;
    CLLocationDegrees locationLatitude;
    NSString *invitation;
    NSString *invitationTiny;
    NSInteger createdBy;
    NSInteger createdAt;
    NSInteger updatedAt;
}
@property (nonatomic, retain) NSString *eventID;
@property (nonatomic, retain) NSString *publicID;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *hashTag;
@property (nonatomic, retain) NSString *hostedBy;
@property (nonatomic) BOOL canceled;
@property (nonatomic) NSInteger live;
@property (nonatomic) NSInteger liveTS;
@property (nonatomic) BOOL isPublic;
@property (nonatomic) NSInteger maxGuests;
@property (nonatomic) NSInteger maxGuestsNum;
@property (nonatomic) NSInteger postedToLocal;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSTimeZone *timeZone;
@property (nonatomic, retain) NSString *locationName;
@property (nonatomic, retain) NSString *locationAddress;
@property (nonatomic, retain) NSString *locationThoroughfare;
@property (nonatomic, retain) NSString *locationCity;
@property (nonatomic, retain) NSString *locationRegion;
@property (nonatomic, retain) NSString *locationCountry;
@property (nonatomic, retain) NSString *locationCountryCode;
@property (nonatomic, retain) NSString *locationZip;
@property (nonatomic) CLLocationDegrees locationLongitude;
@property (nonatomic) CLLocationDegrees locationLatitude;
@property (nonatomic, retain) NSString *invitation;
@property (nonatomic, retain) NSString *invitationTiny;
@property (nonatomic) NSInteger createdBy;
@property (nonatomic) NSInteger createdAt;
@property (nonatomic) NSInteger updatedAt;
@end
