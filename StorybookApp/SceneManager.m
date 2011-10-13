//
//  SceneManager.m
//  StorybookApp
//
//  Created by Muhammad Azeem on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SceneManager.h"
#import "Scene.h"
#include <QuartzCore/QuartzCore.h>

@implementation SceneManager

//@synthesize pScene, cScene, nScene;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"Scenes" ofType:@"plist"];
        NSDictionary* tempDict = [NSDictionary dictionaryWithContentsOfFile: path];
        plistDataArray = [[NSArray alloc] initWithArray: [tempDict valueForKey: @"Scenes"]];

        // TESTING
        currSceneIndex = 1;
        pScene = [[self getSceneAtIndex: currSceneIndex - 1] retain];
        cScene = [[self getSceneAtIndex: currSceneIndex] retain];
        nScene = [[self getSceneAtIndex: currSceneIndex + 1] retain];
        //[self changeToNextScene];
        //[self performSelector:@selector(changeToNextScene) withObject:nil afterDelay:3];
        //[self performSelector:@selector(changeToPrevScene) withObject:nil afterDelay:5];
        //cScene = [[Scene alloc] initWithFrame: CGRectMake(0, 0, 200, 200)];
        //[self.view addSubview: cScene];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton* prevButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	prevButton.frame = CGRectMake(20, 2, 40, 30);
	[prevButton addTarget:self action:@selector(prevButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.toolbar addSubview:prevButton];
	
	UIButton* nextButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	nextButton.frame = CGRectMake(420, 2, 40, 30);
	[nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.navigationController.toolbar addSubview:nextButton];
    
    self.navigationController.toolbarHidden = NO;
    // TESTING
    [self loadCScene];
    [self animateCScene];
}

- (void)nextButtonPressed: (UIButton*) btn
{
    [self changeToNextScene];
}

- (void)prevButtonPressed: (UIButton*) btn
{
    [self changeToPrevScene];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [cScene removeFromSuperview];
    [cScene release];
    [pScene release];
    [nScene release];
    [plistDataArray release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)changeToNextScene
{
    if (nScene != NULL)
    {
        currSceneIndex++;
        //[cScene unload];
        
        // *******
        // TESTING
        
        NSLog(@"RETAIN COUNT OF CSCENE: %i", [cScene retainCount]);
        Scene* temp = [cScene retain];
        [temp pause];
        [UIView animateWithDuration: 0.5 animations:^(void) {
            temp.frame = CGRectMake(0, 0, 200, 200);
        } completion:^(BOOL finished) {
            NSLog(@"RETAIN COUNT: %i", [temp retainCount]);
            [temp removeFromSuperview];
            [temp release];
            NSLog(@"RETAIN COUNT NOW: %i", [temp retainCount]);
        }];
        
        // *******
        //[cScene removeFromSuperview];
        [cScene release];
        
        if (pScene != NULL)
            [pScene release];
        pScene = [[self getSceneAtIndex: currSceneIndex - 1] retain];
        cScene = nScene;
        nScene = [[self getSceneAtIndex: currSceneIndex + 1] retain];
        
        [self loadCScene];
        
        // Animation for entry of the scene
        CGRect frame = cScene.frame;
        frame.origin.x += frame.size.width;
        cScene.frame = frame;
        frame.origin.x -= frame.size.width;
        [UIView beginAnimations: nil context: NULL];
        [UIView setAnimationDuration: 0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        cScene.frame = frame;
        
        [UIView commitAnimations];
        
        [self performSelector:@selector(animateCScene) withObject:nil afterDelay:0.5];
    }
}

- (void)changeToPrevScene
{
    if (pScene != NULL)
    {
        currSceneIndex--;
        //[cScene unload];
        [cScene removeFromSuperview];
        [cScene release];
        
        if (nScene != NULL)
            [nScene release];
        nScene = [[self getSceneAtIndex: currSceneIndex + 1] retain];
        cScene = pScene;
        pScene = [[self getSceneAtIndex: currSceneIndex - 1] retain];
        
        [self loadCScene];
        
        // Animation for entry of the scene
        CGRect frame = cScene.frame;
        frame.origin.x -= frame.size.width;
        cScene.frame = frame;
        frame.origin.x += frame.size.width;
        [UIView beginAnimations: nil context: NULL];
        [UIView setAnimationDuration: 0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        cScene.frame = frame;
        
        [UIView commitAnimations];
        
        [self performSelector:@selector(animateCScene) withObject:nil afterDelay:0.5];
    }
}

- (void)loadCScene
{
    [cScene load];
    [self.view addSubview:cScene];
}

- (void)animateCScene
{
    [cScene animate];
}

- (Scene*)getSceneAtIndex: (int) index;
{
    Scene* temp = nil;
    if (index >= 0 && index < [plistDataArray count])
        temp = [[[Scene alloc] initWithFrame:CGRectMake(0, 0, 480, 320) andDict: [plistDataArray objectAtIndex: index]] autorelease];
    
    return temp;
}

@end
