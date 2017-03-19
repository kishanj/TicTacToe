//
//  GameViewController.m
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/3/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import "GameViewController.h"
#import "Game.h"

@interface GameViewController ()

@property (strong, nonatomic) UIImageView *settingsButton;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *nextGameButton;
@property (strong, nonatomic) UILabel *commandLabel;
@property (strong, nonatomic) UILabel *player1ScoreLabel;
@property (strong, nonatomic) UILabel *player2ScoreLabel;

@property (strong, nonatomic) NSMutableArray *tiles;
@property (strong, nonatomic, nullable) Player *turn;
@property BOOL editableBoard;

@property (strong, nonatomic) UIImage *player1Image;
@property (strong, nonatomic) UIColor *player1Color;
@property (strong, nonatomic) UIImage *player2Image;
@property (strong, nonatomic) UIColor *player2Color;

@end

@implementation GameViewController

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
    CGFloat commandsHeight = 3 * ySegment;
    CGFloat commandsYBottom = commandsYTop + commandsHeight;
    [self loadCommandsInFrame:CGRectMake(topLeftCorner.x,
                                         commandsYTop,
                                         usableScreenWidth,
                                         commandsHeight)];
    
    // Game Board
    CGFloat boardWidth = usableScreenWidth - 4 * xSegment;
    CGFloat boardHeight = boardWidth;
    CGFloat boardXTop = screenWidth/2 - boardWidth/2;
    CGFloat boardYTop = commandsYBottom + 2 * ySegment;
    
    CGRect boardFrame = CGRectMake(boardXTop, boardYTop, boardWidth, boardHeight);
    [self loadGameBoardInFrame:boardFrame];
    [self loadTilesInBoard:boardFrame];
}

- (void)loadImages {
    Player *player1 = [_game player1];
    _player1Image = [player1 image];
    _player1Color = [player1 color];
    
    Player *player2 = [_game player2];
    _player2Image = [player2 image];
    _player2Color = [player2 color];
}

- (void)loadSettingsButtonInFrame:(CGRect)frame {
    _settingsButton = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [_settingsButton setImage:[UIImage imageNamed:@"Settings.png"]];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingsDidTap:)];
    tapGestureRecognizer.delegate = self;
    
    [_settingsButton setUserInteractionEnabled:YES];
    [_settingsButton addGestureRecognizer:tapGestureRecognizer];
    
    [self.view addSubview:_settingsButton];
}

- (void)settingsDidTap:(UITapGestureRecognizer *)sender
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
    UIImageView *player1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(player1IconCenter.x - playerObjectSize.width/2,
                                                                              player1IconCenter.y - playerObjectSize.height/2,
                                                                              playerObjectSize.width,
                                                                              playerObjectSize.height)];
    [player1ImageView setImage:_player1Image];
    [player1ImageView setTintColor:_player1Color];
    [self.view addSubview:player1ImageView];
    
    CGPoint player2IconCenter = CGPointMake(frame.origin.x + frame.size.width*3/4, frame.origin.y + frame.size.height/4);
    UIImageView *player2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(player2IconCenter.x - playerObjectSize.width/2,
                                                                              player2IconCenter.y - playerObjectSize.height/2,
                                                                              playerObjectSize.width,
                                                                              playerObjectSize.height)];
    [player2ImageView setImage:_player2Image];
    [player2ImageView setTintColor:_player2Color];
    [self.view addSubview:player2ImageView];
    
    CGPoint player1ScoreCenter = CGPointMake(player1IconCenter.x, player1IconCenter.y + frame.size.height/2);
    _player1ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(player1ScoreCenter.x - playerObjectSize.width/2,
                                                                     player1ScoreCenter.y - playerObjectSize.height/2,
                                                                     playerObjectSize.width,
                                                                     playerObjectSize.height)];
    [_player1ScoreLabel setText:@"0"];
    [_player1ScoreLabel setTextColor:[UIColor blackColor]];
    [_player1ScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_player1ScoreLabel];
    
    CGPoint player2ScoreCenter = CGPointMake(player2IconCenter.x, player2IconCenter.y + frame.size.height/2);
    _player2ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(player2ScoreCenter.x - playerObjectSize.width/2,
                                                                   player2ScoreCenter.y - playerObjectSize.height/2,
                                                                   playerObjectSize.width,
                                                                   playerObjectSize.height)];
    [_player2ScoreLabel setText:@"0"];
    [_player2ScoreLabel setTextColor:[UIColor blackColor]];
    [_player2ScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_player2ScoreLabel];
    
}

