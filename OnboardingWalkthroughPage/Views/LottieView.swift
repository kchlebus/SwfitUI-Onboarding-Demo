//
//  LottieView.swift
//  OnboardingWalkthroughPage
//
//  Created by Kamil Chlebuś on 04/01/2023.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
  let animationName: String
  @Binding var isPlaying: Bool
  @Binding var progress: CGFloat

  func makeUIView(context: Context) -> LottieAnimationViewWrapper {
    LottieAnimationViewWrapper(animationName: animationName)
  }

  func updateUIView(_ uiView: LottieAnimationViewWrapper, context: Context) {
    if isPlaying {
      uiView.animationView.currentProgress = progress
      uiView.animationView.play()
    } else {
      uiView.animationView.pause()
    }
  }
}

final class LottieAnimationViewWrapper: UIView {
  let animationView: LottieAnimationView = LottieAnimationView()

  init(animationName: String) {
    super.init(frame: .zero)

    animationView.animation = LottieAnimation.asset(animationName)
    animationView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(animationView)

    NSLayoutConstraint.activate([
      animationView.heightAnchor.constraint(equalTo: heightAnchor),
      animationView.widthAnchor.constraint(equalTo: widthAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
