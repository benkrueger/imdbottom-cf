# data_processing.py
import pandas as pd

# Load datasets
basics = pd.read_csv('data/title.basics.tsv', sep='\t', dtype=str)
ratings = pd.read_csv('data/title.ratings.tsv', sep='\t', dtype=str)

# Filter for movies
movies = basics[basics['titleType'] == 'movie']

# Merge datasets on tconst
merged = pd.merge(movies, ratings, on='tconst')

# Convert averageRating to float and sort
merged['averageRating'] = merged['averageRating'].astype(float)
worst_movies = merged.sort_values('averageRating').head(100)

# Select relevant columns
worst_movies = worst_movies[['primaryTitle', 'startYear', 'averageRating', 'numVotes']]

# Save to JSON
worst_movies.to_json('public/movies.json', orient='records', lines=True)
