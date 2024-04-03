//
//  ListViewController.swift
//  TintHW
//
//  Created by Ting on 2024/3/31.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    var viewModel = PhotoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        fetchPhotos()
    }
    
}

extension ListViewController {
    
    private func fetchPhotos () {

        viewModel.fetchPhotos { result in

            switch result {
            case .success(let photos):

                print("Fetched photos: \(photos.count)")

                self.viewModel.photos = photos

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }

            case .failure(let error):
                print("Failed to fetch photos with error: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: TintError.urlMissing.localizedDescription)
            }

            self.activityIndicatorView.stopAnimating()

        }
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        collectionView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let widthCell = screenWidth / 4
        return CGSize(width: widthCell, height: widthCell)
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: (PhotoCollectionViewCell.identifier), for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let photoData = viewModel.photos[indexPath.row]
        
        cell.configuration(model: photoData)
        
        viewModel.loadImage(photoPath: photoData.thumbnailUrl) { image in
           
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
        
        return cell
    }
}

