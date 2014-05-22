//
//  ViewController.m
//  METScopeViewTest
//
//  Created by Jeff Gregorio on 5/7/14.
//  Copyright (c) 2014 Jeff Gregorio. All rights reserved.
//
 
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /* Set the FFT size before setting the frequency domain mode */
    [kObjectScopeView setUpFFTWithSize:512];
    
    /* Set the interface controls to METScopeView's current values (defaults) */
    [self getInterfaceValuesFromScopeView];
    
    /* Audio setup */
    audioIn = [[AudioInput alloc] initWithDelegate:self];
    [audioIn start];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Query the Scope View to get interface object values and states */
- (void)getInterfaceValuesFromScopeView {
    
    kObjectXMinStepper.value = [kObjectScopeView minPlotMin].x;
    kObjectXMaxStepper.value = [kObjectScopeView maxPlotMax].x;
    kObjectYMinStepper.value = [kObjectScopeView minPlotMin].y;
    kObjectYMaxStepper.value = [kObjectScopeView maxPlotMax].y;
    kObjectXGridScaleStepper.value = [kObjectScopeView tickUnits].x;
    kObjectYGridScaleStepper.value = [kObjectScopeView tickUnits].y;
    kObjectPlotResolutionStepper.value = log2([kObjectScopeView plotResolution]);
    kObjectTrackingLevelSlider.value = [kObjectScopeView trackingLevel];
    [kObjectAxesSwitch setOn:[kObjectScopeView axesOn]];
    [kObjectGridSwitch setOn:[kObjectScopeView gridOn]];
    [kObjectLabelsSwitch setOn:[kObjectScopeView xLabelsOn] && [kObjectScopeView yLabelsOn]];
    [kObjectPinchZoomXSwitch setOn:[kObjectScopeView pinchZoomXEnabled]];
    [kObjectPinchZoomYSwitch setOn:[kObjectScopeView pinchZoomYEnabled]];
    [kObjectAutoGridXSwitch setOn:[kObjectScopeView autoScaleXGrid]];
    [kObjectAutoGridYSwitch setOn:[kObjectScopeView autoScaleYGrid]];
    [kObjectTrackingSwitch setOn:[kObjectScopeView trackingOn]];
    [kObjectTrackingLevelSlider setValue:[kObjectScopeView trackingLevel]];
    
    /* Update labels */
    kObjectPlotResolutionLabel.text = [NSString stringWithFormat:@"%d", [kObjectScopeView plotResolution]];
    kObjectXMinLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectXMinStepper.value];
    kObjectXMaxLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectXMaxStepper.value];
    kObjectYMinLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectYMinStepper.value];
    kObjectYMaxLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectYMaxStepper.value];
    kObjectXGridScaleLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectXGridScaleStepper.value];
    kObjectYGridScaleLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectYGridScaleStepper.value];
    
    kObjectDisplayModeButton.titleLabel.text = kObjectScopeView.displayMode == kMETScopeViewTimeDomainMode ? @"View Spectrum" : @"View Waveform";
    kObjectDisplayModeButton.titleLabel.adjustsFontSizeToFitWidth = true;
}

- (IBAction)toggleXZoom:(id)sender {
    [kObjectScopeView togglePinchZoom:'x'];
}

- (IBAction)toggleYZoom:(id)sender {
    [kObjectScopeView togglePinchZoom:'y'];
}

- (IBAction)toggleAutoXGrid:(id)sender {
    
    [kObjectScopeView toggleAutoGrid:'x'];
    
    if ([kObjectScopeView autoScaleXGrid]) {
        [kObjectXGridScaleStepper setEnabled:false];
        [kObjectXGridScaleStepper setAlpha:0.2];
        [kObjectXGridScaleLabel setAlpha:0.2];
    }
    else {
        [kObjectXGridScaleStepper setEnabled:true];
        [kObjectXGridScaleStepper setAlpha:1.0];
        [kObjectXGridScaleLabel setAlpha:1.0];
        [kObjectScopeView setPlotUnitsPerXTick:kObjectXGridScaleStepper.value];
    }
}

- (IBAction)toggleAutoYGrid:(id)sender {
    
    [kObjectScopeView toggleAutoGrid:'y'];
    
    if ([kObjectScopeView autoScaleYGrid]) {
        [kObjectYGridScaleStepper setEnabled:false];
        [kObjectYGridScaleStepper setAlpha:0.2];
        [kObjectYGridScaleLabel setAlpha:0.2];
    }
    else {
        [kObjectYGridScaleStepper setEnabled:true];
        [kObjectYGridScaleStepper setAlpha:1.0];
        [kObjectYGridScaleLabel setAlpha:1.0];
        [kObjectScopeView setPlotUnitsPerYTick:kObjectYGridScaleStepper.value];
    }
}

- (IBAction)toggleAxes:(id)sender {
    [kObjectScopeView toggleAxes];
}

