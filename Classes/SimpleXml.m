//
//  SimpleXml.m
//  my30min
//
//  Created by Nonomura Noriyuki on 10/05/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SimpleXml.h"


@implementation SimpleXml

@synthesize itemArray;
@synthesize itemDict;
@synthesize elementString;
@synthesize currentTagName;
@synthesize loopDict;
@synthesize loopFlag;
@synthesize loopItemDict;
@synthesize loopName;

- (id) init {
	self = [super init];
	
	if (self != nil) {
		itemArray = [[NSMutableArray alloc] init];
		itemDict = [[NSMutableDictionary alloc] init];
		elementString = [[NSMutableString alloc] init];
		currentTagName = [[NSMutableString alloc] init];
		loopDict = [[NSMutableDictionary alloc] init];
		loopFlag = NO;
		loopItemDict = [[NSMutableDictionary alloc] init];
		loopName = [[NSMutableString alloc] init];
	}
	
	return self;
}

- (void)dealloc {
	[itemArray release];
	[itemDict release];
	[elementString release];
	[currentTagName release];
	[loopDict release];
	[loopItemDict release];
	[loopName release];
    [super dealloc];
}

- (void)parse:(NSData *)bodyData tagName:(NSString *)tagName {
	[currentTagName setString:tagName];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:bodyData];
	[parser setDelegate:self];
	[parser parse];
	[parser release];
}

#pragma mark ---- delegate methods for the NSXMLParser ----

- (void)parserDidStartDocument:tagname:(NSXMLParser *)parser {
	[itemArray removeAllObjects];
	[itemDict removeAllObjects];;
	[elementString setString:@""];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	[elementString setString:@""];
	
	if ([loopDict objectForKey:elementName] != nil) {
		if ([itemDict objectForKey:elementName] == nil) {
			loopFlag = YES;
			[loopName setString:elementName];
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:currentTagName]) {
		NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithDictionary:itemDict];
		[itemArray addObject:tmpDict];
		[tmpDict release];
		
		[itemDict removeAllObjects];
	}
	else if (loopFlag) {
		if ([elementName isEqualToString:loopName] == YES) {
			if ([itemDict objectForKey:elementName] == nil) {
				NSMutableDictionary *loopTmpDict = [[NSMutableDictionary alloc] initWithDictionary:loopItemDict];
				NSMutableArray *tmpArray = [NSMutableArray arrayWithObjects:
											loopTmpDict,
											nil
											];
				
				[loopTmpDict release];
				[itemDict setObject:tmpArray forKey:elementName];
			}
			else {
				NSMutableArray *tmpArray = [itemDict objectForKey:elementName];
				NSMutableDictionary *loopTmpDict = [[NSMutableDictionary alloc] initWithDictionary:loopItemDict];
				[tmpArray addObject:loopTmpDict];
				[loopTmpDict release];
				
				[itemDict setObject:tmpArray forKey:elementName];
			}
			
			loopFlag = NO;
			[loopName setString:@""];
			
			[loopItemDict removeAllObjects];
		}
		else {
			CFStringTrimWhitespace((CFMutableStringRef)elementString);
			[loopItemDict setObject:[NSMutableString stringWithString:elementString] forKey:elementName];
		}
	}
	else {
		CFStringTrimWhitespace((CFMutableStringRef)elementString);
		[itemDict setObject:[NSMutableString stringWithString:elementString] forKey:elementName];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	[elementString appendString:string];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"xmlDidParse" object:self];
}

@end
