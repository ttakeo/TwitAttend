//
//  RootViewController.h
//  TwitAttend
//
//  Created by 竹尾 哲也 on 10/06/19.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UISearchBarDelegate> {
    IBOutlet UISearchBar *searchBar;
    NSArray *events;
}
@property (nonatomic, retain) NSArray *events;
- (IBAction)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar;

@end
