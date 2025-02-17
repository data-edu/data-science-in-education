library(bskyr)
library(tidyverse)

auth <- bs_auth(user = bs_get_user(), pass = bs_get_pass())

# Search for posts with the hashtag 'rstats'
posts <- bs_search_posts(query = "#rstats", auth = auth)

# Unnest the 'author' column to extract handle and display name
posts_clean <- posts %>%
    unnest_wider(author, names_sep = "_") %>%
    rename(
        author_did = author_did,
        author_handle = author_handle,
        author_display_name = author_displayName
    )

# Unnest the 'record' column to extract post text
posts_clean <- posts_clean %>%
    unnest_wider(record, names_sep = "_") %>%
    rename(
        post_text = record_text,
        post_created_at = record_createdAt
    )

posts_clean

# Extract image URLs from the 'embed' column
posts_clean <- posts_clean %>%
    mutate(
        image_urls = map(embed, ~ {
            if (!is.null(.x) && "images" %in% names(.x)) {
                return(map_chr(.x$images, "fullsize"))
            } else {
                return(NA_character_)
            }
        })
    )

# Select and arrange relevant columns
posts_clean <- posts_clean %>%
    select(
        uri,
        author_handle,
        author_display_name,
        post_text,
        post_created_at,
        reply_count,
        repost_count,
        like_count,
        image_urls
    )

# View the cleaned posts data
glimpse(posts_clean)
View(posts_clean)
