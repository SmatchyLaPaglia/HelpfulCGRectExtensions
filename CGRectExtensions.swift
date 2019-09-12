extension CGRect {
  public var x: CGFloat {
    get { return origin.x }
    set { origin.x = newValue }
  }
  public var y: CGFloat {
    get { return origin.y }
    set { origin.y = newValue }
  }
  /** Creates a copy of current rect with any property changed. */
  public func copyWithNew(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil)->CGRect {
    var newFrame = self
    newFrame.x =? x
    newFrame.y =? y
    if let width = width {
      newFrame = CGRect(x: newFrame.x, y: newFrame.y, width: width, height: newFrame.height)
    }
    if let height = height {
      newFrame = CGRect(x: newFrame.x, y: newFrame.y, width: newFrame.width, height: height)
    }
    return newFrame
  }
  /** Returns a copy with origin set to 0, 0. */
  public func copyAtZeroZero()->CGRect {
    return copyWithNew(x: 0, y:0)
  }
  
  //*** Vertical layout functions.
  /** Takes the given rects and returns them stacked vertically inside this rect, with their centers aligned at the given x value. Keeps a consistent gap between each rect and, by default, the same gap as a margin at either end. If a custom margin is set, the rects will keep a consistent gap between each other but hew to the specified margin.*/
  public func layoutVertically(subRects rects: [CGRect], centerX: CGFloat, margin: CGFloat? = nil)->[CGRect] {
    //find this rect's height less margin
    var operativeHeight = height
    if let margin = margin {
      operativeHeight -= (margin * 2)
    }
    //find that less total height of given rects
    var rectsHeight: CGFloat = 0
    rects.forEach({ rectsHeight += $0.height })
    let availablePadding = operativeHeight - rectsHeight
    //find amount to put between each rect
    let spaceBetween: CGFloat
    let spacesNeeded: Int
    if let _ = margin {
      spacesNeeded = rects.count - 1
    } else {
      spacesNeeded = rects.count + 1
    }
    spaceBetween = availablePadding / CGFloat(spacesNeeded)
    //set a starting y
    var currentY: CGFloat = spaceBetween
    if let margin = margin {
      currentY = margin
    }
    //calculate the new rects
    var newRects: [CGRect] = []
    for var rect in rects {
      // set the origin of the current rect
      rect.x = centerX - (rect.width / 2)
      rect.y = currentY
      currentY += rect.height + spaceBetween
      newRects.append(rect)
    }
    return newRects
  }
  /** Functions exactly as layoutVertically, but with the center x value specified between 0 and 1, reflecting the percentage of this rect's width along which the centers of the subRects should align. */
  public func layoutVertically(subRects rects: [CGRect], proportionalCenterX: CGFloat, margin: CGFloat? = nil)->[CGRect] {
    let calculatedX = width * proportionalCenterX
    return self.layoutVertically(subRects: rects, centerX: calculatedX, margin: margin)
  }
  /** Takes the given rects and returns them stacked vertically inside this rect, with their centers aligned at this rect's center x value. Keeps a consistent gap between each rect and, by default, the same gap as a margin at either end. If a custom margin is set, the rects will keep a consistent gap between each other but hew to the specified margin.*/
  public func layoutVerticallyAlongCenterX(subRects rects: [CGRect], margin: CGFloat? = nil)-> [CGRect] {
    return self.layoutVertically(subRects: rects, proportionalCenterX: 0.5, margin: margin)
  }
  
  //*** Horizontal layout functions.
  /** Takes the given rects and returns them lined up horizontally inside this rect, with their centers set at the given y value. Keeps a consistent gap between each rect and, by default, the same gap as a margin at either end. If a custom margin is set, the rects will keep a consistent gap between each other but hew to the specified margin.*/
  public func layoutHorizontally(subRects rects: [CGRect], centerY: CGFloat, margin: CGFloat? = nil)->[CGRect] {
    //find this rect's width less margin
    var operativeWidth = width
    if let margin = margin {
      operativeWidth -= (margin * 2)
    }
    //find that less total width of given rects
    var rectsWidth: CGFloat = 0
    rects.forEach({ rectsWidth += $0.width })
    let availablePadding = operativeWidth - rectsWidth
    //find amount to put between each rect
    let spaceBetween: CGFloat
    let spacesNeeded: Int
    if let _ = margin {
      spacesNeeded = rects.count - 1
    } else {
      spacesNeeded = rects.count + 1
    }
    spaceBetween = availablePadding / CGFloat(spacesNeeded)
    //set a starting x
    var currentX: CGFloat = spaceBetween
    if let margin = margin {
      currentX = margin
    }
    //calculate the new rects
    var newRects: [CGRect] = []
    for var rect in rects {
      // set the origin of the current rect
      rect.y = centerY - (rect.height / 2)
      rect.x = currentX
      currentX += rect.width + spaceBetween
      newRects.append(rect)
    }
    return newRects
  }
  /** Functions exactly as layoutHorizontally, but with the center y value specified between 0 and 1, reflecting the percentage of this rect's height along which the centers of the subRects should align. */
  public func layoutHorizontally(subRects rects: [CGRect], proportionalCenterY: CGFloat, margin: CGFloat? = nil)->[CGRect] {
    let calculatedY = height * proportionalCenterY
    return self.layoutHorizontally(subRects: rects, centerY: calculatedY, margin: margin)
  }
  /** Takes the given rects and returns them lined up horizontally inside this view, with their centers aligned at this view's center y value. Keeps a consistent gap between each view and, by default, the same gap as a margin at either end. If a custom margin is set, the views will keep a consistent gap between each other but hew to the specified margin.*/
  public func layoutHorizontallyAlongCenterY(subRects rects: [CGRect], margin: CGFloat? = nil)-> [CGRect] {
    return self.layoutHorizontally(subRects: rects, proportionalCenterY: 0.5, margin: margin)
  }
}
