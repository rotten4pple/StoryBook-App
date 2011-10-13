//
//  Animation.h
//  StorybookApp
//
//  Created by Muhammad Azeem on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface Animation : NSObject
{
    CALayer* layer;
    
    float beginTime;
    float duration;
    
    id value;
    
    NSString* key;
}

- (id)initWithKey:(NSString*)k beginTime:(float)bTime duration:(float)drt value:(id)val;

- (void)animate : (UIImageView*) imageView;

- (void)dealloc;

@end
