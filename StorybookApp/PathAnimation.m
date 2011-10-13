//
//  PathAnimation.m
//  StorybookApp
//
//  Created by Muhammad Azeem on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PathAnimation.h"

@implementation PathAnimation

- (void)animate:(UIImageView *)imageView
{
    // Create Path from points
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, imageView.center.x, imageView.center.y);
    
    for (NSString* point in value)
        CGPathAddLineToPoint(path, NULL, CGPointFromString(point).x, CGPointFromString(point).y);
    
    layer = imageView.layer;

    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath: key];
    
    animation.beginTime = CACurrentMediaTime() + beginTime;
    animation.duration = duration;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    animation.path = path;
    
    [layer addAnimation: animation forKey: key];
    // Free path and animation
    CGPathRelease(path);
}

- (void)animationDidStop:(CAKeyframeAnimation *)anim finished:(BOOL)flag
{
    // Check whether animation stopped because of completion or is it precompletion stop
    if (flag == FALSE)
        return;
    NSValue* val = [NSValue valueWithCGPoint: CGPointFromString([value lastObject])];
    [layer setValue: val forKeyPath: [anim keyPath]];
    [layer removeAnimationForKey: [anim keyPath]];
}

@end
