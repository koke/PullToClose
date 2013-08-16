//
//  PullToCloseProgressView.m
//  PullToClose
//
//  Created by Jorge Bernal on 8/16/13.
//  Copyright (c) 2013 Jorge Bernal. All rights reserved.
//

#import "PullToCloseProgressView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

@implementation PullToCloseProgressView {
    CAShapeLayer *_outerCircleLayer;
    CAShapeLayer *_innerCircleLayer;
    CATextLayer *_xLayer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayers];
    }
    return self;
}

- (void)setupLayers
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPathRef path = CGPathCreateWithEllipseInRect(self.bounds, NULL);
    _outerCircleLayer = [CAShapeLayer layer];
    _outerCircleLayer.path = path;
    _outerCircleLayer.position = center;
    _outerCircleLayer.fillColor = [[UIColor darkGrayColor] CGColor];
    [self.layer addSublayer:_outerCircleLayer];
    _outerCircleLayer.bounds = self.bounds;
    _innerCircleLayer = [CAShapeLayer layer];
    _innerCircleLayer.path = path;
    _innerCircleLayer.fillColor = [[UIColor lightGrayColor] CGColor];
    _innerCircleLayer.bounds = self.bounds;
    _innerCircleLayer.position = center;
    [self.layer addSublayer:_innerCircleLayer];
    _xLayer = [CATextLayer layer];
    _xLayer.string = @"x";
    _xLayer.bounds = self.bounds;
    _xLayer.fontSize = self.bounds.size.height - 4.f;
    _xLayer.font = CTFontCreateWithName(CFSTR("Helvetica-Bold"), _xLayer.fontSize, NULL);
    _xLayer.position = center;
    _xLayer.foregroundColor = [[UIColor darkGrayColor] CGColor];
    _xLayer.alignmentMode = kCAAlignmentCenter;
    _xLayer.shouldRasterize = NO;
    _xLayer.contentsScale = [[UIScreen mainScreen] scale];
    [self.layer addSublayer:_xLayer];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    CGFloat scale = 0.75f * _progress;
    NSLog(@"layout sublayers, scale %f", scale);
    _innerCircleLayer.transform = CATransform3DMakeScale(scale, scale, 1.f);
    _xLayer.hidden = _progress < 1.f;
}

- (void)setProgress:(CGFloat)progress
{
    NSLog(@"progress: %f", progress);
    _progress = MIN(1.f, MAX(0.f, progress));
    NSLog(@"progress: %f", _progress);
    [self setNeedsLayout];
}

@end
