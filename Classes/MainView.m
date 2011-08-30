//
//  MainView.m
//  ImageBrightness
//
//  Created by Jorge on 1/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"

CFDataRef CopyImagePixels(CGImageRef inImage){
    return CGDataProviderCopyData(CGImageGetDataProvider(inImage));
}



@implementation MainView
@synthesize slider;
@synthesize theSwitch;
@synthesize redB;
@synthesize greenB;
@synthesize blueB;
@synthesize grayB;
@synthesize sepiaB;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
		originalImage=[UIImage imageNamed:@"IMG_0168.JPG"];
		iv=[[UIImageView alloc] initWithImage:originalImage];
		CGRect r=[iv frame];
		r.size.width=r.size.width*.50;
		r.size.height=r.size.height*.50;
		[iv setFrame:r];
		[self addSubview:iv];
		/*
		UIButton *b=[[UIButton alloc] initWithFrame:CGRectMake(120, 300, 60, 30)];
		[b setBackgroundColor:[UIColor blueColor]];
		[b setTitle:@"TEST" forState:0];
		[b addTarget:self action:@selector(doImageStuff) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:b];
		[b release];
		*/
		slider=[[UISlider alloc] initWithFrame:CGRectMake(50, 300, 200, 30)];
		[slider setMinimumValue:-255];
		[slider setMaximumValue:255];
		[slider setValue:50];
		[slider addTarget:self action:@selector(sliderDidSlide:) forControlEvents:UIControlEventValueChanged];
		[self addSubview:slider];
        
        
        theSwitch=[[UISwitch alloc] initWithFrame:CGRectMake(50, 330, 100, 30)];
        [theSwitch addTarget:self action:@selector(toggleSwitch:) forControlEvents:UIControlEventValueChanged];
        [theSwitch setOn:YES];
        [self addSubview:theSwitch];
      
                
        redB=[[UIButton alloc] initWithFrame:CGRectMake(20, 370, 50, 30)];
        [redB setTitle:@"RED" forState:UIControlStateNormal];
        [redB addTarget:self action:@selector(redBClicked:) forControlEvents:UIControlEventTouchUpInside];
        redB.backgroundColor =[UIColor redColor];
        [self addSubview:redB];
        
        blueB=[[UIButton alloc] initWithFrame:CGRectMake(80, 370, 50, 30)];
        [blueB setTitle:@"BLUE" forState:UIControlStateNormal];
        [blueB addTarget:self action:@selector(blueBClicked:) forControlEvents:UIControlEventTouchUpInside];
        blueB.backgroundColor =[UIColor blueColor];
        [self addSubview:blueB];
        
        greenB=[[UIButton alloc] initWithFrame:CGRectMake(140, 370, 70, 30)];
        [greenB setTitle:@"GREEN" forState:UIControlStateNormal];
        [greenB addTarget:self action:@selector(greenBClicked:) forControlEvents:UIControlEventTouchUpInside];
        greenB.backgroundColor =[UIColor greenColor];
        [self addSubview:greenB];
        
        grayB=[[UIButton alloc] initWithFrame:CGRectMake(220, 370, 70, 30)];
        [grayB setTitle:@"GRAY" forState:UIControlStateNormal];
        [grayB addTarget:self action:@selector(grayBClicked:) forControlEvents:UIControlEventTouchUpInside];
       grayB.backgroundColor =[UIColor grayColor];
        [self addSubview:grayB];
        
        sepiaB=[[UIButton alloc] initWithFrame:CGRectMake(20, 410, 60, 30)];
        [sepiaB setTitle:@"SEPIA" forState:UIControlStateNormal];
        [sepiaB addTarget:self action:@selector(sepiaBClicked:) forControlEvents:UIControlEventTouchUpInside];
        UIColor *myColor2 = [[UIColor alloc] initWithRed:0.9333f green:0.9098f blue:0.6667f alpha:1.0f]; 
        sepiaB.backgroundColor =myColor2;
        [self addSubview:sepiaB];
        
    }
    return self;
}

-(void)sliderDidSlide:(id)sender{
	[self doImageStuff:slider.value];
}