- (void)loadCommandsInFrame:(CGRect)frame {
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x,
                                                             frame.origin.y,
                                                             frame.size.width/4,
                                                             frame.size.height/2)];
    [_backButton setTitle:@"< Back" forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_backButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
    [_backButton addTarget:self action:@selector(backButtonDidTap:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_backButton];
    
    _nextGameButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width/2,
                                                                 frame.origin.y,
                                                                 frame.size.width/2,
                                                                 frame.size.height/2)];
    [_nextGameButton setTitle:@"NewGame >" forState:UIControlStateNormal];
    [_nextGameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_nextGameButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_nextGameButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [_nextGameButton addTarget:self action:@selector(nextGameButtonDidTap:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_nextGameButton];
    
    
    _commandLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x,
                                                                    frame.origin.y + frame.size.height/2,
                                                                    frame.size.width,
                                                                    frame.size.height/2)];
    [_commandLabel setTextColor:[UIColor blackColor]];
    [_commandLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_commandLabel];
}

- (void)backButtonDidTap:(id)sender {
    [_game didPressBackButton];
}

- (void)nextGameButtonDidTap:(id)sender {
    [_game startNewGame];
}

- (void)loadGameBoardInFrame:(CGRect)frame {
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

- (void)loadTilesInBoard:(CGRect)board {
    
    const CGFloat imageToTileRatio = 0.5;
    CGFloat imageSize = board.size.width/3 * imageToTileRatio;

    const NSUInteger numTiles = [GameBoard tilesOnBoard];
    _tiles = [[NSMutableArray alloc] initWithCapacity:numTiles];
    
    for (NSInteger i=0; i<numTiles; i++) {
        
        NSUInteger row = i/3;
        NSUInteger column = i%3;
        
        CGFloat xPos = 0;
        CGFloat yPos = 0;
        
        switch (row) {
            case 0:
                yPos = board.origin.y + board.size.height/6 - imageSize/2;
                break;
                
            case 1:
                yPos = board.origin.y + board.size.height/2 - imageSize/2;
                break;
                
            case 2:
                yPos = board.origin.y + board.size.height*5/6 - imageSize/2;
                break;
        }

        switch (column) {
            case 0:
                xPos = board.origin.x + board.size.width/6 - imageSize/2;
                break;
                
            case 1:
                xPos = board.origin.x + board.size.width/2 - imageSize/2;
                break;
                
            case 2:
                xPos = board.origin.x + board.size.width*5/6 - imageSize/2;
                break;
        }
        
        _tiles[i] = [[UIImageView alloc] initWithFrame:CGRectMake(xPos,
                                                                  yPos,
                                                                  imageSize,
                                                                  imageSize)];
        [self setImageProperties:_tiles[i] withTag:i];
    }
}

- (void)setImageProperties:(UIImageView *)tile withTag:(NSInteger)tag {
    [self.view addSubview:tile];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(boardTileDidTap:)];
    tapGestureRecognizer.delegate = self;
    
    [tile setUserInteractionEnabled:YES];
    [tile addGestureRecognizer:tapGestureRecognizer];
    
    [tile setTag:tag];
}

- (void)boardTileDidTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded && _editableBoard)
    {
        [_game player:_turn didMove:[[sender view] tag]];
    }
}

#pragma mark - GameViewInterface implementation

- (void)resetGame {
    dispatch_async(dispatch_get_main_queue(), ^{
        _editableBoard = YES;
        for (NSInteger i=0; i<_tiles.count; i++) {
            UIImageView *tile = _tiles[i];
            [tile setImage:nil];
            [tile setUserInteractionEnabled:YES];
        }
    });
}

- (void)assignTile:(NSUInteger)tag toPlayer:(nullable Player *)player {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (tag < _tiles.count) {
            UIImageView *tile = _tiles[tag];
            [tile setImage:[player image]];
            [tile setTintColor:[player color]];
            [tile setUserInteractionEnabled:(player ? NO : YES)];
        }
    });
}

- (void)resetStats {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_player1ScoreLabel setText:0];
        [_player2ScoreLabel setText:0];
    });
}

- (void)assignTurn:(nullable Player *)player {
    dispatch_async(dispatch_get_main_queue(), ^{
        _editableBoard = ([player type] == PlayerTypeUser);
        _turn = player;
        [_commandLabel setText:[NSString stringWithFormat:@"It is %@'s turn", [player name]]];
    });
}

- (void)assignWinner:(nullable Player *)winner {
    dispatch_async(dispatch_get_main_queue(), ^{
        _editableBoard = NO;
        if (winner) {
            [_commandLabel setText:[NSString stringWithFormat:@"%@ WON!", [winner name]]];
            
        }
        else {
            [_commandLabel setText:[NSString stringWithFormat:@"It is a DRAW"]];
        }
    });
}

@end
