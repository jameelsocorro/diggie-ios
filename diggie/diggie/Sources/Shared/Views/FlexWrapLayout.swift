//
//  FlexWrapLayout.swift
//  Diggie
//
//  Created by Jameel Socorro on 20/6/25.
//

import SwiftUI

/// Simple flex-wrap layout similar to CSS flexbox
struct FlexWrapLayout<Content: View>: View {
    let content: Content
    let spacing: CGFloat
    
    init(spacing: CGFloat = 8, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }
    
    var body: some View {
        _FlexWrapLayout(spacing: spacing) {
            content
        }
    }
}

struct _FlexWrapLayout: Layout {
    let spacing: CGFloat
    
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        let height = rows.reduce(0) { $0 + $1.maxHeight + spacing } - spacing
        return CGSize(width: proposal.width ?? 0, height: height)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        var y = bounds.minY
        
        for row in rows {
            var x = bounds.minX
            for (rowIndex, subviewIndex) in row.indices.enumerated() {
                guard subviewIndex < subviews.count, rowIndex < row.sizes.count else { continue }
                let subview = subviews[subviewIndex]
                let size = row.sizes[rowIndex]
                subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(width: size.width, height: size.height))
                x += size.width + spacing
            }
            y += row.maxHeight + spacing
        }
    }
    
    private func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> [Row] {
        guard !subviews.isEmpty else { return [] }
        
        var rows: [Row] = []
        var currentRow = Row()
        var currentRowWidth: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity
        
        for (index, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            let newWidth = currentRowWidth + size.width + (currentRow.indices.isEmpty ? 0 : spacing)
            
            if newWidth <= maxWidth || currentRow.indices.isEmpty {
                currentRow.indices.append(index)
                currentRow.sizes.append(size)
                currentRow.maxHeight = max(currentRow.maxHeight, size.height)
                currentRowWidth = newWidth
            } else {
                if !currentRow.indices.isEmpty {
                    rows.append(currentRow)
                }
                currentRow = Row()
                currentRow.indices.append(index)
                currentRow.sizes.append(size)
                currentRow.maxHeight = size.height
                currentRowWidth = size.width
            }
        }
        
        if !currentRow.indices.isEmpty {
            rows.append(currentRow)
        }
        
        return rows
    }
}

private struct Row {
    var indices: [Int] = []
    var sizes: [CGSize] = []
    var maxHeight: CGFloat = 0
}

#Preview {
    FlexWrapLayout(spacing: 8) {
        ForEach(SocialPlatform.allCases) { platform in
            Text(platform.displayName)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(20)
        }
    }
    .padding()
}