-(void)doImageStuff:(int)value{
	CGImageRef img=originalImage.CGImage;
	CFDataRef dataref=CopyImagePixels(img);
	UInt8 *data=(UInt8 *)CFDataGetBytePtr(dataref);
	int length=CFDataGetLength(dataref);
	for(int index=0;index<length;index+=4){
		// BRIGHTNESS
		for(int i=0;i<3;i++){
			if(data[index+i]+value<0){
				data[index+i]=0;
			}else{
				if(data[index+i]+value>255){
					data[index+i]=255;
				}else{
					data[index+i]+=value;
				}
			}
		}
		 
		
	}
	size_t width=CGImageGetWidth(img);
	size_t height=CGImageGetHeight(img);
	size_t bitsPerComponent=CGImageGetBitsPerComponent(img);
	size_t bitsPerPixel=CGImageGetBitsPerPixel(img);
	size_t bytesPerRow=CGImageGetBytesPerRow(img);
	CGColorSpaceRef colorspace=CGImageGetColorSpace(img);
	CGBitmapInfo bitmapInfo=CGImageGetBitmapInfo(img);
	CFDataRef newData=CFDataCreate(NULL,data,length);
	CGDataProviderRef provider=CGDataProviderCreateWithCFData(newData);
	CGImageRef newImg=CGImageCreate(width,height,bitsPerComponent,bitsPerPixel,bytesPerRow,colorspace,bitmapInfo,provider,NULL,true,kCGRenderingIntentDefault);
	[iv setImage:[UIImage imageWithCGImage:newImg]];
	CGImageRelease(newImg);
	CGDataProviderRelease(provider);
    
    
	
}
-(IBAction)grayBClicked:(UIButton *)sender{
    
       
    
	CGContextRef ctx; 
    CGImageRef imageRef = originalImage.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
												 bitsPerComponent, bytesPerRow, colorSpace,
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
	
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
	
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * 0) + 0 * bytesPerPixel;
    for (int ii = 0 ; ii < width * height ; ++ii)
    {
        // Get color values to construct a UIColor
        //		  CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        //        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        //        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        //        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
		
		int outputColor = (rawData[byteIndex] + rawData[byteIndex+1] + rawData[byteIndex+2]) / 3;
		
		rawData[byteIndex] = (char) (outputColor);
		rawData[byteIndex+1] = (char) (outputColor);
		rawData[byteIndex+2] = (char) (outputColor);
		
        byteIndex += 4;
    }
	
	ctx = CGBitmapContextCreate(rawData,  
								CGImageGetWidth( imageRef ),  
								CGImageGetHeight( imageRef ),  
								8,  
								CGImageGetBytesPerRow( imageRef ),  
								CGImageGetColorSpace( imageRef ),  
								kCGImageAlphaPremultipliedLast ); 
	
	imageRef = CGBitmapContextCreateImage (ctx);  
	UIImage* rawImage = [UIImage imageWithCGImage:imageRef];  
	
	CGContextRelease(ctx);  
	
	iv.image=rawImage;
	
	free(rawData);
    
    
}  	 

- (IBAction) toggleSwitch: (UISwitch*) sender {
    
    if (theSwitch.on){
         iv.image = [UIImage imageNamed:@"IMG_0168.JPG"];
    
               
    } else {
        CGImageRef sourceImage = originalImage.CGImage;
        
        CFDataRef theData;
        theData = CGDataProviderCopyData(CGImageGetDataProvider(sourceImage));
        
        UInt8 *pixelData = (UInt8 *) CFDataGetBytePtr(theData);
        
        int dataLength = CFDataGetLength(theData);
        
        int red = 0;
        int green = 1;
        int blue = 2;
        
        for (int index = 0; index < dataLength; index += 4) {
            if (pixelData[index + green] - 128 > 0) {
                pixelData[index + red] = pixelData[index + green] - 128;
                pixelData[index + blue] = pixelData[index + green] - 128;
            } else {
                pixelData[index + red] = 0;
                pixelData[index + blue] = 0;
            }
        }
        
        CGContextRef context;
        context = CGBitmapContextCreate(pixelData,
                                        CGImageGetWidth(sourceImage),
                                        CGImageGetHeight(sourceImage),
                                        8,
                                        CGImageGetBytesPerRow(sourceImage),
                                        CGImageGetColorSpace(sourceImage),
                                        kCGImageAlphaPremultipliedLast);
        
        CGImageRef newCGImage = CGBitmapContextCreateImage(context);
        UIImage *newImage = [UIImage imageWithCGImage:newCGImage];
        
        CGContextRelease(context);
        CFRelease(theData);
        CGImageRelease(newCGImage);
        
        iv.image = newImage;
        
        
               
    }

}


