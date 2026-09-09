//
//  ViewStateView.swift
//  BreweryApp
//
//  Created by Filipe Merli on 09/09/2026.
//

import SwiftUI

struct ViewStateView<Content: View, Data: Equatable>: View {
    let state: ViewState<Data>
    var reloadActrion: (() -> Void)?
    var content: (Data) -> Content

    init(
        state: ViewState<Data>,
        reloadActrion: (() -> Void)? = nil,
        @ViewBuilder content: @escaping (Data) -> Content
    ) {
        self.state = state
        self.reloadActrion = reloadActrion
        self.content = content
    }

    var body: some View {
        switch state {
        case let .data(data):
            content(data)

        case .loading, .empty:
            loadingView

        case let .error(message):
            errorView(
                message: message ?? "something went wrong!",
                reloadAction: reloadActrion
            )
        }
    }

    private var loadingView: some View {
        VStack {
            Text("Loading...")
                .font(.title3)
            ProgressView()
                .progressViewStyle(.automatic)
        }
    }

    private func errorView(message: String, reloadAction: (() -> Void)? = nil) -> some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .renderingMode(.original)
                .resizable()
                .frame(width: 90, height: 80)
                .tint(.yellow)
                .padding()
            Text("Error!")
                .font(.title)
                .padding()
            Text(message)
                .font(.body)
                .padding()
            Button {
                reloadAction?()
            } label: {
                Text("Try again")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .tint(Color.black)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    let state: ViewState<Brewery> = .error(message: "Generic error test")
    ViewStateView(state: state, reloadActrion: nil) { _ in }
}

