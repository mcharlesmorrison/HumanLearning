## Using Article Persistence

### Persisting 'Saved' and 'Read' Articles
Assuming we have a list of articles: [Article], then
```swift
// Persist articles to read articles
UserArticles.persist(articles: articles, .read)

// Persist articles to saved articles
UserArticles.persist(articles: articles, .saved)
```

### Reading 'Saved' and 'Read' Articles
```swift
// The list of user saved articles
let readArticles = UserArticles.get(.read)!

// The list of user saved articles
let savedArticles = UserArticles.get(.saved)!
```