- (IBAction)toggleGrid:(id)sender {
    [kObjectScopeView toggleGrid];
}

- (IBAction)toggleLabels:(id)sender {
    [kObjectScopeView toggleLabels];
}

- (IBAction)updateXLim:(id)sender {
    
    [kObjectScopeView setHardXLim:kObjectXMinStepper.value max:kObjectXMaxStepper.value];
    
    kObjectXMinLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectXMinStepper.value];
    kObjectXMaxLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectXMaxStepper.value];
}

- (IBAction)updateYLim:(id)sender {
    
    [kObjectScopeView setHardYLim:kObjectYMinStepper.value max:kObjectYMaxStepper.value];
    
    kObjectYMinLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectYMinStepper.value];
    kObjectYMaxLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectYMaxStepper.value];
}

- (IBAction)updateGridScale:(id)sender {
    
    [kObjectScopeView setPlotUnitsPerTick:kObjectXGridScaleStepper.value vertical:kObjectYGridScaleStepper.value];
    
    kObjectXGridScaleLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectXGridScaleStepper.value];
    kObjectYGridScaleLabel.text = [NSString stringWithFormat:@"%5.3f", (float)kObjectYGridScaleStepper.value];
}

- (IBAction)toggleTracking:(id)sender {
    
    if ([kObjectScopeView trackingOn])
        [kObjectScopeView setTrackingOn:false];
    else
        [kObjectScopeView setTrackingOn:true];
}
- (IBAction)updateTrackingLevel:(id)sender {
    
    [kObjectScopeView setTrackingLevel:kObjectTrackingLevelSlider.value];
}

- (IBAction)updatePlotResolution:(id)sender {
    
    bool wasRunning = false;
    
    /* Warning: don't set the plot resolution while writing data to the METScopeView */
    if ([audioIn isRunning]) {
        [audioIn stop];
        wasRunning = true;
    }
    
    int resolution = pow(2, [kObjectPlotResolutionStepper value]);
    [kObjectScopeView setPlotResolution:resolution];
    [kObjectPlotResolutionLabel setText:[NSString stringWithFormat:@"%d", resolution]];
    
    if (wasRunning)
        [audioIn start];
}

- (IBAction)updateDisplayMode:(id)sender {
    
    if (kObjectScopeView.displayMode == kMETScopeViewTimeDomainMode) {
        [kObjectScopeView setDisplayMode:kMETScopeViewFrequencyDomainMode];
        [kObjectXGridScaleStepper setMaximumValue:20000];
        [kObjectXGridScaleStepper setStepValue:1000];
        [kObjectXGridScaleStepper setMaximumValue:10000];
        [kObjectXGridScaleStepper setStepValue:500];
        [self getInterfaceValuesFromScopeView];
    }
    else if (kObjectScopeView.displayMode == kMETScopeViewFrequencyDomainMode) {
        [kObjectScopeView setDisplayMode:kMETScopeViewTimeDomainMode];
        [kObjectXGridScaleStepper setMaximumValue:0.05];
        [kObjectXGridScaleStepper setStepValue:0.001];
        [kObjectXGridScaleStepper setMaximumValue:0.01];
        [kObjectXGridScaleStepper setStepValue:0.001];
        [self getInterfaceValuesFromScopeView];
    }
}

#pragma mark -
#pragma mark Audio Callback
- (void)processInputBuffer:(float *)buffer numSamples:(int)numSamples {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),  ^{
    
        /* Allocate a buffer and copy incoming audio samples */
        float *plotDataBuffer = (float *)calloc(numSamples, sizeof(float));
        
        for (int i = 0; i < numSamples; i++) {
            plotDataBuffer[i] = buffer[i];
        }
        
        /* Allocate a buffer of times for the plot given the sample rate and buffer length */
        float *xx = (float*)calloc(numSamples, sizeof(float));
        [self linspace:0.0 max:numSamples/kInputSampleRate numElements:numSamples array:xx];
        
        /* Pass the waveform coordinates to the scope view for resampling/drawing. Note: we don't have to call [METScopeView appendDataWithLength:...] for the initial buffer because METScopeView appends a new waveform at index i if it currently has i waveforms, and replaces the i^th waveform if it has >i. */
        [kObjectScopeView setDataAtIndex:0
                              withLength:numSamples
                                   xData:xx
                                   yData:plotDataBuffer
                                   color:[UIColor blueColor]
                               lineWidth:2.0];
        free(xx);
        free(plotDataBuffer);
    });
}

#pragma mark -
#pragma mark Utility
/* Generate a linearly-spaced set of indices for sampling an incoming waveform */
- (void)linspace:(float)minVal max:(float)maxVal numElements:(int)size array:(float*)array {
    
    float step = (maxVal-minVal)/(size-1);
    array[0] = minVal;
    int i;
    for (i = 1;i<size-1;i++) {
        array[i] = array[i-1]+step;
    }
    array[size-1] = maxVal;
}


@end
