//
//  Scene.m
//  StorybookApp
//
//  Created by Muhammad Azeem on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Scene.h"
#import <QuartzCore/QuartzCore.h>
#import "Animation.h"
#import "PathAnimation.h"

@implementation Scene

@synthesize characters;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //Character* chr = [[Character alloc] initWithImage: [UIImage imageNamed: @"spidey.png"]];
        //chr.userInteractionEnabled = FALSE;
        //Animation* anim = [[Animation alloc] initWithKey:@"transform.scale" beginTime:2 duration:2 value:[NSNumber numberWithInt:2]];
        //[anim animate: chr];
        //[self addSubview: chr];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andDict:(NSDictionary*)dict
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Get Background Image
        backgroundImageName = [dict valueForKey:@"Background Image"];
        
        // Allocate characters array
        characters = [[NSMutableArray alloc] init];
        
        NSArray* chrArray = [dict valueForKey:@"Characters"];
        for (NSDictionary* chr in chrArray)
        {
            Character* character = [[Character alloc] initWithImageName:[chr valueForKey:@"ImageSource"] andFrame: CGRectFromString([chr valueForKey:@"Frame"])];
            
            NSArray* fadeArray = [[chr valueForKey:@"Animations"] valueForKey:@"FadeEffects"];
            NSArray* zoomArray = [[chr valueForKey:@"Animations"] valueForKey:@"ZoomEffects"];
            NSArray* pathsArray = [chr valueForKey:@"Paths"];
            
            // Get values from Fade Array
            for (NSDictionary* fade in fadeArray)
            {
                float bTime = [[fade valueForKey:@"StartTime"] floatValue];
                float duration = [[fade valueForKey:@"Duration"] floatValue];
                int value = [[fade valueForKey:@"Value"] intValue];
                
                // Create temporary Animation object
                Animation* anim = [[Animation alloc] initWithKey:@"opacity" beginTime:bTime duration:duration value: [NSNumber numberWithInt:value]];
                [character.animations addObject: anim];
                
                // Release temporary Animation object
                [anim release];
            }
            
            // Get values from Zoom Array
            for (NSDictionary* zoom in zoomArray)
            {
                float bTime = [[zoom valueForKey:@"StartTime"] floatValue];
                float duration = [[zoom valueForKey:@"Duration"] floatValue];
                int value = [[zoom valueForKey:@"Value"] intValue];
                
                // Create temporary Animation object
                Animation* anim = [[Animation alloc] initWithKey:@"transform.scale" beginTime:bTime duration:duration value: [NSNumber numberWithInt:value]];
                [character.animations addObject: anim];
                
                // Release temporary Animation object
                [anim release];
            }
            
            // Get values from Path Array
            for (NSDictionary* path in pathsArray)
            {
                float bTime = [[path valueForKey:@"StartTime"] floatValue];
                float duration = [[path valueForKey:@"Duration"] floatValue];
                
                NSArray* value = [path valueForKey:@"Points"];
                
                // Create temporary Animation object
                PathAnimation* anim = [[PathAnimation alloc] initWithKey:@"position" beginTime:bTime duration:duration value: value];
                [character.animations addObject: anim];
                
                // Release temporary Animation Object
                [anim release];
            }
            
            [characters addObject: character];
            [character release];
        }
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
    self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: backgroundImageName]];
    for (Character* chr in characters)
    {
        [chr load];
        [self addSubview: chr];
    }
}

- (void)animate
{
    for (Character* chr in characters)
        [chr animate];
}

- (void)unload
{
    for (Character* chr in characters)
    {
        [chr unload];
    }
    [characters release];
}

- (void)resume
{
    if (self.layer.speed == 0.0)
    {
        CFTimeInterval TimeAtPause =[self.layer timeOffset];
    
        self.layer.speed = 1.0;
    
        self.layer.timeOffset = 0.0;
        self.layer.beginTime = 0.0;
        CFTimeInterval timeSincePause =[self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - TimeAtPause;
    
        self.layer.beginTime = timeSincePause;
    }
}

- (void)pause
{
    if (self.layer.speed != 0.0)
    {
        CFTimeInterval TimeAtPause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        
        self.layer.speed = 0.0;
        
        self.layer.timeOffset = TimeAtPause;
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CFTimeInterval TimeAtPause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    self.layer.speed = 0.0;
    
    self.layer.timeOffset = TimeAtPause;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CFTimeInterval TimeAtPause =[self.layer timeOffset];
    
    self.layer.speed = 1.0;
    
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause =[self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - TimeAtPause;
    
    self.layer.beginTime = timeSincePause;
}

- (void)dealloc
{
    [self unload];
    [super dealloc];
}

@end
