# HelpfulCGRectExtensions
Swift CGRect Extension that make manipulating and laying out frames a bunch easier.

# Features
## easy access to x and y
`rect.x` and `rect.y` are accessible directly. What could be easier?

## make copies by only specifying the changes you want
To copy a `CGRect` and only change the height, it's as simple as 
```let rectCopy = rect.copyWithNew(height: 200)``` Same can be done for x, y, and width, as well as any combination of them, as in: `let rectCopy = rect.copyWithNew(y: 15, width: 200)`

## instantly make copies with origins set to 0
Like this: `let newRect = rect.copyAtZeroZero()`.

## layout subframes in a snap (super powerful, super time saver!)
A collection of functions that lets any CGRect take a set of other CGRects and set all their x and y values to lay them out in simple ways.

The vertical functions, for example, will allow a CGRrect to take in a bunch of other CGRects and return them evenly spaced right down its center:
` let mainRect = CGRect( ...whatever dimensions desired...) 
let setOfRects = [rectA, rectB, rectC]
let centeredSetOfRects = mainRect.layoutVertically(rects: setOfRects)`
 - `layoutVerticallyAlongCenterX(subRects rects: [CGRect], margin: CGFloat? = nil)-> [CGRect]`
 - `public func layoutVertically(subRects rects: [CGRect], centerX: CGFloat, margin: CGFloat? = nil)->[CGRect]`
 - `public func layoutVertically(subRects rects: [CGRect], proportionalCenterX: CGFloat, margin: CGFloat? = nil)->[CGRect]`
 - 
