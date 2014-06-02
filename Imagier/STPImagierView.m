//
//  STPImagierView.m
//  Imagier
//
//  Created by Nanook on 26/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPImagierView.h"
#import "STPLayoutConstraintBuilder.h"

@interface STPImagierView(){
    UIStepper * picturesStepper;
    UILabel * pictureTitle, * widthLabel, * heightLabel;
    UIScrollView * pictureArea;
    UISlider * widthSlider, * heightSlider;
    UIImageView * pictureView;
    
    NSMutableArray * flexConstraints;
    BOOL isIpad;
    BOOL isLandscape;
    int gap;
    
    float minScale;
    float maxScale;
    
    float pictureScaleX;
    float pictureScaleY;
    
    CGSize currentImageSize;
}

@end

@implementation STPImagierView

- (id)init {
    self = [super init];
    
    if (self) {
        //init flexConstraints
        flexConstraints = [[NSMutableArray alloc] init];
        gap = 10;
        
        minScale = 0.01f;
        maxScale = 1.0f;
        
        pictureScaleX = pictureScaleY = 1.0f;
        
        /* setup widgets */
        [self setupPicturesStepper];
        [self setupHeightSlider];
        [self setupHeightLabel];
        [self setupWidthSlider];
        [self setupWidthLabel];
        [self setupPictureArea];
        [self setupPictureTitle];
                
    }
    
    return self;
}


