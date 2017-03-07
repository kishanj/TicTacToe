//
//  ViewController.m
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/3/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIImageView *settingsButton;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UILabel *commandLabel;
@property (strong, nonatomic) UILabel *player1ScoreLabel;
@property (strong, nonatomic) UILabel *player2ScoreLabel;

@property (strong, nonatomic) UIImageView *squareA1;
@property (strong, nonatomic) UIImageView *squareA2;
@property (strong, nonatomic) UIImageView *squareA3;
@property (strong, nonatomic) UIImageView *squareB1;
@property (strong, nonatomic) UIImageView *squareB2;
@property (strong, nonatomic) UIImageView *squareB3;
@property (strong, nonatomic) UIImageView *squareC1;
@property (strong, nonatomic) UIImageView *squareC2;
@property (strong, nonatomic) UIImageView *squareC3;

@property (strong, nonatomic) UIImage *XImage;
@property (strong, nonatomic) UIColor *XImageColor;
@property (strong, nonatomic) UIImage *OImage;
@property (strong, nonatomic) UIColor *OImageColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self drawGameLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawGameLayout {
    
    // Images
    [self loadImages];

    // Game geometry
    CGFloat screenWidth = [self view].frame.size.width;
    CGFloat screenHeight = [self view].frame.size.height;
    
    CGFloat numXSegments = 10;
    CGFloat numYSegments = 20;
    
    CGFloat marginPercentage = 5; // On each side
    CGFloat xMargin = screenWidth * marginPercentage / 100;
    CGFloat yMargin = screenHeight * marginPercentage / 100;
    
    CGFloat usableScreenWidth = screenWidth - (2 * xMargin);
    CGFloat usableScreenHeight = screenHeight - (2 * yMargin);
    
    CGFloat xSegment = usableScreenWidth / numXSegments;
    CGFloat ySegment = usableScreenHeight / numYSegments;
    
    CGPoint topLeftCorner = CGPointMake(xMargin, yMargin);
    CGPoint topRightCorner = CGPointMake(xMargin + usableScreenWidth, yMargin);
    
    // Settings
    CGFloat settingsYTop = topLeftCorner.y;
    CGFloat settingsHeight = ySegment;
    CGFloat settingsYBottom = settingsYTop + settingsHeight;
    [self loadSettingsButtonInFrame:CGRectMake(topRightCorner.x - xSegment,
                                               settingsYTop,
                                               xSegment,
                                               settingsHeight)];
    
    // Scoreboard
    CGFloat scoreboardYTop = settingsYBottom + ySegment;
    CGFloat scoreboardHeight = 2 * ySegment;
    CGFloat scoreboardYBottom = scoreboardYTop + scoreboardHeight;
    [self loadScoreboardInFrame:CGRectMake(topLeftCorner.x,
                                           scoreboardYTop,
                                           usableScreenWidth,
                                           scoreboardHeight)];
    
    // Commands
    CGFloat commandsYTop = scoreboardYBottom + ySegment;
    CGFloat commandsHeight = 2 * ySegment;
    CGFloat commandsYBottom = commandsYTop + commandsHeight;
    [self loadCommandsInFrame:CGRectMake(topLeftCorner.x,
                                         commandsYTop,
                                         usableScreenWidth,
                                         commandsHeight)];
    
    // Game Grid
    CGFloat gridWidth = usableScreenWidth - 4 * xSegment;
    CGFloat gridHeight = gridWidth;
    CGFloat gridXTop = screenWidth/2 - gridWidth/2;
    CGFloat gridYTop = commandsYBottom + 2 * ySegment;
    
    CGRect gridFrame = CGRectMake(gridXTop, gridYTop, gridWidth, gridHeight);
    [self loadGameGridInFrame:gridFrame];
    [self loadSquaresInGrid:gridFrame];
}

- (void)loadImages {
    _XImage = [UIImage imageNamed:@"Hearts"];
    _XImage = [_XImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _XImageColor = [UIColor blueColor];
    
    _OImage = [UIImage imageNamed:@"Diamonds"];
    _OImage = [_OImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _OImageColor = [UIColor redColor];
}

- (void)loadSettingsButtonInFrame:(CGRect)frame {
    _settingsButton = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [_settingsButton setImage:[UIImage imageNamed:@"Settings.png"]];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSettingsTap:)];
    tapGestureRecognizer.delegate = self;
    
    [_settingsButton setUserInteractionEnabled:YES];
    [_settingsButton addGestureRecognizer:tapGestureRecognizer];
    
    [self.view addSubview:_settingsButton];
}

