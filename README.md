# HelpfulCGRectExtensions
Swift `CGRect` Extension that make manipulating and laying out frames a bunch easier. For people who are frustrated by AutoLayout but also tired of doing rote calculations to create simple layouts.

# Purpose
Normally, the whole point of configuring `CGRects` is so you can use them to define `UIViews`. The manipulations provided here don't directly affect any `UIViews` from which the frames may have been derived, so you'll have to re-apply them to the `UIVIews` after you've set them up how you like them. 

/note:/ To keep this repository simple I've just had it cover `CGRect`. I do have an extension of `UIView` that adds all this functionality to `UIViews`, but it's not stand-alone, it's part of my [NautoLayout repository]( https://github.com/SwingsetTheory/NautoLayout.git), which also includes a slew of other helpful stuff if you want to avoid AutoLayout.

# Features
## easy access to x and y
`rect.x` and `rect.y` are accessible directly. What could be easier?

## make copies by only specifying the changes you want
To copy a `CGRect` and only change the height, it's as simple as 
```
let rectCopy = rect.copyWithNew(height: 200)
``` 
Same can be done for x, y, and width, as well as any combination of them, as in: 
```
let rectCopy = rect.copyWithNew(y: 15, width: 200)
```

## instantly make copies with origins set to 0
Like this: 
```
let newRect = rect.copyAtZeroZero()
```

## layout subframes in a snap (super powerful, super time saver!) 
A collection of functions that lets any CGRect take a set of other CGRects and set all their x and y values to lay them out in simple ways.

### the functions at a glance
 - `layoutVerticallyAlongCenterX(subRects rects: [CGRect], margin: CGFloat? = nil)-> [CGRect]`
 - `layoutVertically(subRects rects: [CGRect], centerX: CGFloat, margin: CGFloat? = nil)->[CGRect]`
 - `layoutVertically(subRects rects: [CGRect], proportionalCenterX: CGFloat, margin: CGFloat? = nil)->[CGRect]`
 - `layoutHorizontallyAlongCenterY(subRects rects: [CGRect], margin: CGFloat? = nil)-> [CGRect]`
 - `layoutHorizontally(subRects rects: [CGRect], centerY: CGFloat, margin: CGFloat? = nil)->[CGRect]`
 - `layoutHorizontally(subRects rects: [CGRect], proportionalCenterY: CGFloat, margin: CGFloat? = nil)->[CGRect]`

### more in-depth explanations
`layoutVerticallyAlongCenterX` will allow a `CGRrect` to take in a bunch of other `CGRects` and return them evenly spaced right down its center:
``` 
let mainRect = CGRect( ...whatever dimensions desired...) 
let setOfRects = [rectA, rectB, rectC]
let verticalSet = mainRect.layoutVerticallyAlongCenterX(rects: setOfRects)
```
If you want to specify a different center X to align them along, you can just use `layoutVertically`.
``` 
let mainRect = CGRect( ...whatever dimensions desired...) 
let setOfRects = [rectA, rectB, rectC]
let arbitrarySet = mainRect.layoutVertically(rects: setOfRects, centerX: 20)
```
And if you want to use a proportional X value instead of a literal one, you can do that with an overloaded version of `layoutVertically`. This example lays out the sub-rects vertically centered on the left side of the parent:
``` 
let mainRect = CGRect( ...whatever dimensions desired...) 
let setOfRects = [rectA, rectB, rectC]
let proportionalSet = mainRect.layoutVertically(rects: setOfRects, proportionalCenterX: 0.25)
```
And of course, the exact same functionality is provided for horizontal layouts.
```
...
//centered along horizontal median:
 let horizontalRects = layoutHorizontallyAlongCenterY(rects: setOfRects)
 ...
 //centered along arbitrary horizontal position:
 let arbitrarySet = layoutHorizontally(rects: setOfRects centerY: 22)
  ...
 //centered along horizontal position expressed as a proportion of the parent's height
 //in this case close to the left side of the parent:
 let proportionalSet = layoutHorizontally(rects: setOfRects centerY: 0.75)
 ```
 ### ...and they all take margins, too
Every one of the layout commands has an optional `margin` parameter that lets you specify a padding amount that will be added to the vertical or horizontal end boundaries, whatever the case may be. Two examples:
```
...
let verticalRects = mainRect.layoutVerticallyAlongCenterX(rects: setOfRects, margin: 12)
...
 let proportionallyHorizontalRects = layoutHorizontally(rects: setOfRects centerY: 0.75, margin: 8)
```
/note: ideally the proportional overloads would let the margin be expressed proportionally as well, but at present, they don't./

I'm sure there are others out there who prefer to do things by hand but would love a few handy shortcuts. I hope these help!
