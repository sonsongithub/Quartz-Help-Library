//
//  UIImage+pixel.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+pixel.h"

@implementation UIImage(pixel)

- (NSData*)PNGRepresentaion {
	return UIImagePNGRepresentation(self);
}

- (NSData*)JPEGRepresentaion {
	return [self JPEGRepresentaionWithCompressionQuality:1];
}

- (NSData*)JPEGRepresentaionWithCompressionQuality:(float)compressionQuality {
	return UIImageJPEGRepresentation(self, compressionQuality);
}

@end
