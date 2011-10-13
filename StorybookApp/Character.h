//
//  Character.h
//  StorybookApp
//
//  Created by Muhammad Azeem on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface Character : UIImageView
{
    NSString* imageName;
    CGRect frame;
}

@property (nonatomic, retain) NSMutableArray* animations;

- (id) initWithImageName:(NSString*) imgName andFrame: (CGRect)tFrame; 

- (void)load;
- (void)animate;
- (void)unload;

- (void)dealloc;
@end