-(IBAction)redBClicked:(UIButton *)sender{
    
    CGImageRef sourceImage = originalImage.CGImage;
    
    CFDataRef theData;
    theData = CGDataProviderCopyData(CGImageGetDataProvider(sourceImage));
    
    UInt8 *pixelData = (UInt8 *) CFDataGetBytePtr(theData);
    
    int dataLength = CFDataGetLength(theData);
    
    int red = 1;
    int green = 0;
    int blue = 2;
    
    for (int index = 0; index < dataLength; index += 4) {
        if (pixelData[index + green] - 128 > 0) {
            pixelData[index + red] = pixelData[index + green] - 128;
            pixelData[index + blue] = pixelData[index + green] - 128;
        } else {
            pixelData[index + red] = 0;
            pixelData[index + blue] = 0;
        }
    }
    
    CGContextRef context;
    context = CGBitmapContextCreate(pixelData,
                                    CGImageGetWidth(sourceImage),
                                    CGImageGetHeight(sourceImage),
                                    8,
                                    CGImageGetBytesPerRow(sourceImage),
                                    CGImageGetColorSpace(sourceImage),
                                    kCGImageAlphaPremultipliedLast);
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newCGImage];
    
    CGContextRelease(context);
    CFRelease(theData);
    CGImageRelease(newCGImage);
    
    iv.image = newImage;

}
-(IBAction)blueBClicked:(UIButton *)sender{
    
    CGImageRef sourceImage = originalImage.CGImage;
    
    CFDataRef theData;
    theData = CGDataProviderCopyData(CGImageGetDataProvider(sourceImage));
    
    UInt8 *pixelData = (UInt8 *) CFDataGetBytePtr(theData);
    
    int dataLength = CFDataGetLength(theData);
    
    int red = 0;
    int green = 2;
    int blue = 1;
    
    for (int index = 0; index < dataLength; index += 4) {
        if (pixelData[index + green] - 128 > 0) {
            pixelData[index + red] = pixelData[index + green] - 128;
            pixelData[index + blue] = pixelData[index + green] - 128;
        } else {
            pixelData[index + red] = 0;
            pixelData[index + blue] = 0;
        }
    }
    
    CGContextRef context;
    context = CGBitmapContextCreate(pixelData,
                                    CGImageGetWidth(sourceImage),
                                    CGImageGetHeight(sourceImage),
                                    8,
                                    CGImageGetBytesPerRow(sourceImage),
                                    CGImageGetColorSpace(sourceImage),
                                    kCGImageAlphaPremultipliedLast);
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newCGImage];
    
    CGContextRelease(context);
    CFRelease(theData);
    CGImageRelease(newCGImage);
    
    iv.image = newImage;
    
}

-(IBAction)greenBClicked:(UIButton *)sender{
    
    CGImageRef sourceImage = originalImage.CGImage;
    
    CFDataRef theData;
    theData = CGDataProviderCopyData(CGImageGetDataProvider(sourceImage));
    
    UInt8 *pixelData = (UInt8 *) CFDataGetBytePtr(theData);
    
    int dataLength = CFDataGetLength(theData);
    
    int red = 2;
    int green = 1;
    int blue = 0;
    
    for (int index = 0; index < dataLength; index += 4) {
        if (pixelData[index + green] - 128 > 0) {
            pixelData[index + red] = pixelData[index + green] - 128;
            pixelData[index + blue] = pixelData[index + green] - 128;
        } else {
            pixelData[index + red] = 0;
            pixelData[index + blue] = 0;
        }
    }
    
    CGContextRef context;
    context = CGBitmapContextCreate(pixelData,
                                    CGImageGetWidth(sourceImage),
                                    CGImageGetHeight(sourceImage),
                                    8,
                                    CGImageGetBytesPerRow(sourceImage),
                                    CGImageGetColorSpace(sourceImage),
                                    kCGImageAlphaPremultipliedLast);
    
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newCGImage];
    
    CGContextRelease(context);
    CFRelease(theData);
    CGImageRelease(newCGImage);
    
    iv.image = newImage;
    
}
-(IBAction)sepiaBClicked:(UIButton *)sender
{
    //-----------------------Sepia effect-----------------------------------------
    CGImageRef orgImage = originalImage.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                       CGImageGetWidth(orgImage),
                                                       CGImageGetHeight(orgImage ),
                                                       8,
                                                       CGImageGetWidth(orgImage )*4,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, CGBitmapContextGetWidth(bitmapContext), CGBitmapContextGetHeight(bitmapContext)), orgImage );
    UInt8 *data = CGBitmapContextGetData(bitmapContext);
    int numComponents = 4;
    int bytesInContext = CGBitmapContextGetHeight(bitmapContext) * CGBitmapContextGetBytesPerRow(bitmapContext);
    
    int redIn, greenIn, blueIn, redOut, greenOut, blueOut;
    
    for (int i = 0; i < bytesInContext; i += numComponents) {
        
        redIn = data[i];
        greenIn = data[i+1];
        blueIn = data[i+2];
        
        redOut = (int)(redIn * .393) + (greenIn *.769) + (blueIn * .189);
        greenOut = (int)(redIn * .349) + (greenIn *.686) + (blueIn * .168);
        blueOut = (int)(redIn * .272) + (greenIn *.534) + (blueIn * .131);		
        
        if (redOut>255) redOut = 255;
        if (blueOut>255) blueOut = 255;
        if (greenOut>255) greenOut = 255;
        
        data[i] = (redOut);
        data[i+1] = (greenOut);
        data[i+2] = (blueOut);
    }
    
    CGImageRef outImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *uiImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    iv.image=uiImage;
    //-----------------------------------------------------------------------------

}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
	[iv release];
	[slider release];
    [theSwitch release];
    [redB release];
    [grayB release];
    [greenB release];
    [blueB release];
    [sepiaB release];
    [super dealloc];
}


@end
