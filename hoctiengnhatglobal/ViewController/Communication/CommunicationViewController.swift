//
//  CommunicationViewController.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/5/21.
//

import UIKit
import AVFoundation
import CountdownLabel

class CommunicationViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTime: CountdownLabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var sliderTime: UISlider!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    @IBAction func backAction() {
        audioPlayer?.pause()
        dismiss(animated: true, completion: nil)
    }
    
    var isPlayAudio = false
    
    @IBAction func playAction() {
        if isPlayAudio {
            audioPlayer?.pause()
            labelTime.pause()
            isPlayAudio = false
            playButton.setImage(#imageLiteral(resourceName: "play-button 1"), for: .normal)
        }
        else {
            isPlayAudio = true
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            if getListDetail().count > 0 {
                link = getListDetail()[0].sound
                if !link.isEmpty{
                    if audioPlayer == nil {
                        self.loadingView.isHidden = false
                        loadingView.startAnimating()
                        preparePlayAudio(url: URL(string: link)!)
                        self.loadingView.hidesWhenStopped = true
                        self.loadingView.stopAnimating()
                        self.loadingView.isHidden = true
                    }
                    //preparePlayAudio(url: URL(string: link)!)
    //                checkBookFileExists(withLink: link){ [weak self] downloadedURL in
    //                    guard let self = self else{
    //                        return
    //                    }
    //                    self.play(url: downloadedURL)
    //                }
                    audioPlayer?.play()
                    labelTime.start()
                    var timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
                    let _ = labelTime.then(targetTime: 0.1) { [unowned self] in
                        preparePlayAudio(url: URL(string: link)!)
                        isPlayAudio = false
                        playButton.setImage(#imageLiteral(resourceName: "play-button 1"), for: .normal)
                        labelTime.pause()
                    }
                }
            }
        }
    }
    
    func checkBookFileExists(withLink link: String, completion: @escaping ((_ filePath: URL)->Void)){
        let urlString = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        if let url  = URL.init(string: urlString ?? ""){
            let fileManager = FileManager.default
            if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false){

                let filePath = documentDirectory.appendingPathComponent(url.lastPathComponent, isDirectory: false)

                do {
                    if try filePath.checkResourceIsReachable() {
                        print("file exist")
                        completion(filePath)

                    } else {
                        print("file doesnt exist")
                        downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
                    }
                } catch {
                    print("file doesnt exist")
                    downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
                }
            }else{
                 print("file doesnt exist")
            }
        }else{
                print("file doesnt exist")
        }
    }
    
    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data.init(contentsOf: url)
                try data.write(to: filePath, options: .atomic)
                print("saved at \(filePath.absoluteString)")
                DispatchQueue.main.async {
                    completion(filePath)
                }
            } catch {
                print("an error happened while downloading or saving the file")
            }
        }
    }
    
//    func play(url: URL) {
//        print("playing \(url)")
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer.prepareToPlay()
//            audioPlayer.delegate = self
//            audioPlayer.play()
//            let percentage = (audioPlayer.currentTime)/(audioPlayer.duration)
//            DispatchQueue.main.async {
//                // do what ever you want with that "percentage"
//            }
//
//        } catch let error {
//            print(error)
//        }
//
//    }
    
    func preparePlayAudio(url: URL) {
        audioPlayer = AVPlayer(url: url)
        let timeStr = self.audioPlayer?.currentItem?.asset.duration
        labelTime.timeFormat = "mm:ss"
        //labelTime.text = String((timeStr?.positionalTime)!)
        labelTime.setCountDownTime(minutes: CMTimeGetSeconds(timeStr!))
        sliderTime.maximumValue = Float(CMTimeGetSeconds(timeStr!))
    }
    
//    @IBAction func changeAudioTime(_ sender: UISlider) {
//        //labelTime.pause()
//        //audioPlayer?.pause()
//        var currentTime = (audioPlayer?.currentItem?.currentTime().seconds ?? 0.0)
//        CMTimeGetSeconds(audioPlayer?.currentTime())
//        //currentTime =
//        audioPlayer?.play()
//        //labelTime.start()
//    }
    
//    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    var audioPlayer: AVPlayer?
    var listDetail: [DetailCommunication] = [DetailCommunication]()
    var link = ""
    var chuong = 0
    var nameChuong = ""
    var header = 0
    var language: Language = .English
    var isGreenBg = false
    var name = ""

    @objc func updateSlider() {
        sliderTime.value = Float(audioPlayer?.currentItem?.currentTime().seconds ?? 0.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isGreenBg {
            view.backgroundColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
        }
        else {
            view.backgroundColor = #colorLiteral(red: 0.9311450124, green: 0.9643566012, blue: 0.9771550298, alpha: 1)
            labelName.textColor = #colorLiteral(red: 0.08071329445, green: 0.4257110357, blue: 0.4655213952, alpha: 1)
        }
        self.loadingView.isHidden = true
        sliderTime.value = 0.0
        labelName.text = nameChuong
        playView.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        playView.layer.cornerRadius = 10
        self.collectionView.register(UINib(nibName: "CommunicationCLVCell", bundle: nil), forCellWithReuseIdentifier: "CommunicationCLVCell")
        collectionView.backgroundColor = .clear
        CommunicationService.shared.getDataDetail(){ repond,error in
            if let repond = repond{
                self.listDetail = repond
                self.collectionView.reloadData()
            }
        }

        var cellWidth = 0
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellWidth = Int(UIScreen.main.bounds.width) / 5 - 10
        } else {
            cellWidth = Int(UIScreen.main.bounds.width) / 3 - 10
        }
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellWidth, height: (cellWidth * 120) / 90)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        // Do any additional setup after loading the view.
    }
    
    func getListDetail() -> [DetailCommunication]{
        var listDetail: [DetailCommunication] = [DetailCommunication]()
        for item in self.listDetail {
            if item.idChuong == chuong && item.idHeader == header {
                listDetail.append(item)
            }
        }
        return listDetail
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CommunicationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return getListDetail().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunicationCLVCell", for: indexPath) as! CommunicationCLVCell
        if language == .Vietnamese {
            cell.labelName.text = getListDetail()[indexPath.item].tiengViet
        }
        else {
            cell.labelName.text = getListDetail()[indexPath.item].tiengAnh
        }
        cell.phienAm.text = getListDetail()[indexPath.item].phienAm
        cell.labelJpnName.text = getListDetail()[indexPath.item].tiengNhat
        cell.labelNumber.text = String(indexPath.item + 1)
        cell.layer.cornerRadius = 15
        cell.shadowView(alpha: 0.25, x: 2, y: 2, blur: 4)
        return cell
    }
}

extension CommunicationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width/2 - 20, height: 68)
        }
        return CGSize(width: collectionView.frame.width, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
