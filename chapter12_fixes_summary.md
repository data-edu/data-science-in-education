# Chapter 12 Code Review Summary

## Date: 2026-01-05

## Issues Found and Fixed

### 1. **extract-data chunk: Incorrect use of map_chr() after unnest()** (Line 335-336)
**Problem:** After unnesting facets, the code tried to use `map_chr()` on individual facet elements as if they were still lists.

**Original Code:**
```r
mutate(
  feature_type = map_chr(facets, ~pluck_chr(.x, "features", 1, "$type")),
  to = map_chr(facets, ~pluck_chr(.x, "features", 1, "did"))
)
```

**Fixed Code:**
```r
rowwise() %>%
mutate(
  feature_type = pluck_chr(facets, "features", 1, "$type"),
  to = pluck_chr(facets, "features", 1, "did")
) %>%
ungroup() %>%
```

**Solution:** Added `rowwise()` before the mutation to process each row individually, then `ungroup()` after.

---

### 2. **extract-data chunk: Incorrect column reference for reply edges** (Line 320)
**Problem:** Code tried to access a `reply` column that doesn't exist at the top level of the posts data frame.

**Original Code:**
```r
reply_edges <- posts %>%
  mutate(
    from = map_chr(author, ~pluck_chr(.x, "did")),
    to = map_chr(reply, ~pluck_chr(.x, "parent", "author", "did"))
  )
```

**Fixed Code:**
```r
reply_edges <- posts %>%
  mutate(
    from = map_chr(author, ~pluck_chr(.x, "did")),
    # Extract parent URI from record$reply$parent$uri and extract DID from it
    parent_uri = map_chr(record, ~pluck_chr(.x, "reply", "parent", "uri")),
    to = str_extract(parent_uri, "did:[^/]+")
  )
```

**Solution:**
- Extract the parent URI from `record$reply$parent$uri`
- Use `str_extract()` to extract the DID from the URI using regex pattern `"did:[^/]+"`

---

## Test Results

All code chunks tested successfully:
- ✅ API Authentication working
- ✅ Data collection from Bluesky API working (tested with 4 posts)
- ✅ Loading saved posts.rds (575 posts)
- ✅ Node extraction (125 unique users)
- ✅ Reply edge extraction (43 edges)
- ✅ Mention facet edge extraction (49 edges)
- ✅ Combined edges (62 total, 31 valid after filtering)
- ✅ Graph construction successful
- ✅ Network metrics calculation working
- ✅ Visualization code working

## Data Structure Notes

### Posts data frame columns:
- `uri`, `cid`, `author`, `record`, `embed`
- `bookmark_count`, `reply_count`, `repost_count`, `like_count`, `quote_count`
- `indexed_at`, `viewer`, `labels`, `cursor`

### Nested structures:
- **Author info**: `author$did`, `author$handle`, `author$displayName`
- **Reply info**: `record$reply$parent$uri` (contains DID in URI format)
- **Mention info**: `record$facets[[i]]$features[[1]]$did`
- **Post text**: `record$text`

### Network statistics from test run:
- 125 unique users (nodes)
- 62 total interactions (edges)
- 31 valid edges after filtering for unknown endpoints and self-loops
- 15 edges dropped due to unknown endpoints
- Top user by in-degree: "Nicola Rennie" (6 mentions received)

## Recommendations

1. The code now correctly handles the Bluesky API data structure
2. All edge extraction methods work as expected
3. Graph construction and visualization are functioning properly
4. Consider adding error handling for cases where the API structure changes
5. The `eval=FALSE` flags on API chunks are appropriate to prevent hitting rate limits during book builds
