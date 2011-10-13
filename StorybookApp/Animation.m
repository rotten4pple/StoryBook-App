//
//  Animation.m
//  StorybookApp
//
//  Created by Muhammad Azeem on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Animation.h"

@implementation Animation

- (id)initWithKey:(NSString*)k beginTime:(float)bTime duration:(float)drt value:(id)val;
{
    self = [super init];
    if (self)
    {
        key = k;
        beginTime = bTime;
        duration = drt;
        value = [val retain];
    }
    
    return self;
}

- (void)animate:(UIImageView *)imageView
{
    layer = imageView.layer;
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath: key];
    animation.beginTime = CACurrentMediaTime() + beginTime;
    animation.duration = duration;
    animation.delegate = self;
    
    [animation setToValue: value];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [layer addAnimation: animation forKey: key];
    // Release animation
    //[animation release];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    // Check whether animation stopped because of completion or is it precompletion stop
    if (flag == FALSE)
        return;
    [layer setValue: value forKeyPath: [anim keyPath]];
    [layer removeAnimationForKey: [anim keyPath]];
}

- (void)dealloc
{
    [value release];
    [super dealloc];
}

@end
