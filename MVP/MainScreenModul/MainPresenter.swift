//
//  Presenter.swift
//  MVP
//
//  Created by Георгий Евсеев on 3.05.24.
//

import UIKit

protocol IMainPresenter: AnyObject {
    func parse(data: Data)
    func buttonPressed()
}

protocol MainPresenterDelegate: AnyObject {
    func setLabelText(_ text: String)
}

final class MainPresenter {
    
    weak var delegate: MainPresenterDelegate?
    private let router: IMainRouter? = MainRouter()
    var networkManager: INetworkManager? = NetworkManager()
}

extension MainPresenter: IMainPresenter {
    func parse(data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data) as? [Any] {
            delegate?.setLabelText("json: \(json)")
        }
    }

    func buttonPressed() {
        networkManager?.sendRequest(adress: UrlString().baseUrlString, completion: { data, _ in
            if let data = data {
                self.parse(data: data)
            }
        })
    }
}



