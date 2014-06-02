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

@interface STPViewController () {
    STPImagierView * mainView;
    BOOL isLandscape;
    BOOL isIpad;
    int margin;
    
    NSArray * imageNames;
}

@end

@implementation STPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //init vars
    imageNames = [[NSArray arrayWithObjects:
                   @"photo-01.jpg", @"photo-02.jpg", @"photo-03.jpg", @"photo-04.jpg",
                   @"photo-05.jpg", @"photo-06.jpg", @"photo-07.jpg", @"photo-08.jpg",
                   @"photo-09.jpg", @"photo-10.jpg", @"photo-11.jpg", @"photo-12.jpg",
                   @"photo-13.jpg", @"photo-14.jpg", @"photo-15.jpg", @"photo-16.jpg",
                   @"photo-17.jpg", @"photo-18.jpg", @"photo-19.jpg", @"photo-20.jpg",
                  nil] retain];
    
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
//    [self sendPictureToView:[imageNames objectAtIndex:0]];
    [self stepperAction];

}

/* ---- ACTIONS ---- */

-(void)sendPictureToView:(NSString *)imageName {
    UIImage * image = [[UIImage imageNamed:imageName] retain];
    [mainView newPictureToDisplay:image withTitle:imageName];
    [image release];
    image = nil;
}

-(void)stepperAction {
    [self sendPictureToView:[imageNames objectAtIndex:[mainView stepperValue]]];
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
        [mainView setMaxInitialWidth:(screenBounds.size.height - 2 * margin)];
    } else {
        [[self view] setFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
        [mainView setMaxInitialWidth:(screenBounds.size.width - 2 * margin)];
    }

    
    [mainView drawForIpadDevice:isIpad inLandscape:isLandscape];
    [self stepperAction];
}


-(void)dealloc {
    [mainView release];mainView = nil;
    [imageNames release]; imageNames = nil;
    [super dealloc];
}


@end
