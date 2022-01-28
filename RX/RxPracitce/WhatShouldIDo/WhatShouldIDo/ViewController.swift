//
//  ViewController.swift
//  WhatShouldIDo
//
//  Created by 강희성 on 2021/11/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var someThingToDo: Stuffs?
    
    let activityLabel = UILabel()
    let typeLabel = UILabel()
    let participantsLabel = UILabel()
    let priceLabel = UILabel()
    let linkLabel = UILabel()
    let keyLabel = UILabel()
    
    let mainStackView = UIStackView()
    
    let updateButton = UIButton()
    let setButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
        [activityLabel, typeLabel, participantsLabel, priceLabel, linkLabel, keyLabel, updateButton].forEach {
            mainStackView.addArrangedSubview($0)
        }
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        
        updateButton.addTarget(self, action: #selector(updateData), for: .touchUpInside)
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mainStackView.backgroundColor = .brown
        updateButton.setTitle("눌러봐", for: .normal)
    }
    
    func setStuff(data: Stuffs) {
        activityLabel.text = "활동명: " + data.activity
        typeLabel.text = "종류: " + data.type.rawValue
        participantsLabel.text = "필요인원수: " + String(data.participants)
        priceLabel.text = "가격: " + String(data.price)
        linkLabel.text = data.link == "" ? "링크없음" : "링크:" + data.link
    }
    
    @objc func updateData() {
        var urlcomponents = URLComponents()
        urlcomponents.scheme = "https"
        urlcomponents.host = "www.boredapi.com"
        urlcomponents.path = "/api/activity/"
        guard let completeURL = urlcomponents.url else { return }
        
        var urlRequest = URLRequest(url: completeURL)
        urlRequest.httpMethod = "GET"
        getStuff(with: urlRequest) {[weak self] data in
            DispatchQueue.main.async {
                self?.setStuff(data: data)
            }
        }
    }
    
    func getStuff(with: URLRequest, completionBlock: @escaping (Stuffs) -> Void) {
        let task = URLSession.shared.dataTask(with: with) {data, response, error in
            
            guard let response = response as? HTTPURLResponse,
                  let data = data else { return }

            switch response.statusCode {
            case 200..<300:
                guard let stuff = try? JSONDecoder().decode(Stuffs.self, from: data) else { return print(data)}
                completionBlock(stuff)
                print(stuff)
            case 400..<500:
                print("ERROR", URLError(.clientCertificateRejected).localizedDescription)
            case 500..<600:
                print("ERROR", URLError(.badServerResponse).localizedDescription)
            default:
                fatalError()
            }
        }
        task.resume()
    }
}
