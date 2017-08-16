//: ## Convolution
//: Allows you to create a large variety of effects, usually reverbs or environments,
//: but it could also be for modeling.
import AudioKitPlaygrounds
import AudioKit

let file = try AKAudioFile(readFileName: playgroundAudioFiles[0],
                           baseDir: .resources)

let player = try AKAudioPlayer(file: file)
player.looping = true

let bundle = Bundle.main

var dryWetMixer: AKDryWetMixer!
var mixer: AKDryWetMixer!
var dishConvolution: AKConvolution!
var stairwellConvolution: AKConvolution!

if let stairwell = bundle.url(forResource: "Impulse Responses/stairwell", withExtension: "wav"),
    let dish = bundle.url(forResource: "Impulse Responses/dish", withExtension: "wav") {

    stairwellConvolution = AKConvolution(player,
                                         impulseResponseFileURL: stairwell,
                                         partitionLength: 8_192)
    dishConvolution = AKConvolution(player,
                                    impulseResponseFileURL: dish,
                                    partitionLength: 8_192)
}
mixer = AKDryWetMixer(stairwellConvolution, dishConvolution, balance: 0.5)
dryWetMixer = AKDryWetMixer(player, mixer, balance: 0.5)

AudioKit.output = dryWetMixer
AudioKit.start()

stairwellConvolution.start()
dishConvolution.start()

player.play()

class PlaygroundView: AKPlaygroundView {

    override func setup() {
        addTitle("Convolution")

        addSubview(AKResourcesAudioFileLoaderView(
            player: player,
            filenames: playgroundAudioFiles))

        addSubview(AKPropertySlider(
            property: "Dry Audio to Convolved",
            value: dryWetMixer.balance,
            color: AKColor.green
        ) { sliderValue in
            dryWetMixer.balance = sliderValue
        })

        addSubview(AKPropertySlider(
            property: "Stairwell to Dish",
            value: mixer.balance,
            color: AKColor.cyan
        ) { sliderValue in
            mixer.balance = sliderValue
        })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()
