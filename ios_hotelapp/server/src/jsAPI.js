/**
 * Defines the JS/message API for use by the iOS app.
 * 
 * There are two sides to this API: the JS function call side, and the message side.
 * The app controls the page by calling JS functions. The app knows what is happening
 * on the page by listening to messages.
 */

import postMessage from './postMessage';
import parseDate from './parseDate';
import {fetchDummyHotelResults} from './data';
import {SORT_FUNCTIONS_BY_KEY} from "./sortFunctions";

const messageSenders = {};
const jsAPI = {};


/** FUNCTIONS YOU CAN CALL */


/**
 * @param {function} setState       `HotelWithAPI` state updating function
 * @param {object} param
 * @param {String} param.location   Arbitrary location string
 * @param {String} param.dateStart  "YYYY-MM-DD"
 * @param {String} param.dateEnd    "YYYY-MM-DD"
 * @returns {Promise}
 */
jsAPI.runHotelSearch = (setState, {location, dateStart, dateEnd}) => {
    if (!location || !dateStart || !dateEnd) {
        throw new Error("Must specify location (string), dateStart ('YYYY-MM-DD'), and dateEnd.")
    }
    
    const search = {location, dateStart: parseDate(dateStart), dateEnd: parseDate(dateEnd)};
    setState({search});
    messageSenders.HOTEL_API_SEARCH_READY(search);

    fetchDummyHotelResults(search.location)
        .then((results) => {
            setState({results});
            messageSenders.HOTEL_API_RESULTS_READY(results);
        });
}


jsAPI.setHotelSort = (setState, sortId) => {
    if (sortId && !SORT_FUNCTIONS_BY_KEY[sortId]) {
        throw new Error("Invalid sort ID: " + sortId);
    }
    setState({sortId});
}


jsAPI.setHotelFilters = (setState, filters) => {
    setState({filters});
}


/** MESSAGES YOU CAN BE SENT */


/**
 * The API under `namespace` is ready to be used
 * @param {String} namespace
 */
messageSenders.API_READY = (namespace) => {
    postMessage('API_READY', {namespace});
};

/**
 * The hotel search service has parsed and understood the hotel search
 * @param {object} search
 * @param {String} search.location
 * @param {String} search.dateStart
 * @param {String} search.dateEnd
 */
messageSenders.HOTEL_API_SEARCH_READY = (search) => {
    postMessage('HOTEL_API_SEARCH_READY', {search});
};

/**
 * The hotel results are now visible
 * @param {object[]} results
 */
messageSenders.HOTEL_API_RESULTS_READY = (results) => {
    postMessage('HOTEL_API_RESULTS_READY', {results});
};

/**
 * A hotel result has been selected by the user
 * @param {object} result
 * @param {Number} result.id
 * @param {String} result.imageURL
 * @param {String} result.name
 * @param {String} result.address
 */
messageSenders.HOTEL_API_HOTEL_SELECTED = (result) => {
    postMessage('HOTEL_API_HOTEL_SELECTED', {result});
}


/* INTERNALS YOU CAN IGNORE */


/**
 * Populate `host[namespace]` with the contents of `jsAPI`.
 * When state updates are made, call `setStateCallback(newState)`.
 * @param {Object} host 
 * @param {String} namespace 
 * @param {Function} setStateCallback 
 */
function bindJSNamespace(host, namespace, setStateCallback) {
    const boundNamespace = {};
    for (const key of Object.keys(jsAPI)) {
        boundNamespace[key] = jsAPI[key].bind(this, setStateCallback);
    }
    host[namespace] = boundNamespace;
}

export {
    bindJSNamespace,
    messageSenders,
}