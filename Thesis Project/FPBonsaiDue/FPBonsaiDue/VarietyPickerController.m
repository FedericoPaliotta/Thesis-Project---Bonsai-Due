//
//  VarietyPickerController.m
//  FPBonsaiDue
//
//  Created by Federico Paliotta on 08/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VarietyPickerController.h"
#import "BonsaiDueAddBonsaiViewController.h"


@implementation VarietyPickerController


#pragma mark - Helper methods

// Inizializza l'array varieties per popolare il picker view (per adesso)
-(void)pickerContentInit{
    self.varieties = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", nil];
}

- (void)updateLabel {
    self.varietySelectedLabel.text = [NSString stringWithFormat:@"%@",[self.varieties objectAtIndex:[self.pickerView selectedRowInComponent:0]]];
}


#pragma mark - PickerView DataSource and Delegate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    [self pickerContentInit];// Non è esattamente appropriato, ma sembra non funzioni altrimenti...
    
    return [self.varieties count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.varieties objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	// If the user chooses a new row, update the label accordingly.
	[self updateLabel];
}

@end
