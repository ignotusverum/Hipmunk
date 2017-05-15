/**
 * Parse `"YYYY-MM-DD"` strings into JS `Date` objects
 * @param {String} str 
 * @returns {Date}
 */
export default function parseDate(str) {
    if(!/^\d\d\d\d-\d\d-\d\d$/.test(str)) {
        throw new Error("Invalid date");
    }
    var parts = str.split("-");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}