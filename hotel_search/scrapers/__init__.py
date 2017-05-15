from hotel_search.scrapers.expedia import ExpediaScraper
from hotel_search.scrapers.orbitz import OrbitzScraper
from hotel_search.scrapers.priceline import PricelineScraper
from hotel_search.scrapers.travelocity import TravelocityScraper
from hotel_search.scrapers.hilton import HiltonScraper


SCRAPERS = [
    ExpediaScraper,
    OrbitzScraper,
    PricelineScraper,
    TravelocityScraper,
    HiltonScraper,
]
SCRAPER_MAP = {s.provider.lower(): s for s in SCRAPERS}


def get_scraper(provider):
    return SCRAPER_MAP.get(provider.lower())
