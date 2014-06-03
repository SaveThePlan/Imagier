//
//  STPViewController.m
//  Imagier
//
//  Created by Nanook on 26/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPViewController.h"
#import "STPImagierView.h"
#import "STPLayoutConstraintBuilder.h"
#import "STPImageInfo.h"

@interface STPViewController () {
    STPImagierView * mainView;
    BOOL isLandscape;
    BOOL isIpad;
    int margin;
    int maxWidth;
    
    NSArray * imageNames;
    NSMutableDictionary * activeImages;
}

@end

@implementation STPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //init vars
    imageNames = [[NSArray arrayWithObjects:
                   @"photo-01", @"photo-02", @"photo-03", @"photo-04",
                   @"photo-05", @"photo-06", @"photo-07", @"photo-08",
                   @"photo-09", @"photo-10", @"photo-11", @"photo-12",
                   @"photo-13", @"photo-14", @"photo-15", @"photo-16",
                   @"photo-17", @"photo-18", @"photo-19", @"photo-20",
                   nil] retain];
    activeImages = [[NSMutableDictionary alloc]init];
    
    //init view
    isIpad = ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad );
    
    margin = (isIpad)? 40 : 20;
    margin = (margin > [self.topLayoutGuide length])? margin : [self.topLayoutGuide length];
    
    mainView = [[STPImagierView alloc] init];
    [mainView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [mainView configStepperWithMin:0 andMax:([imageNames count] - 1) andTarget:self andAction:@selector(stepperAction)];
    [[self view] addSubview:mainView];
    [mainView release];
    
    [self loadBackground];
    
    [[self view] addConstraints:[STPLayoutConstraintBuilder
                                 insideWithPaddingFor:mainView inside:[self view] padding:margin]];
    
    [self willRotateToInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]
                                  duration:[[UIApplication sharedApplication] statusBarOrientationAnimationDuration]];
    
    //init first image
    [self stepperAction];

}

/* ---- ACTIONS ---- */

-(void)stepperAction {
    NSString * imageName = [imageNames objectAtIndex:[mainView stepperValue]];
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage * image = [[UIImage imageWithContentsOfFile:filePath] retain];
    
    STPImageInfo * imgSettings = [activeImages objectForKey:imageName];
    if(imgSettings == nil) {
        imgSettings = [[STPImageInfo alloc] initWithName:imageName andSize:[image size] forMaxWidth:maxWidth];
        [activeImages setObject: imgSettings forKey:imageName];
    }
    
    [mainView newPictureToDisplay:image withSettings:imgSettings];
    [image release];
    image = nil;
}

/* ----END ACTIONS ---- */

-(void)loadBackground {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;

    UIImage * background;
    
    if(screenSize.width > 568 || screenSize.height > 568) {
        background = [UIImage imageNamed:@"fond-2048x2048.jpg"];
    } else if(screenSize.width > 480 || screenSize.height > 480) {
        background = [UIImage imageNamed:@"fond-1136x1136.jpg"];
    } else {
        background = [UIImage imageNamed:@"fond-1024x1024.jpg"];
    }

    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:background]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//orientation
-(BOOL)shouldAutorotate{
    return YES;
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    isLandscape = (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft
                   || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if(isLandscape){
        [[self view] setFrame:CGRectMake(0, 0, screenBounds.size.height, screenBounds.size.width)];
        maxWidth = screenBounds.size.height - 2 * margin;
//        [mainView setMaxInitialWidth:(screenBounds.size.height - 2 * margin)];
    } else {
        [[self view] setFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
        maxWidth = screenBounds.size.width - 2 * margin;
//        [mainView setMaxInitialWidth:(screenBounds.size.width - 2 * margin)];
    }
    
    [mainView drawForIpadDevice:isIpad inLandscape:isLandscape];
    [self stepperAction];
}


-(void)dealloc {
    [activeImages release]; activeImages = nil;
    [mainView release];mainView = nil;
    [imageNames release]; imageNames = nil;
    [super dealloc];
}


@end
