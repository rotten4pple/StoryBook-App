//
//  Scene.h
//  StorybookApp
//
//  Created by Muhammad Azeem on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface Scene : UIView
{
    NSMutableArray* characters;
    NSString* backgroundImageName;
}

@property (nonatomic, retain) NSMutableArray* characters;

- (id)initWithFrame:(CGRect)frame andDict:(NSDictionary*)dict;

- (void)load;
- (void)animate;
- (void)unload;

- (void)resume;
- (void)pause;

- (void)dealloc;

@end