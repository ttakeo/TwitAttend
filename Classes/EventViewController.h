//
//  EventViewController.h
//  TwitAttend
//
//  Created by 竹尾 哲也 on 10/06/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EventViewController : UITableViewController {
    IBOutlet UIWebView *descriptionView;
    NSArray *guests;
}
@property (nonatomic, retain) IBOutlet UIWebView *descriptionView;
@property (nonatomic, retain) NSArray *guests;
@end
