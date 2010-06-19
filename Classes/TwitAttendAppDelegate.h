//
//  TwitAttendAppDelegate.h
//  TwitAttend
//
//  Created by 竹尾 哲也 on 10/06/19.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

extern NSString * const TAEventsUpdateNotification;

@interface TwitAttendAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
    
    //UISearchBar *searchBar;
    
    CLLocationManager *locationManager;
    
    NSArray *events;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

//@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) NSArray *events;

- (NSArray *)eventsForLocation:(CLLocation *)aLocation;
- (NSArray *)eventsForKeyword:(NSString *)keyword;
- (NSArray *)guestsForPublicID:(NSString *)publicID;

@end

