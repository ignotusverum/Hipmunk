/**
 * Exports data-fetching functions that return promises.
 * 
 * All the data is fake, but there are artificial delays.
 */

function randomChoice(items) {
    return items[Math.floor(Math.random()*items.length)];
}

function createHotelName(location) {
    const prefix = Math.random() < 0.2 ? "The " : "";

    const adjective = randomChoice([
        'Grand ', 'Downtown ', 'Cozy ', 'Super ',
        '', '', '', '', '', '',
    ]);

    const chain = randomChoice([
        'Vacation Inn ', 'Skywood ', 'Merryott ', 'Motel 7 ', 'Canwood ',
        'Munk ', 'Hip ', 'Hyp ',
    ]);

    const suffix = randomChoice([
        ' Hotel', ' Inn', ' Lodge', ' Bed & Breakfast', '',
    ]);

    const maybeLocation = Math.random() < 0.2 ? location : '';

    return `${prefix}${adjective}${chain}${maybeLocation}${suffix}`.trim();
}

function createHotelAddress(location) {
    const number = 10 + Math.floor(Math.random() * 9990);
    const streetName = randomChoice([
        "Kaplan St",
        "Johnson Ave",
        "Taskova Ln",
        "Vu Blvd",
        "Ruppenstein Pl",
        "Dhimes Rd",
    ]);
    const zipCode = 10000 + Math.floor(Math.random() * 89999);
    return `${number} ${streetName}\n${location} ${zipCode}`;
}

function createDummyHotelResult(hotelId, location) {
    const name = createHotelName(location);
    return {
        hotel: {
            id: hotelId,
            imageURL: `http://lorempixel.com/100/100/city/${hotelId}`,
            name,
            address: createHotelAddress(location),
        },
        price: Math.floor(20 + Math.random() * 1000),
    }
}

function fetchDummyHotelResults(location) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            const results = [];
            for (let i = 0; i < 50; i++) {
                results.push(createDummyHotelResult(i, location));
            }
            resolve(results);
        }, 3000);
    });
}

function fetchHotelRating(hotelId) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve(Math.floor(1 + Math.random() * 4.9999));
        }, Math.random() * 10000);
    });
}

export {
    fetchDummyHotelResults,
    fetchHotelRating,
}