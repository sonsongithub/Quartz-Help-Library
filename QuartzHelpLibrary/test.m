//
//  test.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "test.h"

#include "QuartzHelpLibrary.h"

void test() {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"iossdkhack.jpg" ofType:nil];
	CGImageRef imageRef = CGImageCreateWithPNGorJPEGFilePath(path);
	CGImageDumpAlphaInformation(imageRef);
	CGImageDumpBitmapInformation(imageRef);
}
