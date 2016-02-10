//
//  FPCBonsaiDueAddFPCBonsai.m
//  FPCBonsaiDue
//
//  Created by Federico Paliotta on 04/10/13.
//  Copyright (c) 2013 Federico Paliotta. All rights reserved.
//

#import "FPCBonsaiDueAddBonsaiViewController.h"
#import "FPCBonsaiDueMasterViewController.h"
#import "FPCBonsaiDataController.h"
#import "FPCBonsai.h"



@implementation FPCBonsaiDueAddBonsaiViewController{
    NSArray *varieties;
}

- (void)viewDidLoad
{
    // Fai i settings dei bar buttons
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor greenColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor greenColor];
    // Popola il pickerView
    self.varietyPickedValue = @"Altro";
    [self pickerContentInit];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.nameInput) || (textField == self.ageInput)){
        [textField resignFirstResponder];        
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"])
    {
        UIImage * avatar = [[[FPCBonsaiDataController alloc] init] varietyAvatarImage:self.varietyPickedValue];
        self.myNewFPCBonsai = [[FPCBonsai alloc] initWithName:self.nameInput.text
                                                variety:self.varietyPickedValue
                                                    age:[self.ageInput.text intValue] image: avatar];
    }
}


#pragma mark - PickerView DataSource and Delegate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self->varieties count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self->varieties objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	// If the user chooses a new row, update the label accordingly.
	[self updateLabel];
}


#pragma mark - Helper methods

// Inizializza l'array varieties per popolare il picker view (per adesso)
-(void)pickerContentInit{
    self->varieties = [[[FPCBonsaiDataController alloc] init] varietiesArrayList:@"FPCBonsaiVarietiesInfo"];
}

- (void)updateLabel {
    self.varietyPickedValue = [NSString stringWithFormat:@"%@",[self->varieties objectAtIndex:[self.pickerView selectedRowInComponent:0]]];
    self.varietyLabel.text = self.varietyPickedValue;
}



@end
