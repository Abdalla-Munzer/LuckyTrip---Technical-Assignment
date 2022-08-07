//
//  HomeViewController.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 06/08/2022.
//

import UIKit
import AVKit
import AVFoundation
import HCVimeoVideoExtractor

class HomeViewController: BaseViewController, StoryboardBased {
    static var storyboardName: String {
        return "Main"
    }

    @IBOutlet weak var destinationCollectionView: UICollectionView!
    @IBOutlet weak var destinatioSearchBar: UISearchBar?

    @IBOutlet weak var btnShowSavedDestination: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnSort: UIButton!

    let sessionProvider = URLSessionProvider()
    var destinationModel: DestinationModel?
    var destinationModelSearch: DestinationModel?
    var destinationsToSave = [Destination]()

    override func viewDidLoad() {
        super.viewDidLoad()

        destinatioSearchBar?.delegate = self
        self.definesPresentationContext = true
        destinationCollectionView.allowsMultipleSelection = true
        btnShowSavedDestination.isHidden = UserDefaultsManager.shared.savedDestination.isEmpty
        getListOfDestinations()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func getListOfDestinations() {
        loaderView.startAnimating()
        sessionProvider.request(type: DestinationModel.self, service: DestinationsService.getListOfDestinations) { response in
            DispatchQueue.main.async {
                self.loaderView.stopAnimating()
                switch response {
                case let .success(destinationModel):
                    if destinationModel.destinations.isEmpty {
                        self.showError(message: "No result Try agin")
                        return
                    }
                    self.destinationModel = destinationModel
                    self.destinationCollectionView.reloadData()
                case .failure:
                    self.showError(message: "Try agin later")
                case let .apiFailure(error):
                    self.showError(message: error.errorDetails.searchType.first ?? "Try agin later")
                }
            }
        }
    }
    func searchForDestinations(searchValue: String) {
        loaderView.startAnimating()
        sessionProvider.request(type: DestinationModel.self, service: DestinationsService.searchForDestinations(searchValue: searchValue)) { response in            DispatchQueue.main.async {
            self.loaderView.stopAnimating()
            switch response {
            case let .success(destinationModel):
                if destinationModel.destinations.isEmpty {
                    self.showError(message: "No result Try agin")
                    return
                }
                self.destinationModel = destinationModel
                self.destinationCollectionView.reloadData()
            case .failure:
                self.showError(message: "Try agin later")
            case let .apiFailure(error):
                self.showError(message: error.errorDetails.searchType.first ?? "Try agin later")
            }
        }
        }
    }

    func playVideo(url: URL) {
        HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { [weak self] ( video: HCVimeoVideo?, error: Error?) -> Void in
            guard let self = self else { return }

            if let err = error {
                self.showAlertWith(title: "", message: err.localizedDescription, actions: [UIAlertAction(title: "Done", style: .destructive, handler: nil)])
                return
            }

            guard let vid = video else { return }

            if let videoURL = vid.videoURL[.Quality360p] {
                DispatchQueue.main.async {
                    let player = AVPlayer(url: videoURL)
                    let playerController = AVPlayerViewController()
                    playerController.player = player
                    self.present(playerController, animated: true) {
                        player.play()
                    }
                }
            }
        })
    }

    @IBAction func sortBtnTapped(_ sender: Any) {
        if let sortedDestination = destinationModel?.destinations {
            destinationModel?.destinations = sortedDestination.sorted { (destination1, destination2) -> Bool in
                let destination1 = destination1.countryName ?? ""
                let destination2 = destination2.countryName ?? ""
                return (destination1.localizedCaseInsensitiveCompare(destination2) == .orderedAscending)
            }
            destinationCollectionView.reloadData()
        }
    }

    @IBAction func saveBtnTapped(_ sender: Any) {
        UserDefaultsManager.shared.savedDestination = destinationsToSave
        let action = UIAlertAction.init(title: "Done", style: .cancel, handler: nil)
        showAlertWith(title: "Success", message: "Your destinations had been saved", actions: [action])
        btnShowSavedDestination.isHidden = false
    }

    @IBAction func savedDistenationsTapped(_ sender: UIButton) {
        AppRouter.routeToSavedDestination(from: self)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return destinationModel?.destinations.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCollectionViewCell", for: indexPath) as? DestinationCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let destination = destinationModel?.destinations[indexPath.row] {
            cell.cellSetup(destination: destination)
            cell.clouserPlayBtnTapped  = { [weak self] _ in
                if let url = URL(string: destination.destinationVideo?.url ?? "") {
                    self?.playVideo(url: url)
                }
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let destination = destinationModel?.destinations[indexPath.row] {
            destinationsToSave.append(destination)
        }

        if destinationsToSave.count >= 3 {
            btnSave.isHidden = false
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let destination = destinationModel?.destinations[indexPath.row] {
            if let index = destinationsToSave.firstIndex(where: { $0.id == destination.id }) {
                destinationsToSave.remove(at: index )
            }
        }
        if destinationsToSave.count  < 3 {
            btnSave.isHidden = true
        }
    }
}

extension HomeViewController: UISearchBarDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.trimmingCharacters(in: .whitespaces) == ""{
            getListOfDestinations()
        } else {
            searchForDestinations(searchValue: searchBar.text ?? "")
        }
        self.view.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getListOfDestinations()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
