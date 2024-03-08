//
//  AddingHapticEffects.swift
//  CupcakeCorner
//
//  Created by Ваня Науменко on 7.03.24.
//

import CoreHaptics
import SwiftUI

struct AddingHapticEffects: View {
    @State private var counter = 0
    @State private var engine: CHHapticEngine?

    var body: some View {
        Button("Tap counter") {
            counter += 1
            print("\(counter)")
        }
        .onAppear(perform: prepareHaptics)
//        // столкновение между двумя мягкими объектами:
//        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter)
//        // интенсивное столкновение двух тяжелых объектов:
//        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
//        .sensoryFeedback(.increase, trigger: counter)
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

#Preview {
    AddingHapticEffects()
}
