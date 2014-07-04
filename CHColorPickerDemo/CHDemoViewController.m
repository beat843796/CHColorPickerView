//
//  CHDemoViewController.m
//  CHColorPickerDemo
//
//  Created by Clemens Hammerl on 04.07.14.
//  Copyright (c) 2014 cocoabeats GmbH. All rights reserved.
//

#import "CHDemoViewController.h"
#import "CHColorPickerView.h"
#import "UIColor+extensions.h"

@interface CHDemoViewController ()

-(NSArray *)createDemoColor;
-(void)changeGridSize;

@end

@implementation CHDemoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    
    
    ///////////////////////////////////////////////////
    // Setting up the color picker
    ///////////////////////////////////////////////////
    
    
    colorPickerView = [[CHColorPickerView alloc] init];
    
    
    // 1. Setup delegate (Implement delegate methods)
    
    colorPickerView.delegate = self;
    
    
    
    // 2. Setup desired behaviour
    
    colorPickerView.colorsPerRow = 4;
    colorPickerView.colorCellPadding = 2.0;
    
    colorPickerView.highlightSelection = YES;
    colorPickerView.selectionBorderColor = [UIColor whiteColor];
    
    
    // 3. Set colors that should be available as an NSArray
    
    [colorPickerView setColors:[self createDemoColor]];
    
    
    // 4 Do some styling
    
    colorPickerView.backgroundColor = [UIColor colorWithHexString:@"1d2225"];
    
    
    // 5. add to view hierachy
    
    [self.view addSubview:colorPickerView];
    
    ///////////////////////////////////////////////////
    
    
    
    
    
    // following code is just for demo controller and has nothing to do with color picker
    
    gridSize = 4;
    
    UIBarButtonItem *changeGrid = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(changeGridSize)];
    changeGrid.tintColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = changeGrid;
    
}

-(void)changeGridSize
{
    gridSize++;
    
    if (gridSize > 10) {
        gridSize = 2;
    }
    
    colorPickerView.colorsPerRow = gridSize;
}

-(NSArray *)createDemoColor
{

    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    NSInteger colorCount = 36;
    NSInteger createdColors = 0;
    CGFloat hueStep = 1.0/colorCount;
    
    CGFloat currentHue = 0.0;
    
    while (createdColors < colorCount) {
        
        UIColor *tmpColor = [UIColor colorWithHue:currentHue saturation:1.0 brightness:1.0 alpha:1.0];
        [colors addObject:tmpColor];
        currentHue+=hueStep;
        
        createdColors++;
    }
    
    return colors;
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    colorPickerView.frame = self.view.bounds;
    
}

-(void)colorPickerView:(CHColorPickerView *)colorPickerView didSelectColor:(UIColor *)color
{
    self.navigationController.navigationBar.barTintColor = color;
}

@end
