//
//  STPImageInfo.h
//  Imagier
//
//  Created by Nanook on 03/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STPImageInfo : NSObject

@property(assign) CGSize size;
@property(copy) NSString * name;
@property(assign) float scaleX;
@property(assign) float scaleY;

-(id) initWithName:(NSString *)imgName andSize:(CGSize)imgSize forMaxWidth:(int)maxWidth;
-(float)unifiedScale;
-(void)setUnifiedScale:(float)scale;
-(float)calculateWidth;
-(float)calculateHeight;

@end
