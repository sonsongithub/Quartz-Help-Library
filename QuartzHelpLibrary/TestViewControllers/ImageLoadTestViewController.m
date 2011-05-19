//
//  ImageLoadTestViewController.m
//  QuartzHelpLibrary
//
//  Created by sonson on 11/05/18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageLoadTestViewController.h"

#import "QuartzHelpLibrary.h"

@implementation ImageLoadTestViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self setTitle:NSStringFromClass([self class])];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	
	// make file path
	NSArray *paths = [NSArray arrayWithObjects:
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_JPG24.jpg" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG8.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG8Alpha.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG24.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_Gray_PNG24Alpha.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_JPG24.jpg" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_PNG8.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_PNG24.png" ofType:nil],
					  [[NSBundle mainBundle] pathForResource:@"testImage_RGB_PNG24Alpha.png" ofType:nil],
					  nil];
	
	UIImageView *imageViews[9];
	
	imageViews[0] = imageView01;
	imageViews[1] = imageView02;
	imageViews[2] = imageView03;
	imageViews[3] = imageView04;
	imageViews[4] = imageView05;
	imageViews[5] = imageView06;
	imageViews[6] = imageView07;
	imageViews[7] = imageView08;
	imageViews[8] = imageView09;
	
	UIImageView **p = imageViews;
	
	// update image views
	for (NSString *path in paths) {
		unsigned char *pixel = NULL;
		int width, height, bytesPerPixel;
		printf("Image file2 = %s\n", [[path lastPathComponent] UTF8String]);
		CGImageRef imageRef = CGImageCreateWithPNGorJPEGFilePath((CFStringRef)path);
		CGImageDumpImageInformation(imageRef);
		
		CGCreatePixelBufferWithImage(imageRef, &pixel, &width, &height, &bytesPerPixel, QH_PIXEL_COLOR);
		
		CGImageRef duplicatedImage = CGImageCreateWithPixelBuffer(pixel, width, height, QH_BYTES_PER_PIXEL_24BIT, QH_PIXEL_COLOR);
		
		UIImageView *v = *p;
		
		
		
		[v setImage:[UIImage imageWithCGImage:duplicatedImage]];
		
		p++;
		
		free(pixel);
	}
}

@end
