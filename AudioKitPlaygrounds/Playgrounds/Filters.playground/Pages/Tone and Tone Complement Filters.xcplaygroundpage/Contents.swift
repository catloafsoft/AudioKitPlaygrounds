//: ## Tone and Tone Complement Filters
//: ##
import AudioKitPlaygrounds
import AudioKit

let file = try AKAudioFile(readFileName: playgroundAudioFiles[0],
                           baseDir: .resources)

let player = try AKAudioPlayer(file: file)
player.looping = true

var toneFilter = AKToneFilter(player)
var toneComplement = AKToneComplementFilter(toneFilter)

AudioKit.output = toneComplement
AudioKit.start()

player.play()

class PlaygroundView: AKPlaygroundView {

    override func setup() {
        addTitle("Tone Filters")
        addSubview(AKResourcesAudioFileLoaderView(
            player: player,
            filenames: playgroundAudioFiles))

        addLabel("Tone Filter: ")

        addSubview(AKBypassButton(node: toneFilter))

        addSubview(AKPropertySlider(
            property: "Half Power Point",
            value: toneFilter.halfPowerPoint, maximum: 10_000,
            color: AKColor.green
        ) { sliderValue in
            toneFilter.halfPowerPoint = sliderValue
        })

        addLabel("Tone Complement Filter: ")

        addSubview(AKBypassButton(node: toneComplement))

        addSubview(AKPropertySlider(
            property: "Half Power Point",
            value: toneComplement.halfPowerPoint, maximum: 10_000,
            color: AKColor.green
        ) { sliderValue in
            toneComplement.halfPowerPoint = sliderValue
        })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()
