//: ## Phase-Locked Vocoder
//: A different kind of time and pitch stretching
import AudioKitPlaygrounds
import AudioKit

let file = try AKAudioFile(readFileName: "guitarloop.wav",
                           baseDir: .resources)
let phaseLockedVocoder = AKPhaseLockedVocoder(file: file)

AudioKit.output = phaseLockedVocoder
AudioKit.start()
phaseLockedVocoder.start()
phaseLockedVocoder.amplitude = 1
phaseLockedVocoder.pitchRatio = 1

var timeStep = 0.1

class PlaygroundView: AKPlaygroundView {

    // UI Elements we'll need to be able to access
    var playingPositionSlider: AKPropertySlider?

    override func setup() {

        addTitle("Phase Locked Vocoder")

        playingPositionSlider = AKPropertySlider(
            property: "Position",
            format: "%0.2f s",
            value: phaseLockedVocoder.position, maximum: 3.428,
            color: AKColor.yellow
        ) { sliderValue in
            phaseLockedVocoder.position = sliderValue
        }
        addSubview(playingPositionSlider)
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()
