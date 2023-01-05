//
//  OnboardingItem.swift
//  OnboardingWalkthroughPage
//
//  Created by Kamil Chlebuś on 04/01/2023.
//

import Foundation

struct OnboardingSlide: Identifiable, Equatable {
  let id: UUID = .init()
  let title: String
  let subtitle: String
  let animationName: String

  // State/Binding
  var isAnimating: Bool = false
  var progress: CGFloat = 0

  static var list: [OnboardingSlide] = [
    .init(
      title: "Request Pickup",
      subtitle: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time",
      animationName: "Pickup"
    ),
    .init(
      title: "Track Delivery",
      subtitle: "The best part starts when our courier is on the way to your location, as you will get real time notifications as to the exact location of the courier",
      animationName: "Transfer"
    ),
    .init(
      title: "Receive Package",
      subtitle: "The journey ends when your package get to it's location. Get notified immediately your package is received at its intended location",
      animationName: "Delivery"
    )
  ]
}
