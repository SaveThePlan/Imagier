//
//  STPImageInfo.m
//  Imagier
//
//  Created by Nanook on 03/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPImageInfo.h"

@implementation STPImageInfo

-(id) initWithName:(NSString *)imgName andSize:(CGSize)imgSize forMaxWidth:(int)maxWidth {
    self = [super init];
    if(self) {
        _name = [imgName copy];
        _size = imgSize;
        _scaleX = _scaleY = (float)maxWidth / _size.width;
    }
    return self;
}

-(float)unifiedScale {
    return (_scaleX > _scaleY)? _scaleX : _scaleY;
}

-(void)setUnifiedScale:(float)scale {
    _scaleX = _scaleY = scale;
}

/*
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
 float initialScale = 1.0f;//(float)_maxInitialWidth / currentImageSize.width;
 [pictureArea setZoomScale:initialScale];
 */

-(float)calculateWidth {
    return _size.width * _scaleX;
}

-(float)calculateHeight {
    return _size.height * _scaleY;
}

-(void)dealloc {
    [_name release]; _name = nil;
    [super dealloc];
}

@end