-(void)configStepperWithMin:(int)min andMax:(int)max andTarget:(id)target andAction:(SEL)action {
    [picturesStepper setMinimumValue:min];
    [picturesStepper setMaximumValue:max];
    [picturesStepper setValue:min];
    [picturesStepper addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}
-(int)stepperValue {
    return [picturesStepper value];
}

/* ---- Setup widgets ---- */
-(void)setupPictureArea {
    pictureArea = [[UIScrollView alloc]init];
    [pictureArea setDelegate:self];
    [pictureArea setMinimumZoomScale:minScale];
    [pictureArea setMaximumZoomScale:maxScale];
    [pictureArea setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:pictureArea];
    [pictureArea release];

    
    pictureView = [[UIImageView alloc] init];
    [pictureView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pictureArea addSubview:pictureView];
    [pictureView release];
    
    
    //fix constraints
    [self addConstraints:[STPLayoutConstraintBuilder
                          insideLeftRightBorders:pictureArea inside:self padding:0]];
    [self addConstraint:[STPLayoutConstraintBuilder
                         fixTop:pictureArea toBottom:picturesStepper withConstant:gap]];
    [self addConstraint:[STPLayoutConstraintBuilder
                         fixBottom:pictureArea toTop:widthLabel withConstant:-gap]];
}

-(void)setupPicturesStepper {
    picturesStepper = [[UIStepper alloc] init];
    [picturesStepper setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:picturesStepper];
    [picturesStepper release];
    
    //add fix constraints
    [self addConstraints:[STPLayoutConstraintBuilder
                          insideTopLeftfor:picturesStepper inside:self padding:0]];
}

-(void)setupPictureTitle {
    pictureTitle = [[UILabel alloc] init];
    [pictureTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:pictureTitle];
    [pictureTitle release];
    
    //add fix constraints
    [self addConstraint:[STPLayoutConstraintBuilder
                         fixBottom:pictureTitle toTop:pictureArea withConstant:-gap]];
}

-(void)setupWidthSlider {
    widthSlider = [[UISlider alloc] init];
    [widthSlider setMinimumValue:minScale];
    [widthSlider setMaximumValue:maxScale];
    [widthSlider addTarget:self action:@selector(widthSliderChange) forControlEvents:UIControlEventValueChanged];
    [widthSlider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:widthSlider];
    [widthSlider release];
    
    //fix constraints
    [self addConstraint:[STPLayoutConstraintBuilder fixBottom:widthSlider toTop:heightLabel withConstant:-gap]];
    [self addConstraints:[STPLayoutConstraintBuilder insideLeftRightBorders:widthSlider inside:heightSlider padding:0]];
}

-(void)setupWidthLabel {
    widthLabel = [[UILabel alloc] init];
    [widthLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:widthLabel];
    [widthLabel release];
    
    //fix constraints
    [self addConstraint:[STPLayoutConstraintBuilder fixLeft:widthLabel toLeft:widthSlider withConstant:0]];
    [self addConstraint:[STPLayoutConstraintBuilder fixBottom:widthLabel toTop:widthSlider withConstant:-gap]];
}

-(void)setupHeightSlider {
    heightSlider = [[UISlider alloc] init];
    [heightSlider setMinimumValue:minScale];
    [heightSlider setMaximumValue:maxScale];
    [heightSlider addTarget:self action:@selector(heightSliderChange) forControlEvents:UIControlEventValueChanged];
    [heightSlider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:heightSlider];
    [heightSlider release];
    
    //fix constraints
    [self addConstraint:[STPLayoutConstraintBuilder fixBottom:heightSlider toBottom:self withConstant:0]];
    [self addConstraints:[STPLayoutConstraintBuilder insideLeftRightBorders:heightSlider inside:self padding:0]];
}

-(void)setupHeightLabel {
    heightLabel = [[UILabel alloc] init];
    [heightLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:heightLabel];
    [heightLabel release];
    
    //fix constraints
    [self addConstraint:[STPLayoutConstraintBuilder fixLeft:heightLabel toLeft:heightSlider withConstant:0]];
    [self addConstraint:[STPLayoutConstraintBuilder fixBottom:heightLabel toTop:heightSlider withConstant:-gap]];
}

/* ---- END Setup widgets ---- */



/* ---- Widgets flex constraints ---- */

-(void)pictureTitleConstraints {
    if(isIpad || isLandscape){
        [flexConstraints addObject:[STPLayoutConstraintBuilder
                                    fixCenterX:pictureTitle toCenterX:self withConstant:0]];
    } else {
        [flexConstraints addObject:[STPLayoutConstraintBuilder
                                    fixRight:pictureTitle toRight:self withConstant:0]];
    }
}

/* ---- END Widgets flex constraints ---- */


/* ---- update view ---- */
-(void) newPictureToDisplay:(UIImage *)image withTitle:(NSString *)title {
    currentImageSize = [image size];
    
    //set title
    [pictureTitle setText:title];
    
    //set image
    [pictureView setImage:image];
    [pictureView setFrame:CGRectMake(0, 0, currentImageSize.width, currentImageSize.height)];
    [self addConstraints:[STPLayoutConstraintBuilder
                          insideLeftRightBorders:pictureView inside:pictureArea padding:0]];
    [self addConstraint:[STPLayoutConstraintBuilder
                         fixTop:pictureView toTop:pictureArea withConstant:0]];
    [self addConstraint:[STPLayoutConstraintBuilder
                         fixBottom:pictureView toBottom:pictureArea withConstant:0]];
    float initialScale = (float)_maxInitialWidth / currentImageSize.width;
    [pictureArea setZoomScale:initialScale];
}

-(void)widthSliderChange {
    pictureScaleX = [widthSlider value];
    [self flexibleScalePicture];
}

-(void)heightSliderChange {
    pictureScaleY = [heightSlider value];
    [self flexibleScalePicture];
}

-(void)flexibleScalePicture {
    [pictureView setFrame:CGRectMake(0, 0, currentImageSize.width * pictureScaleX, currentImageSize.height * pictureScaleY)];
    [self displayInfos];
}

-(void)displayInfos {
    [widthSlider setValue:pictureScaleX animated:YES];
    [widthLabel setText:[NSString stringWithFormat:@"Largeur : %d %%", (int)(pictureScaleX * 100)]];
    [heightSlider setValue:pictureScaleY animated:YES];
    [heightLabel setText:[NSString stringWithFormat:@"Hauteur : %d %%", (int)(pictureScaleY * 100)]];
}

/* ---- END update view ---- */


/* ---- Scroll view delegate ---- */

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return pictureView;
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    pictureScaleX = pictureScaleY = [scrollView zoomScale];
    [self displayInfos];
}

/* ---- END Scroll view delegate ---- */



/* ---- drawing ---- */

-(void) drawForIpadDevice:(BOOL)ipadDevice inLandscape:(BOOL)landscapeDevice {
    
    isIpad = ipadDevice;
    isLandscape = landscapeDevice;
    
    [self removeConstraints:flexConstraints];
    [flexConstraints removeAllObjects];

    // add new constraints in flexConstraints
    [self pictureTitleConstraints];
    
    //apply Constraints
    [self addConstraints:flexConstraints];

}

-(void)dealloc {
    [pictureView release]; pictureView = nil;
    [picturesStepper release]; picturesStepper = nil;
    [pictureArea release]; pictureArea = nil;
    [pictureTitle release]; pictureTitle = nil;
    [widthSlider release]; widthSlider = nil;
    [heightSlider release]; heightSlider = nil;
    [widthLabel release]; widthLabel = nil;
    [heightLabel release]; heightLabel = nil;
    [flexConstraints release]; flexConstraints = nil;
    [super dealloc];
}

@end
