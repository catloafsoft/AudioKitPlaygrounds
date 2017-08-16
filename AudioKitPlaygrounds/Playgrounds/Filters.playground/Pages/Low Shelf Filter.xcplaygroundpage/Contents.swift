//: ## Low Shelf Filter
//:
import AudioKitPlaygrounds
import AudioKit

let file = try AKAudioFile(readFileName: playgroundAudioFiles[0],
                           baseDir: .resources)

let player = try AKAudioPlayer(file: file)
player.looping = true

var lowShelfFilter = AKLowShelfFilter(player)
lowShelfFilter.cutoffFrequency = 80 // Hz
lowShelfFilter.gain = 0 // dB

AudioKit.output = lowShelfFilter
AudioKit.start()
player.play()

//: User Interface Set up

class PlaygroundView: AKPlaygroundView {

    override func setup() {
        addTitle("Low Shelf Filter")

        addSubview(AKResourcesAudioFileLoaderView(
            player: player,
            filenames: playgroundAudioFiles))

        addSubview(AKBypassButton(node: lowShelfFilter))

        addSubview(AKPropertySlider(
            property: "Cutoff Frequency",
            format: "%0.1f Hz",
            value: lowShelfFilter.cutoffFrequency, minimum: 10, maximum: 200,
            color: AKColor.green
        ) { sliderValue in
            lowShelfFilter.cutoffFrequency = sliderValue
        })

        addSubview(AKPropertySlider(
            property: "Gain",
            format: "%0.1f dB",
            value: lowShelfFilter.gain, minimum: -40, maximum: 40,
            color: AKColor.red
        ) { sliderValue in
            lowShelfFilter.gain = sliderValue
        })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()
