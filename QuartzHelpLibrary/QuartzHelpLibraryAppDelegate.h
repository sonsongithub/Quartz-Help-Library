//
//  QuartzHelpLibraryAppDelegate.h
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuartzHelpLibraryViewController;

@interface QuartzHelpLibraryAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet QuartzHelpLibraryViewController *viewController;

@end
