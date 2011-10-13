//
//  Character.m
//  StorybookApp
//
//  Created by Muhammad Azeem on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "PathAnimation.h"
#import <Foundation/Foundation.h>

@implementation Character

@synthesize animations;

- (id)initWithFrame:(CGRect)tFrame
{
    self = [super initWithFrame:tFrame];
    if (self)
    {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (id) initWithImageName:(NSString*) imgName andFrame: (CGRect)tFrame
{
    self = [super init];
    if (self)
    {
        imageName = [imgName copy];
        frame = tFrame;
        animations = [[NSMutableArray alloc] init];
        self.userInteractionEnabled = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)load
{
    self.image = [UIImage imageNamed: imageName];
    self.frame = frame;
}

- (void)animate
{
    for (Animation* anim in animations)
        [anim animate: self];
}

- (void)unload
{
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
    self.frame = CGRectZero;
    //[super dealloc];
}

- (void)dealloc
{
    [animations release];
    [super dealloc];
}

@end
