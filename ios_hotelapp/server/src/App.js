import React, { Component, PropTypes } from 'react';
import './App.css';
import { messageSenders } from "./jsAPI";
import { SORT_FUNCTIONS_BY_KEY } from "./sortFunctions";


function sortAndFilter(results, sortId, filters) {
  if (!results) return results;

  const filtered = filters
    ? results.filter((result) => {
      if (filters.priceMax && result.price > filters.priceMax) return false;
      if (filters.priceMin && result.price < filters.priceMin) return false;
      return true;
    })
    : results;

  return sortId
    ? filtered.sort(SORT_FUNCTIONS_BY_KEY[sortId])
    : filtered;
}


class App extends Component {
  render() {
    const sortedFilteredResults = sortAndFilter(
      this.props.results, this.props.sortId, this.props.filters);

    return (
      <div className="App">
        {!this.props.search && (
          <div className="App-notready">Page is not ready yet</div>
        )}
        {this.props.search && !this.props.results && (
          <div className="App-loadingsearch">Loading search results...</div>
        )}
        {this.props.search && this.props.results && (
          <ul className="App-searchresults">
            {sortedFilteredResults.map((result, i) => {
              return (
                <li key={i} onClick={messageSenders.HOTEL_API_HOTEL_SELECTED.bind(this, result)}>
                  <img src={result.hotel.imageURL} alt={`${result.hotel.name} thumbnail`} />
                  <div className="App-searchresults-description">
                    {result.hotel.name}
                  </div>
                  <div className="App-searchresults-price">
                    ${result.price}
                  </div>
                </li>
              );
            })}
          </ul>
        )}
      </div>
    );
  }
}
App.propTypes = {
  search: PropTypes.object,
  results: PropTypes.array,
  sortId: PropTypes.string,
  filters: PropTypes.shape({
    priceMin: PropTypes.number,
    priceMax: PropTypes.number,
  }),
}

export default App;
