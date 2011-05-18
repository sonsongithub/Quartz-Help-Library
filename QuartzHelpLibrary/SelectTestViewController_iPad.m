//
//  SelectTestViewController_iPad.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectTestViewController_iPad.h"


@implementation SelectTestViewController_iPad

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *className = [[testNames objectAtIndex:indexPath.row] stringByAppendingString:@"_iPad"];
	Class targetClass = NSClassFromString(className);
	id con = [[targetClass alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:con animated:YES];
	[con release];
}

@end
