# 📱 Capacitor SpotSearch

A simple Capacitor plugin to index and manage iOS Spotlight search items.

<p align="center"><strong><code>@daniele-rolli/capacitor-spotsearch</code></strong></p>

This plugin lets you programmatically add, update, and remove searchable items from iOS Spotlight, using the native [`CoreSpotlight`](https://developer.apple.com/documentation/corespotlight) API.  Supports optional opt-in indexing and provides a Web fallback for testing.

## ✨ Features

- Add (`indexItems`) searchable content to iOS Spotlight
- Delete specific items by ID (`deleteItems`)
- Delete all items in a domain (`deleteDomain`)
- Optional **opt-in** indexing mode for user privacy
- Web plugin fallback (stores items in-memory)

## 📦 Installation

```bash
npm install @daniele-rolli/capacitor-spotsearch
npx cap sync
```

iOS deployment target: **14.0+**

## 🛠 Usage

### Import & Register

```ts
import { SpotSearch } from '@daniele-rolli/capacitor-spotsearch';

// Example: Enable indexing (Web fallback only)
await SpotSearch.enableIndexing?.(true);
```

### Index Items

```ts
import { SpotSearch } from '@daniele-rolli/capacitor-spotsearch';

await SpotSearch.indexItems({
  items: [
    {
      id: 'article-123',
      domain: 'news',
      title: 'Breaking News: Cats Take Over',
      snippet: 'A mysterious feline uprising...',
      keywords: ['cats', 'news', 'funny'],
      url: 'https://example.com/cats',
      thumbnailBase64: 'iVBORw0KGgoAAAANSUhEUgAA...', // optional
      extra: { category: 'animals' },
    },
  ],
});
```

### Delete Specific Items

```ts
await SpotSearch.deleteItems({
  ids: ['article-123', 'article-456'],
});
```

### Delete All Items in a Domain

```ts
await SpotSearch.deleteDomain({
  domain: 'news',
});
```

## 📚 API

### **SpotItem**

| Field             | Type                  | Required | Description                                 |
| ----------------- | --------------------- | -------- | ------------------------------------------- |
| `id`              | `string`              | ✅       | Unique item identifier                      |
| `domain`          | `string`              | ✅       | Logical grouping (e.g., `news`, `products`) |
| `title`           | `string`              | ✅       | Main display title                          |
| `snippet`         | `string`              | ❌       | Short description for Spotlight             |
| `keywords`        | `string[]`            | ❌       | Keywords to improve search                  |
| `url`             | `string`              | ❌       | Deep link or website URL                    |
| `thumbnailBase64` | `string`              | ❌       | Base64 thumbnail image                      |
| `extra`           | `Record<string, any>` | ❌       | Additional metadata                         |

---

### **Methods**

#### `indexItems(options: IndexItemsOptions): Promise<void>`

Indexes an array of `SpotItem` objects.

#### `deleteItems(options: DeleteItemsOptions): Promise<void>`

Deletes items by their unique IDs.

#### `deleteDomain(options: DeleteDomainOptions): Promise<void>`

Deletes all items within a given domain.

#### _(Web only)_ `enableIndexing(enabled: boolean): Promise<void>`

Opt-in to allow Web plugin indexing. Defaults to `false`.

## 🖥 Web Fallback

- Stores items in memory (`Map`) for development/testing.
- Requires calling `enableIndexing(true)` before adding items.

## 📱 iOS Notes

- Uses [`CSSearchableItem`](https://developer.apple.com/documentation/corespotlight/cssearchableitem) and [`CSSearchableIndex`](https://developer.apple.com/documentation/corespotlight/cssearchableindex).
- Images are provided via `thumbnailBase64`.
- Deleting a domain removes all items indexed under it.

## 📄 License

[MIT](./LICENSE)

**Author:** Daniele Rolli
