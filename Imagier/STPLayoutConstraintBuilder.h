//
//  STPLayoutConstraintBuilder.h
//  DizainierGeek
//
//  Created by Nanook on 19/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPLayoutConstraintBuilder : NSLayoutConstraint

//vertical
+(id)fixTop:(UIView*)view1 toTop:(UIView*)view2 withConstant:(int)cst;
+(id)fixTop:(UIView*)view1 toBottom:(UIView*)view2 withConstant:(int)cst;
+(id)fixBottom:(UIView*)view1 toTop:(UIView*)view2 withConstant:(int)cst;
+(id)fixBottom:(UIView*)view1 toBottom:(UIView*)view2 withConstant:(int)cst;
+(id)fixCenterY:(UIView*)view1 toCenterY:(UIView*)view2 withConstant:(int)cst;

//horizontal
+(id)fixLeft:(UIView*)view1 toLeft:(UIView*)view2 withConstant:(int)cst;
+(id)fixLeft:(UIView*)view1 toRight:(UIView*)view2 withConstant:(int)cst;
+(id)fixRight:(UIView*)view1 toLeft:(UIView*)view2 withConstant:(int)cst;
+(id)fixRight:(UIView*)view1 toRight:(UIView*)view2 withConstant:(int)cst;
+(id)fixCenterX:(UIView*)view1 toCenterX:(UIView*)view2 withConstant:(int)cst;


//fast inside
+(NSArray*)insideTopLeftfor:(UIView*)view1 inside:(UIView*)view2 padding:(int)padding;
+(NSArray*)insideTopCenterfor:(UIView*)view1 inside:(UIView*)view2 paddingTop:(int)padding;
+(NSArray*)insideTopRightfor:(UIView*)view1 inside:(UIView*)view2 padding:(int)padding;
+(NSArray*)insideCenterLeftfor:(UIView*)view1 inside:(UIView*)view2 paddingLeft:(int)padding;
+(NSArray*)insideCenterCenterfor:(UIView*)view1 inside:(UIView*)view2;
+(NSArray*)insideCenterRightfor:(UIView*)view1 inside:(UIView*)view2 paddingRight:(int)padding;
+(NSArray*)insideBottomLeftfor:(UIView*)view1 inside:(UIView*)view2 padding:(int)padding;
+(NSArray*)insideBottomCenterfor:(UIView*)view1 inside:(UIView*)view2 paddingBottom:(int)padding;
+(NSArray*)insideBottomRightfor:(UIView*)view1 inside:(UIView*)view2 padding:(int)padding;
+(NSArray*)insideLeftRightBorders:(UIView*)view1 inside:(UIView*)view2 padding:(int)padding;
+(NSArray*)insideWithPaddingFor:(UIView*)view1 inside:(UIView*)view2 padding:(int)padding;


@end
