//
//  BirdGameViewController.m
//  QuestionBank
//
//  Created by hanbo on 14-2-22.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "BirdGameViewController.h"
#import "Scene.h"
#import "Score.h"
@interface BirdGameViewController ()
@property (weak,nonatomic) IBOutlet SKView * gameView;
@property (weak,nonatomic) IBOutlet UILabel * bestScoreLabel;
@end

@implementation BirdGameViewController{
     Scene * scene;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Configure the view.
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.gameView.showsFPS = YES;
    self.gameView.showsNodeCount = YES;
    
    // Create and configure the scene.
    scene = [Scene sceneWithSize:self.gameView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.delegate = self;
    
    // Present the scene.
    [self.gameView presentScene:scene];
    self.bestScoreLabel.text = F(@"Best : %lu",(unsigned long)[Score bestScore]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Bouncing scene delegate

- (void)eventStart
{
    
}

- (void)eventPlay
{
    
}

- (void)eventWasted
{
    UIView * flash = [[UIView alloc] initWithFrame:self.view.frame];
    flash.backgroundColor = [UIColor whiteColor];
    flash.alpha = .8;
    [self.view.window addSubview:flash];
    [UIView animateWithDuration:.8 animations:^{
        flash.alpha = .0;
    } completion:^(BOOL finished) {
        [flash removeFromSuperview];
    }];
    self.bestScoreLabel.text = F(@"Best : %lu",[Score bestScore]);
}


@end
