//
//  CGContext+Extend.m
//  micker
//
//  Created by allen.wang on 7/31/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "CGContext+Extend.h"

void CGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius) {
	CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);
}
void CGContextAddRoundedRectComplex(CGContextRef context, CGRect rect, const CGFloat radiuses[]) {
	CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radiuses[0]);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radiuses[1]);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radiuses[2]);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radiuses[3]);
	CGContextClosePath(context);
}
