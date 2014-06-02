//
//  STPLayoutConstraintBuilder.m
//  DizainierGeek
//
//  Created by Nanook on 19/05/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPLayoutConstraintBuilder.h"

@implementation STPLayoutConstraintBuilder

//VERTICAL
+(id)fixTop:(UIView*)view1 toTop:(UIView*)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeTop
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeTop
                          multiplier:1 constant:cst];
}

+(id)fixTop:(UIView*)view1 toBottom:(UIView*)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeTop
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeBottom
                          multiplier:1 constant:cst];
}

+(id)fixBottom:(UIView*)view1 toTop:(UIView*)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeBottom
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeTop
                          multiplier:1 constant:cst];
}

+(id)fixBottom:(UIView*)view1 toBottom:(UIView*)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeBottom
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeBottom
                          multiplier:1 constant:cst];
}

+(id)fixCenterY:(UIView *)view1 toCenterY:(UIView *)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeCenterY
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeCenterY
                          multiplier:1 constant:cst];
}


//HORIZONTAL
+(id)fixLeft:(UIView*)view1 toLeft:(UIView*)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeLeft
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeLeft
                          multiplier:1 constant:cst];
}

+(id)fixLeft:(UIView*)view1 toRight:(UIView*)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeLeft
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeRight
                          multiplier:1 constant:cst];
}

+(id)fixRight:(UIView*)view1 toLeft:(UIView*)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeRight
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeLeft
                          multiplier:1 constant:cst];
}

+(id)fixRight:(UIView*)view1 toRight:(UIView*)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeRight
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeRight
                          multiplier:1 constant:cst];
}

+(id)fixCenterX:(UIView *)view1 toCenterX:(UIView *)view2 withConstant:(int)cst {
    return [super constraintWithItem:view1 attribute:NSLayoutAttributeCenterX
                           relatedBy:NSLayoutRelationEqual
                              toItem:view2 attribute:NSLayoutAttributeCenterX
                          multiplier:1 constant:0];
}


//FAST INSIDE
+(NSArray *)insideTopLeftfor:(UIView *)view1 inside:(UIView *)view2 padding:(int)padding {
    return [NSArray arrayWithObjects:
            [self fixTop:view1 toTop:view2 withConstant:padding],
            [self fixLeft:view1 toLeft:view2 withConstant:padding],
            nil];
}

+(NSArray *)insideTopCenterfor:(UIView *)view1 inside:(UIView *)view2 paddingTop:(int)padding {
    return [NSArray arrayWithObjects:
            [self fixTop:view1 toTop:view2 withConstant:padding],
            [self fixCenterX:view1 toCenterX:view2 withConstant:0],
            nil];
}

+(NSArray *)insideTopRightfor:(UIView *)view1 inside:(UIView *)view2 padding:(int)padding {
    return [NSArray arrayWithObjects:
            [self fixTop:view1 toTop:view2 withConstant:padding],
            [self fixRight:view1 toRight:view2 withConstant:-padding],
            nil];
}

+(NSArray *)insideCenterLeftfor:(UIView *)view1 inside:(UIView *)view2 paddingLeft:(int)padding {
    return [NSArray arrayWithObjects:
            [self fixCenterY:view1 toCenterY:view2 withConstant:0],
            [self fixLeft:view1 toLeft:view2 withConstant:padding],
            nil];
}

+(NSArray *)insideCenterCenterfor:(UIView *)view1 inside:(UIView *)view2 {
    return [NSArray arrayWithObjects:
            [self fixCenterY:view1 toCenterY:view2 withConstant:0],
            [self fixCenterX:view1 toCenterX:view2 withConstant:0],
            nil];
}

+(NSArray *)insideCenterRightfor:(UIView *)view1 inside:(UIView *)view2 paddingRight:(int)padding {
    return [NSArray arrayWithObjects:
            [self fixCenterY:view1 toCenterY:view2 withConstant:0],
            [self fixRight:view1 toRight:view1 withConstant:-padding],
            nil];
}

+(NSArray *)insideBottomLeftfor:(UIView *)view1 inside:(UIView *)view2 padding:(int)padding {
    return [NSArray arrayWithObjects:
            [self fixBottom:view1 toBottom:view2 withConstant:-padding],
            [self fixLeft:view1 toLeft:view2 withConstant:padding],
            nil];
}

+(NSArray *)insideBottomCenterfor:(UIView *)view1 inside:(UIView *)view2 paddingBottom:(int)padding {
    return [NSArray arrayWithObjects:
            [self fixBottom:view1 toBottom:view2 withConstant:-padding],
            [self fixCenterX:view1 toCenterX:view2 withConstant:0],
            nil];
}

+(NSArray *)insideBottomRightfor:(UIView *)view1 inside:(UIView *)view2 padding:(int)padding {
    return [NSArray arrayWithObjects:
            [self fixBottom:view1 toBottom:view2 withConstant:-padding],
            [self fixRight:view1 toRight:view2 withConstant:-padding],
            nil];
}

+(NSArray *)insideLeftRightBorders:(UIView *)view1 inside:(UIView *)view2 padding:(int)padding{
    return [NSArray arrayWithObjects:
            [self fixLeft:view1 toLeft:view2 withConstant:padding],
            [self fixRight:view1 toRight:view2 withConstant:-padding],
            nil];
}

+(NSArray *)insideWithPaddingFor:(UIView *)view1 inside:(UIView *)view2 padding:(int)padding {
    return [NSArray arrayWithObjects:
            [self fixLeft:view1 toLeft:view2 withConstant:padding],
            [self fixRight:view1 toRight:view2 withConstant:-padding],
            [self fixTop:view1 toTop:view2 withConstant:padding],
            [self fixBottom:view1 toBottom:view2 withConstant:-padding],
            nil];
}


@end
