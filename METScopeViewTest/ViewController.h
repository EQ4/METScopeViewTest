//
//  ViewController.h
//  METScopeViewTest
//
//  Created by Jeff Gregorio on 5/7/14.
//  Copyright (c) 2014 Jeff Gregorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioInput.h"
#import "AudioParameters.h"
#import "METScopeView.h"

@interface ViewController : UIViewController <AudioInputDelegate> {
    
    AudioInput *audioIn;
    
    IBOutlet METScopeView *kObjectScopeView;
    CGFloat previousPinchScale;
    float clippingAmplitude;
    float xMin, xMax;

    UIPinchGestureRecognizer *pinchRecognizer1;
    
    IBOutlet UIStepper *kObjectXMinStepper;
    IBOutlet UIStepper *kObjectXMaxStepper;
    IBOutlet UIStepper *kObjectYMinStepper;
    IBOutlet UIStepper *kObjectYMaxStepper;
    IBOutlet UIStepper *kObjectXGridScaleStepper;
    IBOutlet UIStepper *kObjectYGridScaleStepper;
    IBOutlet UIStepper *kObjectPlotResolutionStepper;
    
    IBOutlet UILabel *kObjectXMinLabel;
    IBOutlet UILabel *kObjectXMaxLabel;
    IBOutlet UILabel *kObjectYMinLabel;
    IBOutlet UILabel *kObjectYMaxLabel;
    IBOutlet UILabel *kObjectXGridScaleLabel;
    IBOutlet UILabel *kObjectYGridScaleLabel;
    IBOutlet UILabel *kObjectPlotResolutionLabel;
    
    IBOutlet UISwitch *kObjectAxesSwitch;
    IBOutlet UISwitch *kObjectGridSwitch;
    IBOutlet UISwitch *kObjectLabelsSwitch;
    IBOutlet UISwitch *kObjectPinchZoomXSwitch;
    IBOutlet UISwitch *kObjectPinchZoomYSwitch;
    IBOutlet UISwitch *kObjectAutoGridXSwitch;
    IBOutlet UISwitch *kObjectAutoGridYSwitch;
    IBOutlet UISwitch *kObjectTrackingSwitch;
    
    IBOutlet UISlider *kObjectTrackingLevelSlider;
    
    IBOutlet UIButton *kObjectDisplayModeButton;
}

- (IBAction)toggleXZoom:(id)sender;
- (IBAction)toggleYZoom:(id)sender;
- (IBAction)toggleAutoXGrid:(id)sender;
- (IBAction)toggleAutoYGrid:(id)sender;
- (IBAction)toggleAxes:(id)sender;
- (IBAction)toggleGrid:(id)sender;
- (IBAction)toggleLabels:(id)sender;
- (IBAction)updateXLim:(id)sender;
- (IBAction)updateYLim:(id)sender;
- (IBAction)updateGridScale:(id)sender;
- (IBAction)toggleTracking:(id)sender;
- (IBAction)updateTrackingLevel:(id)sender;
- (IBAction)updatePlotResolution:(id)sender;
- (IBAction)updateDisplayMode:(id)sender;

@end
