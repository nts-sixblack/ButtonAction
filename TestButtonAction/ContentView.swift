//
//  ContentView.swift
//  TestButtonAction
//
//  Created by Thanh Sau on 03/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Preview()
    }
}

struct Preview: View {

    @StateObject
    var state = PreviewState()

    @State
    private var items = (1...3).map { PreviewItem(id: $0) }

    var body: some View {
        VStack(spacing: 20) {

            PreviewHeader(state: state)
                .padding(.horizontal)

            PreviewButtonGroup(title: "Buttons:") {
                GestureButton(
                    isPressed: $state.isPressed,
                    pressAction: { state.pressCount += 1 },
                    releaseInsideAction: { state.releaseInsideCount += 1 },
                    releaseOutsideAction: { state.releaseOutsideCount += 1 },
                    longPressDelay: 0.8,
                    longPressAction: { state.longPressCount += 1 },
                    doubleTapAction: { state.doubleTapCount += 1 },
                    repeatAction: { state.repeatTapCount += 1 },
                    dragStartAction: { state.dragStartedValue = $0.location },
                    dragAction: { state.dragChangedValue = $0.location },
                    dragEndAction: { state.dragEndedValue = $0.location },
                    endAction: { state.endCount += 1 },
                    label: { PreviewButton(color: .blue, isPressed: $0) }
                )
            }
        }
    }
}

struct PreviewItem: Identifiable {

    var id: Int
}

struct PreviewButton: View {

    let color: Color
    let isPressed: Bool

    var body: some View {
        color
            .cornerRadius(10)
            .opacity(isPressed ? 0.5 : 1)
            .scaleEffect(isPressed ? 0.9 : 1)
            .animation(.default, value: isPressed)
            .padding()
            .background(Color.random())
            .cornerRadius(16)
    }
}

struct PreviewButtonGroup<Content: View>: View {

    let title: String
    let button: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
            HStack {
                ForEach(0...3, id: \.self) { _ in
                    button()
                }
            }.frame(maxWidth: .infinity)
        }.padding(.horizontal)
    }
}

class PreviewState: ObservableObject {

    @Published
    var isPressed = false

    @Published
    var pressCount = 0

    @Published
    var releaseInsideCount = 0

    @Published
    var releaseOutsideCount = 0

    @Published
    var endCount = 0

    @Published
    var longPressCount = 0

    @Published
    var doubleTapCount = 0

    @Published
    var repeatTapCount = 0

    @Published
    var dragStartedValue = CGPoint.zero

    @Published
    var dragChangedValue = CGPoint.zero

    @Published
    var dragEndedValue = CGPoint.zero
}

struct PreviewHeader: View {

    @ObservedObject
    var state: PreviewState

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                label("Pressed", state.isPressed ? "YES" : "NO")
                label("Presses", state.pressCount)
                label("Releases", state.releaseInsideCount + state.releaseOutsideCount)
                label("     Inside", state.releaseInsideCount)
                label("     Outside", state.releaseOutsideCount)
                label("Ended", state.endCount)
                label("Long presses", state.longPressCount)
                label("Double taps", state.doubleTapCount)
                label("Repeats", state.repeatTapCount)
            }
            Group {
                label("Drag started", state.dragStartedValue)
                label("Drag changed", state.dragChangedValue)
                label("Drag ended", state.dragEndedValue)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).stroke(.blue, lineWidth: 3))
    }

    func label(_ title: String, _ int: Int) -> some View {
        label(title, "\(int)")
    }

    func label(_ title: String, _ point: CGPoint) -> some View {
        label(title, "\(point.x.rounded()), \(point.y.rounded())")
    }

    func label(_ title: String, _ value: String) -> some View {
        HStack {
            Text("\(title):")
            Text(value).bold()
        }.lineLimit(1)
    }
}

#Preview {
    ContentView()
}
