export const SORT_FUNCTIONS_BY_KEY = {
  "name": (a, b) => {
    return a.hotel.name.localeCompare(b.hotel.name);
  },
  "priceAscend": (a, b) => {
    return a.price - b.price
  },
  "priceDescend": (a, b) => {
    return b.price - a.price
  },
}
