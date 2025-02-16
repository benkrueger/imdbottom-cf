// src/worker.js
async function handleRequest(request) {
    const apiUrl = 'https://datasets.imdbws.com/title.ratings.tsv.gz';
    const response = await fetch(apiUrl);
    const data = await response.text();

    // Process the TSV data
    const lines = data.split('\n');
    const movies = lines.slice(1).map(line => {
        const [tconst, averageRating, numVotes] = line.split('\t');
        return { tconst, averageRating: parseFloat(averageRating), numVotes: parseInt(numVotes) };
    });

    // Sort and select the worst 100 movies
    const worstMovies = movies.sort((a, b) => a.averageRating - b.averageRating).slice(0, 100);

    return new Response(JSON.stringify(worstMovies), {
        headers: { 'Content-Type': 'application/json' },
    });
}

addEventListener('fetch', event => {
    event.respondWith(handleRequest(event.request));
});
