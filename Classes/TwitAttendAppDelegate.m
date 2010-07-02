//
//  TwitAttendAppDelegate.m
//  TwitAttend
//
//  Created by 竹尾 哲也 on 10/06/19.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TwitAttendAppDelegate.h"
#import "RootViewController.h"
#import "TAEventParser.h"
#import "TAEvent.h"
#import "SimpleXml.h"

NSString * const TAEventsUpdateNotification = @"TAEventsUpdateNotification";

@implementation TwitAttendAppDelegate

@synthesize window;
@synthesize navigationController;
//@synthesize searchBar;
@synthesize events;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
        
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"location:%@", newLocation);
    //self.events = [self eventsForLocation:newLocation];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:newLocation, @"newLocation", nil];
    [[NSNotificationCenter defaultCenter] postNotification:
     [NSNotification notificationWithName:TAEventsUpdateNotification object:self userInfo:userInfo]];
    
    [locationManager stopUpdatingLocation];
}

- (void)updateLocation
{
    [locationManager startUpdatingLocation];
}

- (NSArray *)eventsForLocation:(CLLocation *)aLocation
{
    NSArray *results = nil;
    //NSString *urlString = @"http://tweetvite.com/api/1.0/rest/search/events?lat=37.775206&lng=-122.419209&format=xml";
    NSString *urlString = [NSString stringWithFormat:@"http://tweetvite.com/api/1.0/rest/search/events?lat=%f&lng=%f&format=xml", aLocation.coordinate.latitude, aLocation.coordinate.longitude];
    NSLog(@"urlString:%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    SimpleXml *xmlParser = [[SimpleXml alloc] init];
    [xmlParser parse:contents tagName:@"event"];
    results = [[xmlParser.itemArray retain] autorelease];
    [contents release];
    [xmlParser release];
    
    return results;
}

- (NSArray *)eventsForKeyword:(NSString *)keyword
{
    NSArray *results = nil;
    NSString *urlString = [NSString stringWithFormat:@"http://tweetvite.com/api/1.0/rest/search/events?q=%@&format=xml", keyword];
    NSLog(@"urlString:%@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    SimpleXml *xmlParser = [[SimpleXml alloc] init];
    [xmlParser parse:contents tagName:@"event"];
    results = [[xmlParser.itemArray retain] autorelease];
    [contents release];
    [xmlParser release];
    
    return results;
}

- (NSArray *)guestsForPublicID:(NSString *)publicID
{
    NSArray *results = nil;
    NSString *urlString = [NSString stringWithFormat:@"http://tweetvite.com/api/1.0/rest/events/guest_list?public_id=%@&format=xml", publicID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *contents = [[NSData alloc] initWithContentsOfURL:url];
    SimpleXml *xmlParser = [[SimpleXml alloc] init];
    [xmlParser parse:contents tagName:@"guest"];
    results = [[xmlParser.itemArray retain] autorelease];
    [contents release];
    [xmlParser release];
    
    return results;
}

@end

