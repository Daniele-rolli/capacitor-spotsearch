import Capacitor
import CoreSpotlight
import UniformTypeIdentifiers

@objc(SpotSearch)
public class SpotSearch: CAPPlugin {

  @objc func indexItems(_ call: CAPPluginCall) {
    guard let items = call.getArray("items", Any.self) as? [[String: Any]] else {
      call.reject("Missing items"); return
    }

    var searchable: [CSSearchableItem] = []

    for obj in items {
      guard let id = obj["id"] as? String,
            let domain = obj["domain"] as? String,
            let title = obj["title"] as? String else { continue }

      let attrs = CSSearchableItemAttributeSet(contentType: .text)
      attrs.title = title
      attrs.contentDescription = obj["snippet"] as? String
      attrs.keywords = obj["keywords"] as? [String]
      if let urlStr = obj["url"] as? String { attrs.contentURL = URL(string: urlStr) }
      if let thumb = obj["thumbnailBase64"] as? String,
         let data = Data(base64Encoded: thumb) { attrs.thumbnailData = data }

      let item = CSSearchableItem(uniqueIdentifier: id,
                                  domainIdentifier: domain,
                                  attributeSet: attrs)
      searchable.append(item)
    }

    CSSearchableIndex.default().indexSearchableItems(searchable) { error in
      if let e = error { call.reject(e.localizedDescription) } else { call.resolve() }
    }
  }

  @objc func deleteItems(_ call: CAPPluginCall) {
    let ids = call.getArray("ids", String.self) ?? []
    CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: ids) { e in
      if let e = e { call.reject(e.localizedDescription) } else { call.resolve() }
    }
  }

  @objc func deleteDomain(_ call: CAPPluginCall) {
    guard let domain = call.getString("domain") else { call.reject("Missing domain"); return }
    CSSearchableIndex.default().deleteSearchableItems(withDomainIdentifiers: [domain]) { e in
      if let e = e { call.reject(e.localizedDescription) } else { call.resolve() }
    }
  }
}
