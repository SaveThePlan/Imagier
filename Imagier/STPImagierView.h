//
//  STPImagierView.h
//  Imagier
//
//  Created by Nanook on 26/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPImageInfo.h"

@interface STPImagierView : UIView <UIScrollViewDelegate>

-(void) drawForIpadDevice:(BOOL)isIpad inLandscape:(BOOL)isLandscape;
-(void) newPictureToDisplay:(UIImage *)image withSettings:(STPImageInfo *)imgSettings;

-(void)configStepperWithMin:(int)min andMax:(int)max andTarget:(id)target andAction:(SEL)action;
-(int)stepperValue;


@end
