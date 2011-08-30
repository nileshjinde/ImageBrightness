//
//  MainView.h
//  ImageBrightness
//
//  Created by Jorge on 1/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainView : UIView {
	UIImageView *iv;
	UISlider *slider;
	UIImage *originalImage;
    UISwitch *theSwitch;
    
    UIButton *redB;
    UIButton *greenB;
    UIButton *blueB;
    UIButton *grayB;
    UIButton *sepiaB;
}
@property(nonatomic,retain)UISlider *slider;
@property (nonatomic, retain) IBOutlet UISwitch *theSwitch;
@property (nonatomic, retain) IBOutlet UIButton *redB;
@property (nonatomic, retain) IBOutlet UIButton *greenB;
@property (nonatomic, retain) IBOutlet UIButton *blueB;
@property (nonatomic, retain) IBOutlet UIButton *grayB;
@property (nonatomic, retain) IBOutlet UIButton *sepiaB;


-(void)doImageStuff:(int)value;
- (IBAction) toggleSwitch: (UISwitch *) sender;
-(IBAction)redBClicked:(UIButton *)sender;
-(IBAction)greenBClicked:(UIButton *)sender;
-(IBAction)blueBClicked:(UIButton *)sender;
-(IBAction)grayBClicked:(UIButton *)sender;
-(IBAction)sepiaBClicked:(UIButton *)sender;

@end
