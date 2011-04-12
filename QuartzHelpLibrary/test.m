//
//  test.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "test.h"

#include "QuartzHelpLibrary.h"

void testImage(NSString *path) {
	CGImageRef imageRef = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
	CGImageDumpImageInformation(imageRef);
	CGImageDumpAlphaInformation(imageRef);
	CGImageDumpBitmapInformation(imageRef);
}

void test() {
	NSArray *paths = [NSArray arrayWithObjects:
										[[NSBundle mainBundle] pathForResource:@"iossdkhack" ofType:@"jpg"],
										[[NSBundle mainBundle] pathForResource:@"iossdkhack" ofType:@"png"],
										nil];
	
	for (NSString *path in paths) {
		NSLog(@"%@", path);
		testImage(path);
	}
}
