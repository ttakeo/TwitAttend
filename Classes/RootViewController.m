//
//  RootViewController.m
//  TwitAttend
//
//  Created by 竹尾 哲也 on 10/06/19.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "EventViewController.h"
#import "TwitAttendAppDelegate.h"


@implementation RootViewController

@synthesize events;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = NSLocalizedString(@"Events", @"Events");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:TAEventsUpdateNotification object:nil];


    ((UITableView *)self.view).tableHeaderView = searchBar;
    searchBar.delegate = self;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //TwitAttendAppDelegate *appDelegate = (TwitAttendAppDelegate *)[[UIApplication sharedApplication] delegate];
    return [self.events count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.

    //TwitAttendAppDelegate *appDelegate = (TwitAttendAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *event = [self.events objectAtIndex:indexPath.row];
    cell.textLabel.text = [event objectForKey:@"title"];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	 EventViewController *eventViewController = [[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:eventViewController animated:YES];
	 [eventViewController release];
	 
    TwitAttendAppDelegate *appDelegate = (TwitAttendAppDelegate *)[[UIApplication sharedApplication] delegate];

    NSDictionary *event = [self.events objectAtIndex:indexPath.row];
    NSString *publicID = [event objectForKey:@"public_id"];
    eventViewController.title = [event objectForKey:@"title"];
    [eventViewController.descriptionView loadHTMLString:[event objectForKey:@"description"] baseURL:nil];
    eventViewController.guests = [appDelegate guestsForPublicID:publicID];
    //NSLog(@"guests:%@", guests);
}


#pragma mark -
#pragma mark Search bar delegate

- (IBAction)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    //NSLog(@"theSearchBar:%@", theSearchBar);
    TwitAttendAppDelegate *appDelegate = (TwitAttendAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.events = [appDelegate eventsForKeyword:searchBar.text];
    
    [searchBar resignFirstResponder];
    [(UITableView *)self.view reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar
{
    [searchBar resignFirstResponder];
}

- (void)update:(NSNotification *)aNotification
{
    //NSLog(@"update:%@", self.view);

    TwitAttendAppDelegate *appDelegate = (TwitAttendAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.events = [appDelegate events];
    
    [(UITableView *)self.view reloadData];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TAEventsUpdateNotification object:nil];
}


- (void)dealloc {
    [super dealloc];
}


@end

