//
//  SimpleXml.h
//  my30min
//
//  Created by Nonomura Noriyuki on 10/05/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SimpleXml : NSObject {
	NSMutableArray *itemArray;
	NSMutableDictionary *itemDict;
	NSMutableString *elementString;
	NSMutableString *currentTagName;
	NSMutableDictionary *loopDict;
	BOOL loopFlag;
	NSMutableArray *loopItemArray;
	NSMutableDictionary *loopItemDict;
	NSMutableString *loopName;
}

@property (nonatomic, retain) NSMutableArray *itemArray;
@property (nonatomic, retain) NSMutableDictionary *itemDict;
@property (nonatomic, retain) NSMutableString *elementString;
@property (nonatomic, retain) NSMutableString *currentTagName;
@property (nonatomic, retain) NSMutableDictionary *loopDict;
@property (nonatomic, assign) BOOL loopFlag;
@property (nonatomic, retain) NSMutableDictionary *loopItemDict;
@property (nonatomic, retain) NSMutableString *loopName;

- (void)parse:(NSData *)bodyData tagName:(NSString *)tagName;

@end
