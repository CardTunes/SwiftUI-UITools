A grab bag of tools and utiliities I created for SwiftUI.  The Demo project can be launched to see it in action. One example provides a simple list 
and another a circular layout to show that selections work no matter the layout as long as each subview doesn't overlap. Also works with nested objects as long as the proper ID is 
associated with the FrameGrabModifier.

1. MultiSelect
   A container view that enables multi-select on MacOS currently although probably easily tweaked for IOS. SubViews just need to add the FrameGrabModifier,
   add the UUID of the object to be selected and then highlighting can be added based on whether the set of ids contains that id,
   similar to built in functionality for Lists but far more layout flexibility.

2. JsonUtil
   Enables easy JSON encode and decoding for a specific type.
   
