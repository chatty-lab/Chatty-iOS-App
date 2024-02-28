//
//  ChatRoomCollectionViewAdapter.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/9/24.
//

import UIKit
import SharedDesignSystem

public protocol ChatCollectionViewAdapterDataSource: AnyObject {

}

public protocol ChatCollectionViewAdapterDelegate: AnyObject {

}

public final class ChatRoomCollectionViewAdapter: NSObject {
  typealias DiffableDataSource = UICollectionViewDiffableDataSource<Int, ChatMessageViewData>
  
  private var collectionView: UICollectionView
  private var diffableDataSource: DiffableDataSource?
  public weak var dataSource: ChatCollectionViewAdapterDataSource?
  public weak var delegate: ChatCollectionViewAdapterDelegate?
  
  public init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    super.init()
    
    self.configureDataSource()
  }
  
  private func configureDataSource() {
    let messageCellRegistration = UICollectionView.CellRegistration<ChatTextMessageCell, ChatMessageViewData> { cell, indexPath, itemIdentifier in
      cell.configureCell(with: itemIdentifier)
    }
    
    diffableDataSource = DiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      let cell = collectionView.dequeueConfiguredReusableCell(using: messageCellRegistration, for: indexPath, item: itemIdentifier)
      return cell
    })
  }
  
  public func applySnapshot(messages: [ChatMessageViewData], animatingDifferences: Bool = true) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, ChatMessageViewData>()
    snapshot.appendSections([0])
    snapshot.appendItems(messages, toSection: 0)
    diffableDataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    
    collectionView.scrollToBottomSkipping()
  }
  
  public func scrollToFlag(to indexPath: IndexPath) {
    collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
  }
}
