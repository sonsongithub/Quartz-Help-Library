//
//  SelectTestViewController.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectTestViewController.h"

#import "QuartzHelpLibraryViewController.h"

@implementation SelectTestViewController

- (void)dealloc
{
	[testNames release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if (testNames == nil) {
		testNames = [[NSMutableArray array] retain];
		[testNames addObject:@"QuartzHelpLibraryViewController"];
		[testNames addObject:@"ImageLoadTestViewController"];
		[testNames addObject:@"OrientationTestViewController"];
	}
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self setTitle:NSLocalizedString(@"Select test", nil)];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [testNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	[cell.textLabel setText:[testNames objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *className = [testNames objectAtIndex:indexPath.row];
	Class targetClass = NSClassFromString(className);
	id con = [[targetClass alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:con animated:YES];
	[con release];
}

@end
