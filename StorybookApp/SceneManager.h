//
//  SceneManager.h
//  StorybookApp
//
//  Created by Muhammad Azeem on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Scene.h"

@interface SceneManager : UIViewController
{    
    int currSceneIndex;
    Scene* pScene;
    Scene* cScene;
    Scene* nScene;
    
    NSArray* plistDataArray;
}
/*@property (nonatomic, retain) Scene* pScene;
@property (nonatomic, retain) Scene* cScene;
@property (nonatomic, retain) Scene* nScene;*/

- (void)loadCScene;
- (void)animateCScene;

- (void)changeToNextScene;
- (void)changeToPrevScene;

- (Scene*)getSceneAtIndex: (int) index;

- (void)nextButtonPressed: (UIButton*) btn;
- (void)prevButtonPressed: (UIButton*) btn;

- (void)dealloc;

@end
