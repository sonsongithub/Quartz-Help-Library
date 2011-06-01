Quartz Help Library=======![sample image](http://sonson.jp/wp/wp-content/uploads/2011/04/qhl.png)This library helps image processing  programming on iOS. Currently, it includes a mutual converter CGImage <-> pixel array..You can convert them mutually without complicated codes.	// original pixel data	int originalWidth = 32;	int originalHeight = 32;	unsigned char* original = (unsigned char*)malloc(sizeof(unsigned char) * originalWidth * originalHeight);		// make test pattern	for (int y = 0; y < originalHeight; y++) {		for (int x = 0; x < originalWidth; x++) {			if (y <= originalHeight / 2 && x <= originalWidth / 2) {				original[y * originalWidth + x] = 0;			}			if (y <= originalHeight / 2 && x > originalWidth / 2) {				original[y * originalWidth + x] = 85;			}			if (y > originalHeight / 2 && x <= originalWidth / 2) {				original[y * originalWidth + x] = 170;			}			if (y > originalHeight / 2 && x > originalWidth / 2) {				original[y * originalWidth + x] = 255;			}		}	}		CGImageRef image = CGImageGrayColorCreateWithGrayPixelBuffer(original, originalWidth, originalHeight);		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:image]];	[self addSubview:imageView];	[imageView release];        How to use======= * Import QuartzCVHelpLibrary.h/m into your project. License=======BSD License.Reference - UIImage(QuartzHelpLibrary)=======	- (NSData*)PNGRepresentaion;###Return valueAn autoreleased NSData object containing the PNG data, or nil if there was a problem generating the data.###DiscussionYou can obtain PNG data as NSData from UIImage directly.	- (NSData*)JPEGRepresentaion;###Return valueAn autoreleased NSData object containing the JPEG data, or nil if there was a problem generating the data. This method uses default JPG compression quiality.###DiscussionYou can obtain JPEG data as NSData from UIImage directly.	- (NSData*)JPEGRepresentaionWithCompressionQuality:(float)compressionQuality;###Parameters###compressionQualityThe quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).###Return valueAn autoreleased NSData object containing the JPEG data, or nil if there was a problem generating the data. This method uses default JPG compression quiality.###DiscussionYou can obtain JPEG data as NSData from UIImage directly.	- (UIImage*)getRotatedImage;###Return valueAn autoreleased bitmap image as UIImage.###DiscussionBitmap image is copied from UIImage which is rotated according to "imageOrienation" attribute. Therefore, the size of the image you obtain is not as same as the original UIImage's.	- (CGImageRef)createCGImageRotated;###Return valueA new Quartz bitmap image. You are responsible for releasing this object by calling CGImageRelease.###DiscussionBitmap image is copied from UIImage which is rotated according to "imageOrienation" attribute. Therefore, the size of the image you obtain is not as same as the original UIImage's.Reference=======	CGImageRef CGImageCreateWithPNGorJPEGFilePath(		CFStringRef filePath	);###Parameters###filePathThe full or relative pathname of your image file, as CFStringRef(NSString).###Return valueA new Quartz bitmap image. You are responsible for releasing this object by calling CGImageRelease.###DiscussionYou can obtain the Quartz bitmap image from the filepath of PNG or JPG file directly.	void CGImageDumpImageInformation(		CGImageRef imageRef	);###Parameters###imageRefThe image to print its information.###DiscussionPrint information of the image to standard output (stdout).The information incudes width, height, bytes per pixel, alpha, byte order, and so on.	void CGCreatePixelBufferWithImage(		CGImageRef imageRef,		unsigned char **pixel,		int *width,		int *height,		int *bytesPerPixel,		QH_PIXEL_TYPE pType	);		###Parameters###imageRefThe image to be copied.###pixelReturn contains pixel buffer of the image. You are responsible for free this data.###widthReturn contains width of the image.###heightReturn contains pixel of the image.###bytesPerPixelReturn contains bytes per pixel of returned the pixel buffer.###pTypeYour favourite pixel type as specified QH\_PIXEL\_TYPE when copying pixel buffer.###DiscussionpType is very important. Specifying QH\_PIXEL\_GRAYSCALE, pixel contains gray scale pixel buffer of the image. And then if the image is RGB or RGBA color scale, it is converted to gray scale automatically. The converting algorithm is based on YUV-RGB(Alpha components are filled with default value as 255). On the contrary, specifying QH\_PIXEL\_COLOR or QH\_PIXEL\_ANYCOLOR when the image is gray scale, automatically pixels' each components are filled with each gray scale value except alpha.	CGImageRef CGImageCreateWithPixelBuffer(		unsigned char *pixel,		int width,		int height,		int bytesPerPixel,		QH_PIXEL_TYPE target_pType	);###Parameters###pixelThe pointer of the pixel buffer to be used to make a new CGImage.###widthWidth of the pixel buffer.###heightHeight of the pixel buffer.###bytesPerPixelBytes per pixel of the pixel buffer.###target_pTypePixel type of the image to be created with above parameters. Specified QH\_PIXEL\_TYPE.###Return valueA new Quartz bitmap image. You are responsible for releasing this object by calling CGImageRelease.###DiscussionUpconverting or downconverting is to be done according to your spceifying `bytesPerPixel` and `target_pType`, like `CGCreatePixelBufferWithImage`.  I doubt that CGImage supports the image whose format is 24 bit per pixel. So, CGImage this method returns is 8bit or 32bit bitmap.	NSData* CGImageGetPNGPresentation(		CGImageRef imageRef	);###Parameters###imageRefThe image to be converted to PNG data.###Return valueAn autoreleased NSData object containing the PNG data, or nil if there was a problem generating the data.###DiscussionTo be written.	NSData* CGImageGetJPEGPresentation(		CGImageRef imageRef	);###Parameters###imageRefThe image to be converted to JPG data.###Return valueAn autoreleased NSData object containing the JPG data, or nil if there was a problem generating the data.###DiscussionTo be written.	CGImageRef CGImageCreateWithResizing(		CGImageRef imageRef,		float scale	);###Parameters###imageRefThe image to be resized.###scaleThe scale factor to used when "imageRef" is resized.###Return valueA new and rotated Quartz bitmap image. You are responsible for releasing this object by calling CGImageRelease.###DiscussionThis function has not been tested yet. Be careful of using this function :-) Reference - Invariables=======###In/Out pixel type	typedef enum {		QH_PIXEL_GRAYSCALE =			0,		QH_PIXEL_COLOR =				1 << 0,		QH_PIXEL_ANYCOLOR =				1 << 1,	}QH_PIXEL_TYPE;	###QH\_PIXEL\_GRAYSCALEGray scale pixel for the output/input image. Typically, bits per pixel is 8bits.###QH\_PIXEL\_COLORRGB color scale pixel for the output/input image. Typically, bits per pixel is 24bits.###QH\_PIXEL\_ANYCOLORThe appropriate color scale pixel for the output/input image. I believe that it does suit to output/input image format....###Bytes per pixel type	typedef enum {		QH_BYTES_PER_PIXEL_UNKNOWN =	0,		QH_BYTES_PER_PIXEL_8BIT =		1,		QH_BYTES_PER_PIXEL_16BIT =		2,		QH_BYTES_PER_PIXEL_24BIT =		3,		QH_BYTES_PER_PIXEL_32BIT =		4,	}QH_BYTES_PER_PIXEL;	###QH\_BYTES\_PER_PIXEL\_UNKNOWNTypically, error.###QH\_BYTES\_PER_PIXEL\_8BITBytes per pixel is 1. In short, bits per pixel is 8 bit. Typically, index color or gray color image.###QH\_BYTES\_PER_PIXEL\_16BITBytes per pixel is 2. In short, bits per pixel is 16 bit. Typically, index color or gray color image with alpha component.###QH\_BYTES\_PER_PIXEL\_24BITBytes per pixel is 3. In short, bits per pixel is 24 bit. Typically, RGB color image.###QH\_BYTES\_PER_PIXEL\_32BITBytes per pixel is 4. In short, bits per pixel is 32 bit. Typically, RGB color image with alpha component. Blog======= * [sonson.jp][]Sorry, Japanese only....Dependency======= * none [Quartz Help Library]: https://github.com/sonsongithub/Quartz-Help-Library[sonson.jp]: http://sonson.jp