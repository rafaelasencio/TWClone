//
//  ProfileFilterView.swift
//  TWClone
//
//  Created by RafaelAsencio on 05/12/2020.
//

import UIKit

private let identifier = "ProfileFilterCell"

protocol ProfileFilterViewDelegate: class {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath)
}

class ProfileFilterView: UIView {
    
    //MARK: - Properties
    weak var delegate: ProfileFilterViewDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: identifier)
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionViewDataSource
extension ProfileFilterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ProfileFilterCell
        let option = ProfileFilterOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate
extension ProfileFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterView(self, didSelect: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let options = CGFloat(ProfileFilterOptions.allCases.count)
        return CGSize(width: frame.width / options, height: frame.height)
    }
    
    //Define spacing between elements in collectionView on ProfileFilterView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


