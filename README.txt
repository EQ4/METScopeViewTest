METScopeViewTest
----------------

This iOS app is a test app for the METScopeView class demonstrating functionality for plotting real-time audio input in both time and frequency domains and setting various properties. 

Input buffers are allocated dynamically given some length, so multiple waveforms of different lengths can be passed simultaneously to METScopeView.

The class behaves much like MATLAB's plot(), so arbitrary waveforms/functions can be set using the [appendDataWithLength:xData:yData] and [setDataAtIndex:withLength:xData:yData] methods by passing both x and y coordinates.

Unlike MATLAB's plot(), the bounds of the x and y axes are not automatically determined, so they should be set appropriately using [setXHardLim:max] and [setYHardLim:max:]. These methods also constrain the built-in pinch-zoom gesture, which rescales by settin soft limits that are also settable using the [setXLim:max:] and [setYLim:max] methods.

The grid/tick line spacing can be scaled manually using [setPlotUnitsPerTick:vertical], in which case automatic grid scaling should be turned off by using [setAutoScaleGrid:].

See METScopeView.h for default property values

To add a METScopeView object using interface builder, add a UIView object to the xib/storyboard, and in the "Identity Inspector" menu, change the "Class" property to "METScopeView". Add a instance of the object in the header file with "IBOutlet METScopeView *metScopeViewInstance", and connect the IBOutlet to the object in interface builder.

To create a METScopeView object programmatically, use [METScopeView initWithFrame:(CGRect)rect]. 

Suggested improvements:

	- Log scaling for frequency domain mode

	- Waveform tracking currently only 'sort of' works for simple sinusoids. It may not be possible to stabilize more complex waveforms, but the tracking can certainly be improved. 

	- Automatically compute an appropriate precision for the plot axis labels given the order of magnitude of the plot data's x and y coordinates.

	- All rendering (waveform, axes, grid, labels, tracking indicator) is currently done in the main thread. It would be preferable to do the rendering in a background thread, save it to a CGContext member variable, and then have drawRect: (which can only get called in the main thread by UIKit) retrieve the context and draw it. This should free up the main thread for any application using METScopeView. This would also necessitate setting the plot data in the same background thread that does the rendering.

