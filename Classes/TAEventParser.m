//
//  TAEventParser.m
//  TwitAttend
//
//  Created by 竹尾 哲也 on 10/06/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TAEventParser.h"


@implementation TAEventParser

- (id)init
{
    self = [super init];
    if ( self != nil ) {
        events = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [events release];
    [super dealloc];
}

- (NSArray *)eventsForLocation:(CLLocation *)aLocation
{
    NSString *urlString = @"http://tweetvite.com/api/1.0/rest/search/events?lat=37.775206&lng=-122.419209&format=xml";
    //NSString *urlString = [NSString stringWithFormat:@"http://tweetvite.com/api/1.0/rest/search/events?lat=%d&lng=%d&format=xml", aLocation.coordinate.latitude, aLocation.coordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    NSXMLParser *parser = [[[NSXMLParser alloc] initWithContentsOfURL:url] autorelease];
    parser.delegate = self;
    [parser parse];
    parser.delegate = nil;
    return events;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"elementName:%@ qualifiedName:%@ attributes:%@", elementName, qualifiedName, attributeDict);
    if ( [elementName isEqualToString:@"events"] ) {
        [events removeAllObjects];
    }
    else if ( [elementName isEqualToString:@"event"] ) {
        currentEvent = [[TAEvent alloc] init];
        [events addObject:currentEvent];
        [currentEvent release];
    }
    else if ( [elementName isEqualToString:@"event_id"] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
    else if ( [elementName isEqualToString:@""] ) {
    }
}

@end
