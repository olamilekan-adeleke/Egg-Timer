import AVFoundation
import UIKit

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    var timer: Timer?
    let timeMap: [String: Int] = ["Soft": 4, "Medium": 7, "Hard": 10]
    var timeleftInSec: Int = 0
    var totalTime: Int = 0

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var progressbar: UIProgressView!

    override func viewDidLoad() {
        progressbar.progress = 0
    }

    @IBAction func onEggButtonPressed(_ sender: UIButton) {
        let buttonTitle: String = sender.currentTitle!

        print("Buttonn Text: \(buttonTitle)")

        titleLabel.text = "Loading..."
        timer?.invalidate()
        progressbar.progress = 0

        timeleftInSec = 0
        totalTime = timeMap[buttonTitle]!

        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { _ in
                self.updateTimer()
            }
        )
    }

    func updateTimer() {
        if timeleftInSec < totalTime {
            timeleftInSec += 1
            progressbar.progress = Float(timeleftInSec) / Float(totalTime)

        } else {
            titleLabel.text = "Done!"
            timer?.invalidate()
            playSound()
            
        }

        print(timeleftInSec)
    }

    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
