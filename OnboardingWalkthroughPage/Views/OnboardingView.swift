//
//  OnboardingView.swift
//  OnboardingWalkthroughPage
//
//  Created by Kamil Chlebuś on 04/01/2023.
//

import SwiftUI
import Lottie

struct OnboardingView: View {
  @State var slides: [OnboardingSlide] = OnboardingSlide.list
  @State var currentIndex: Int = 0

  var isLastSlide: Bool {
    currentIndex == (slides.count - 1)
  }

  var body: some View {
    GeometryReader {
      let size = $0.size
      HStack(spacing: 0) {
        ForEach($slides) { $item in
          VStack {
            // MARK: Top NavBar
            navigationHStack

            // MARK: Slide
            VStack(spacing: 16) {
              let xOffset = -CGFloat(currentIndex) * size.width

              LottieView(animationName: item.animationName, isPlaying: $item.isAnimating, progress: $item.progress)
                .frame(height: size.width)
                .onAppear {
                  let itemIndex = slides.firstIndex(of: item) ?? 0
                  if currentIndex == itemIndex {
                    playAnimation()
                  }
                }
                .offset(x: xOffset)
                .animation(.easeInOut(duration: 0.5), value: currentIndex)

              Text(item.title)
                .font(.title.bold())
                .offset(x: xOffset)
                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
              Text(item.subtitle)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .foregroundColor(.gray)
                .offset(x: xOffset)
                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
            }

            Spacer()

            // MARK: Bottom section
            VStack(spacing: 16) {
              nextLoginButton
              linksHStack
            }
          }
          .animation(.easeInOut, value: isLastSlide)
          .padding(16)
          .frame(width: size.width, height: size.height)
        }
      }
      .frame(width: size.width * CGFloat(slides.count), alignment: .leading)
      .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
        .onEnded { value in
          let horizontalAmount = value.translation.width
          let verticalAmount = value.translation.height
          let isHorizontal = abs(horizontalAmount) > abs(verticalAmount)
          let isLeft = horizontalAmount < 0
          guard isHorizontal else { return }

          pauseAnimation()
          if isLeft {
            if currentIndex < slides.count - 1 {
              currentIndex += 1
            }
          } else {
            if currentIndex > 0 {
              currentIndex -= 1
            }
          }
          playAnimation()
        }
      )
    }
  }
}

private extension OnboardingView {
  // MARK: Subviews

  var navigationHStack: some View {
    HStack {
      Button(L10n.back) {
        if currentIndex > 0 {
          pauseAnimation()
          currentIndex -= 1
          playAnimation()
        }
      }
      .opacity(currentIndex > 0 ? 1 : 0)

      Spacer()

      Button(L10n.skip) {
        pauseAnimation()
        currentIndex = slides.count - 1
        playAnimation()
      }
      .opacity(isLastSlide ? 0 : 1)
    }
    .animation(.easeOut, value: currentIndex)
    .tint(Color("Green"))
    .font(.system(size: 15, weight: .bold))
  }

  var nextLoginButton: some View {
    Button(isLastSlide ? L10n.login : L10n.next) {
      if currentIndex < slides.count - 1 {
        pauseAnimation()
        currentIndex += 1
        playAnimation()
      }
    }
    .fontWeight(.bold)
    .foregroundColor(.white)
    .padding(.vertical, isLastSlide ? 13 : 12)
    .frame(maxWidth: .infinity)
    .background {
      Capsule()
        .fill(Color("Green"))
    }
    .padding(.horizontal, isLastSlide ? 30 : 100)
  }

  var linksHStack: some View {
    HStack {
      Link(destination: URL(string: "https://www.apple.com")!) {
        Text(L10n.terms)
          .underline()
      }
      Link(destination: URL(string: "https://www.apple.com")!) {
        Text(L10n.privacy)
          .underline()
      }
    }
    .tint(Color("Link"))
    .font(.caption2)
    .offset(y: 5)
  }

  // MARK: Helpers

  func pauseAnimation() {
    slides[currentIndex].isAnimating = false
  }

  func playAnimation() {
    slides[currentIndex].progress = 0
    slides[currentIndex].isAnimating = true
  }
}

struct OnboardingScreen_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}

private enum L10n {
  static let back = "Back"
  static let skip = "Skip"
  static let login = "Login"
  static let next = "Next"
  static let terms = "Terms of service"
  static let privacy = "Privacy policy"
}