- (void)handleSettingsTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        
    }
}

- (void)loadScoreboardInFrame:(CGRect)frame {
    CGSize playerObjectSize = CGSizeMake(frame.size.width/10, frame.size.height*4/10);
    
    
    CGSize scoreLabelSize = CGSizeMake(frame.size.width/3, frame.size.height*4/10);
    CGPoint scoreLabelCenter = CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height/2);
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreLabelCenter.x - scoreLabelSize.width/2,
                                                                    scoreLabelCenter.y - scoreLabelSize.height/2,
                                                                    scoreLabelSize.width,
                                                                    scoreLabelSize.height)];
    [scoreLabel setText:@"Score"];
    [scoreLabel setTextColor:[UIColor blackColor]];
    [scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:scoreLabel];
    
    CGPoint player1IconCenter = CGPointMake(frame.origin.x + frame.size.width/4, frame.origin.y + frame.size.height/4);
    UIImageView *player1Image = [[UIImageView alloc] initWithFrame:CGRectMake(player1IconCenter.x - playerObjectSize.width/2,
                                                                              player1IconCenter.y - playerObjectSize.height/2,
                                                                              playerObjectSize.width,
                                                                              playerObjectSize.height)];
    [player1Image setImage:_OImage];
    [player1Image setTintColor:_OImageColor];
    [self.view addSubview:player1Image];
    
    CGPoint player2IconCenter = CGPointMake(frame.origin.x + frame.size.width*3/4, frame.origin.y + frame.size.height/4);
    UIImageView *player2Image = [[UIImageView alloc] initWithFrame:CGRectMake(player2IconCenter.x - playerObjectSize.width/2,
                                                                              player2IconCenter.y - playerObjectSize.height/2,
                                                                              playerObjectSize.width,
                                                                              playerObjectSize.height)];
    [player2Image setImage:_XImage];
    [player2Image setTintColor:_XImageColor];
    [self.view addSubview:player2Image];
    
    CGPoint player1ScoreCenter = CGPointMake(player1IconCenter.x, player1IconCenter.y + frame.size.height/2);
    _player1ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(player1ScoreCenter.x - playerObjectSize.width/2,
                                                                     player1ScoreCenter.y - playerObjectSize.height/2,
                                                                     playerObjectSize.width,
                                                                     playerObjectSize.height)];
    [_player1ScoreLabel setText:@"1"];
    [_player1ScoreLabel setTextColor:[UIColor blackColor]];
    [_player1ScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_player1ScoreLabel];
    
    CGPoint player2ScoreCenter = CGPointMake(player2IconCenter.x, player2IconCenter.y + frame.size.height/2);
    _player2ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(player2ScoreCenter.x - playerObjectSize.width/2,
                                                                   player2ScoreCenter.y - playerObjectSize.height/2,
                                                                   playerObjectSize.width,
                                                                   playerObjectSize.height)];
    [_player2ScoreLabel setText:@"2"];
    [_player2ScoreLabel setTextColor:[UIColor blackColor]];
    [_player2ScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_player2ScoreLabel];
    
}

- (void)loadCommandsInFrame:(CGRect)frame {
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width/4, frame.size.height/2)];
    [_backButton setTitle:@"< Back" forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_backButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentCenter)];
    [_backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_backButton];
    
    
    _commandLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x,
                                                                    frame.origin.y + frame.size.height/2,
                                                                    frame.size.width,
                                                                    frame.size.height/2)];
    [_commandLabel setText:@"It's YOUR turn"];
    [_commandLabel setTextColor:[UIColor blackColor]];
    [_commandLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_commandLabel];
}

- (void)backButtonTapped:(id)sender {
    
}

