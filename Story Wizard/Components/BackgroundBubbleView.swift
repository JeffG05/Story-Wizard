//
//  BackgroundBubbleView.swift
//  Story Wizard
//
//  Created by Jeff Gugelmann on 23/10/2022.
//

import SwiftUI

struct BackgroundBubbleView: View {
    var bubblePosition: BubblePosition
    var proxy: GeometryProxy
    
    var body: some View {
        let directionModifier = bubblePosition == .left ? -1.0 : bubblePosition == .right ? 1.0 : 0.0
        
        Canvas { context, size in
            
            func drawBorderedEllipse(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, fill: Color, stroke: Color) {
                
                context.fill(
                    Path(ellipseIn: CGRect(x: x, y: y, width: width, height: height)),
                    with: .color(fill)
                )
                
                context.stroke(
                    Path(ellipseIn: CGRect(x: x, y: y, width: width, height: height)),
                    with: .color(stroke),
                    lineWidth: 30
                )
                
            }
              
            if bubblePosition == .center {
                // Top Bubble
                let topWidth = size.width * 1.5
                let topHeight = size.height / 2.3
                drawBorderedEllipse(
                    x: -size.width/4,
                    y: -topHeight/2,
                    width: topWidth,
                    height: topHeight,
                    fill: .lighterBlue,
                    stroke: .mainBlue
                )
                
                // Bottom Bubble
                let bottomWidth = size.width * 1.5
                let bottomHeight = size.height / 1.45
                drawBorderedEllipse(
                    x: -size.width/4,
                    y: bottomHeight,
                    width: bottomWidth,
                    height: bottomHeight,
                    fill: .lighterBlue,
                    stroke: .mainBlue
                )
            } else {
                // Top Bubble
                let topWidth = size.width
                let topHeight = size.height / 3
                drawBorderedEllipse(
                    x: directionModifier * topWidth/1.8,
                    y: -topHeight/1.8,
                    width: topWidth,
                    height: topHeight,
                    fill: .lighterBlue,
                    stroke: .mainBlue
                )
                
                // Bottom Bubble
                let bottomWidth = size.width
                let bottomHeight = 2 * size.height / 3
                drawBorderedEllipse(
                    x: -directionModifier * bottomWidth/4,
                    y: bottomHeight/1.4,
                    width: bottomWidth,
                    height: bottomHeight,
                    fill: .lighterBlue,
                    stroke: .mainBlue
                )
            }
        }
        .ignoresSafeArea()
    }
}

enum BubblePosition {
    case left, center, right
}

struct BackgroundBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { g in
            BackgroundBubbleView(bubblePosition: .center, proxy: g)
        }
        .ignoresSafeArea()
    }
}
