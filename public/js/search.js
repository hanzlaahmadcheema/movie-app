//Search
document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('search-input');
    const searchSuggestions = document.getElementById('search-suggestions');
    
    let timeout = null;
    
    searchInput.addEventListener('input', function() {
        const query = this.value.trim();
        
        if (query.length > 0) {
            if (timeout) {
                clearTimeout(timeout);
            }
            
            timeout = setTimeout(() => {
                fetch(`/search/suggest?keyword=${encodeURIComponent(query)}`)
                    .then(response => response.json())
                    .then(data => {
                        displaySuggestions(data);
                    })
                    .catch(error => {
                        console.error('Error fetching suggestions:', error);
                    });
            }, 300); // Debounce delay
        } else {
            searchSuggestions.style.display = 'none';
        }
    });
    
    function displaySuggestions(data) {
        searchSuggestions.innerHTML = ''; // Clear previous suggestions
        
        if (data.results.length > 0) {
            data.results.slice(0, 5).forEach(item => {
                const suggestionItem = document.createElement('a');
                suggestionItem.href = item.media_type === 'movie' ? `/watch-movie/${item.id}` : `/watch-series/${item.id}`;
                suggestionItem.classList.add('nav-item');
                
                suggestionItem.innerHTML = `
                    <div class="film-thumbnail">
                        <img src="https://image.tmdb.org/t/p/w200/${item.poster_path}" class="film-thumbnail-img" alt="${item.title || item.name}" onerror="this.onerror=null;this.src='https://www.ha-entertainment.com/images/header.jpg';">
                    </div>
                    <div class="is-detail">
                        <h3 class="film-name heading-xs">${item.title || item.name}</h3>
                        <div class="d-flex align-items-center film-info">
                            <span>${item.media_type === 'movie' ? 'Movie' : 'TV Series'}</span>
                            <span class="dot"></span>
                            <span class="imdb"><i class="fas fa-star mr-2"></i>${item.vote_average.toFixed(1)}</span>
                            <span class="dot"></span>
                            <span>${item.release_date ? new Date(item.release_date).getFullYear() : new Date(item.first_air_date).getFullYear()}</span>
                        </div>
                    </div>
                `;
                
                searchSuggestions.appendChild(suggestionItem);
            });
            
            if (data.results.length > 5) {
                const viewMoreLink = document.createElement('a');
                viewMoreLink.href = `/search?keyword=${encodeURIComponent(searchInput.value.trim())}`;
                viewMoreLink.classList.add('nav-item', 'nav-all');
                viewMoreLink.textContent = 'View more';
                
                searchSuggestions.appendChild(viewMoreLink);
            }
            
            searchSuggestions.style.display = 'block';
        } else {
            searchSuggestions.style.display = 'none';
        }
    }
});

function applyFilters() {
    const genre = document.getElementById('genre-filter').value;
    const country = document.getElementById('country-filter').value;
    const quality = document.getElementById('quality-filter').value;
    const year = document.getElementById('year-filter').value;
    const sort = document.getElementById('sort-filter').value;

    // Build the query string
    const queryString = new URLSearchParams({
        genre,
        country,
        quality,
        year,
        sort
    }).toString();

    // Redirect to the results page with filters as query parameters
    window.location.href = `/results?${queryString}`;
}

//Dropdown Overview
document.addEventListener('DOMContentLoaded', function() {
    var toggleButton = document.getElementById('toggle-desc');
    var dropdownMenu = document.querySelector('.desc-more .dropdown-menu');

    toggleButton.addEventListener('click', function() {
        dropdownMenu.classList.toggle('show');
    });

    // Optional: Close the dropdown when clicking outside of it
    document.addEventListener('click', function(event) {
        if (!toggleButton.contains(event.target) && !dropdownMenu.contains(event.target)) {
            dropdownMenu.classList.remove('show');
        }
    });
});

