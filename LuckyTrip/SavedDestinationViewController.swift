//
//  SavedDestination.swift
//  LuckyTrip
//
//  Created by Abdullah Munzer on 07/08/2022.
//

import UIKit

protocol SavedDestinationScreenRouter: LTRouter {

    static func routeToSavedDestination(from context: BaseViewController)
}

extension SavedDestinationScreenRouter {
    static func routeToSavedDestination(from context: BaseViewController) {

        let controller = SavedDestinationViewController.instantiate()
        push(controller, from: context)
    }
}

extension AppRouter: SavedDestinationScreenRouter { }

class SavedDestinationViewController: BaseViewController, StoryboardBased {
    static var storyboardName: String {
        return "Main"
    }

    @IBOutlet weak var lblSelectedDestinationCount: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblSelectedDestinationCount.text = "Saved Destination \(UserDefaultsManager.shared.savedDestination.count)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension SavedDestinationViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultsManager.shared.savedDestination.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedDestinationTableViewCell", for: indexPath) as? SavedDestinationTableViewCell  else {
            return UITableViewCell()
        }
        
        let destination = UserDefaultsManager.shared.savedDestination[indexPath.row]
        cell.cellSetup(destination: destination)
        return cell
    }
}