- (void)loadGameGridInFrame:(CGRect)frame {
    UIView *verticalLine1 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width/3, frame.origin.y, 1, frame.size.height)];
    [self setLineProperties:verticalLine1];
    
    UIView *verticalLine2 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width*2/3, frame.origin.y, 1, frame.size.height)];
    [self setLineProperties:verticalLine2];
    
    UIView *horizontalLine1 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height/3, frame.size.width, 1)];
    [self setLineProperties:horizontalLine1];
    
    UIView *horizontalLine2 = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + frame.size.height*2/3, frame.size.width, 1)];
    [self setLineProperties:horizontalLine2];
}

- (void)setLineProperties:(UIView *)line {
    line.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line];
}

- (void)loadSquaresInGrid:(CGRect)grid {
    CGFloat imageToSquareRatio = 0.5;
    CGFloat imageSize = grid.size.width/3 * imageToSquareRatio;
    
    _squareA1 = [[UIImageView alloc] initWithFrame:CGRectMake(grid.origin.x + grid.size.width/6 - imageSize/2,
                                                              grid.origin.y + grid.size.height/6 - imageSize/2,
                                                              imageSize,
                                                              imageSize)];
    [self setImageProperties:_squareA1 withTag:0];
    
    _squareA2 = [[UIImageView alloc] initWithFrame:CGRectMake(grid.origin.x + grid.size.width/2 - imageSize/2,
                                                              grid.origin.y + grid.size.height/6 - imageSize/2,
                                                              imageSize,
                                                              imageSize)];
    [self setImageProperties:_squareA2 withTag:1];
    
    _squareA3 = [[UIImageView alloc] initWithFrame:CGRectMake(grid.origin.x + grid.size.width*5/6 - imageSize/2,
                                                              grid.origin.y + grid.size.height/6 - imageSize/2,
                                                              imageSize,
                                                              imageSize)];
    [self setImageProperties:_squareA3 withTag:2];
    
    _squareB1 = [[UIImageView alloc] initWithFrame:CGRectMake(grid.origin.x + grid.size.width/6 - imageSize/2,
                                                              grid.origin.y + grid.size.height/2 - imageSize/2,
                                                              imageSize,
                                                              imageSize)];
    [self setImageProperties:_squareB1 withTag:3];
    
    _squareB2 = [[UIImageView alloc] initWithFrame:CGRectMake(grid.origin.x + grid.size.width/2 - imageSize/2,
                                                              grid.origin.y + grid.size.height/2 - imageSize/2,
                                                              imageSize,
                                                              imageSize)];
    [self setImageProperties:_squareB2 withTag:4];
    
    _squareB3 = [[UIImageView alloc] initWithFrame:CGRectMake(grid.origin.x + grid.size.width*5/6 - imageSize/2,
                                                              grid.origin.y + grid.size.height/2 - imageSize/2,
                                                              imageSize,
                                                              imageSize)];
    [self setImageProperties:_squareB3 withTag:5];
    
    _squareC1 = [[UIImageView alloc] initWithFrame:CGRectMake(grid.origin.x + grid.size.width/6 - imageSize/2,
                                                              grid.origin.y + grid.size.height*5/6 - imageSize/2,
                                                              imageSize,
                                                              imageSize)];
    [self setImageProperties:_squareC1 withTag:6];
    
    _squareC2 = [[UIImageView alloc] initWithFrame:CGRectMake(grid.origin.x + grid.size.width/2 - imageSize/2,
                                                              grid.origin.y + grid.size.height*5/6 - imageSize/2,
                                                              imageSize,
                                                              imageSize)];
    [self setImageProperties:_squareC2 withTag:7];
    
    _squareC3 = [[UIImageView alloc] initWithFrame:CGRectMake(grid.origin.x + grid.size.width*5/6 - imageSize/2,
                                                              grid.origin.y + grid.size.height*5/6 - imageSize/2,
                                                              imageSize,
                                                              imageSize)];
    [self setImageProperties:_squareC3 withTag:8];
}

- (void)setImageProperties:(UIImageView *)square withTag:(NSInteger)tag {
    [square setImage:_OImage];
    [square setTintColor:_OImageColor];
    [self.view addSubview:square];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGridSquareTap:)];
    tapGestureRecognizer.delegate = self;
    
    [square setUserInteractionEnabled:YES];
    [square addGestureRecognizer:tapGestureRecognizer];
    
    [square setTag:tag];
}

- (void)handleGridSquareTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        
    }
}

@end
