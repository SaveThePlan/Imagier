//
//  STPImagierView.h
//  Imagier
//
//  Created by Nanook on 26/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPImagierView : UIView <UIScrollViewDelegate>

@property(nonatomic) int maxInitialWidth;

-(void) drawForIpadDevice:(BOOL)isIpad inLandscape:(BOOL)isLandscape;
-(void) newPictureToDisplay:(UIImage *)image withTitle:(NSString *)title;

-(void)configStepperWithMin:(int)min andMax:(int)max andTarget:(id)target andAction:(SEL)action;
-(int)stepperValue;


@end
