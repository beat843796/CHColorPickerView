//
//  CHColorPickerView.m
//  CHColorPickerDemo
//
//  Created by Clemens Hammerl on 04.07.14.
//  Copyright (c) 2014 cocoabeats GmbH. All rights reserved.
//

#import "CHColorPickerView.h"

#define kDefaultCellPadding 2.0f

#define kColorCellIdentifier @"CHColorPickerViewColorCellReuseIdentifier"

@interface CHColorPickerView ()

-(void)doInitialization;                                                        // Initializes the collection view and default values
-(void)setColorCell:(UICollectionViewCell *)cell selected:(BOOL)selected;       // marks a cell as selected according to "selection", does nothing is selection highlighting is disabled
-(void)resetColorPicker;                                                        // reloads data of collection view and sets content offset to zero

@end




@implementation CHColorPickerView

@synthesize delegate;





////////////////////////////////////////////////////////////////////////////////
#pragma mark - Initialisation
////////////////////////////////////////////////////////////////////////////////

- (id)init
{
    self = [super init];
    if (self) {
        
        
        [self doInitialization];
        
    }
    return self;
}



-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self doInitialization];
        
    }
    
    return self;
}












////////////////////////////////////////////////////////////////////////////////
#pragma mark - SETTERS
////////////////////////////////////////////////////////////////////////////////

-(void)setColors:(NSArray *)colorsIn;
{
    
    colors = nil;
    colors = colorsIn;
    
    [self resetColorPicker];
    
}

-(void)setColorsPerRow:(NSInteger)colorsPerRow
{
    
    if (colorsPerRow < 1) {
        
        _colorsPerRow = 1;
        
        [self resetColorPicker];
        
        return;
    }
    
    _colorsPerRow = colorsPerRow;
    
    [self resetColorPicker];
}

-(void)setColorCellPadding:(CGFloat)colorCellPadding
{
    _colorCellPadding = colorCellPadding;
    
    if (_colorCellPadding < 0.0) {
        _colorCellPadding = 0.0;
    }
    
    [self resetColorPicker];
}

-(void)setHighlightSelection:(BOOL)highlightSelection
{
    _highlightSelection = highlightSelection;
    
    [self resetColorPicker];
}

-(void)setSelectionBorderColor:(UIColor *)selectionBorderColor
{
    _selectionBorderColor = selectionBorderColor;
    
    [self resetColorPicker];
}











////////////////////////////////////////////////////////////////////////////////
#pragma mark - View Layout
////////////////////////////////////////////////////////////////////////////////

-(void)layoutSubviews
{
    _colorView.frame = self.bounds;
}













////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private method implementation
////////////////////////////////////////////////////////////////////////////////

-(void)doInitialization
{
    
    // Set default values
    
    self.colorsPerRow = 4;
    _colorCellPadding = kDefaultCellPadding;
    _highlightSelection = YES;
    _selectionBorderColor = [UIColor whiteColor];
    
    
    
    // Collection view setup
    
    _colorView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [_colorView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kColorCellIdentifier];
    _colorView.scrollEnabled = YES;
    _colorView.alwaysBounceVertical = YES;
    _colorView.backgroundColor = [UIColor clearColor];
    
    _colorView.contentInset = UIEdgeInsetsMake(_colorCellPadding, 0, _colorCellPadding, 0);
    
    _colorView.delegate = self;
    _colorView.dataSource = self;
    
    [self addSubview:_colorView];
    
    
    
    
    // create default colors;
    
    //    UIColor *red = [UIColor redColor];
    //    UIColor *green = [UIColor greenColor];
    //    UIColor *blue = [UIColor blueColor];
    //
    //    colors = [NSArray arrayWithObjects:red,green,blue, nil];
    
}

-(void)setColorCell:(UICollectionViewCell *)cell selected:(BOOL)selected
{
    
    if (!selected || !_highlightSelection) {
        cell.contentView.layer.borderColor = nil;
        cell.contentView.layer.borderWidth = 0;
    }else {
        cell.contentView.layer.borderColor = _selectionBorderColor.CGColor;
        cell.contentView.layer.borderWidth = 5;
    }
}

-(void)resetColorPicker
{
    [_colorView setContentOffset:CGPointMake(0, 0)];
    [_colorView reloadData];

}













////////////////////////////////////////////////////////////////////////////////
#pragma mark - Collection View Delegate and DataSource
////////////////////////////////////////////////////////////////////////////////


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return colors.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell;
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:kColorCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[UICollectionViewCell alloc] init];
        
    }
    
    
    [self setColorCell:cell selected:cell.isSelected];
    
    
    cell.backgroundColor = [colors objectAtIndex:indexPath.row];
    
    
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_colorView cellForItemAtIndexPath:indexPath];
    
    cell.alpha = 0.5;
}

-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_colorView cellForItemAtIndexPath:indexPath];
    
    cell.alpha = 1.0;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self setColorCell:[collectionView cellForItemAtIndexPath:indexPath] selected:YES];
    
    _selectedColor = [colors objectAtIndex:indexPath.row];
    
    if (delegate && [delegate respondsToSelector:@selector(colorPickerView:didSelectColor:)]) {
        [delegate colorPickerView:self didSelectColor:[colors objectAtIndex:indexPath.row]];
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self setColorCell:[collectionView cellForItemAtIndexPath:indexPath] selected:NO];
}














////////////////////////////////////////////////////////////////////////////////
#pragma mark - Collection View Layout Delegate
////////////////////////////////////////////////////////////////////////////////

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger itemsPerRow = _colorsPerRow;
    NSInteger spaceMultiplier = (itemsPerRow-1)*_colorCellPadding;
    
    if (spaceMultiplier <= 0) {
        spaceMultiplier = 0;
    }
    
    // calculate size for 3 thumbs per line
    CGFloat size = floorf((collectionView.bounds.size.width-spaceMultiplier)/itemsPerRow);
    
    return CGSizeMake(size, size);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return _colorCellPadding;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return _colorCellPadding;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0,0,0,0);
    
}


@end
