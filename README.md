# HelpfulCGRectExtensions
Swift CGRect Extension that make manipulating and laying out frames a bunch easier.

# Features
## easy access to x and y
`rect.x` and rect.y` are accessible directly. What could be easier?

## make copies by only specifying explicit changes
To copy a `CGRect` and only change the height, it's as simple as `new copy = rect.copyWithNew(height: 200)`. Same can be done for x, y, and width, as well as any combination of them.
