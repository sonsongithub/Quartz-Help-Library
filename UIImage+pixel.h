//
//  UIImage+pixel.h
//  QuartzHelpLibrary
//
//  Created by sonson on 11/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage(pixel)

- (NSData*)PNGRepresentaion;
- (NSData*)JPEGRepresentaion;
- (NSData*)JPEGRepresentaionWithCompressionQuality:(float)compressionQuality;

@end
