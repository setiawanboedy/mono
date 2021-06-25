import pymongo
import urllib


class BudiMongo():

    def __init__(self):
        """Constructor for Budipest's MongoDB service"""
        self.database = None
        self.define_database()

    def define_database(self):
        """Define class property database for DB manipulation"""
        username = urllib.parse.quote_plus('readOnly')
        password = urllib.parse.quote_plus('WvCaQxHHOkmTrC3f')
        client = pymongo.MongoClient(
            f"mongodb+srv://{username}:{password}@budipest.kp4bq.mongodb.net/")
        self.database = client.budipest

    def get_old_toilets(self):
        """Get all toilets from database"""
        all_toilets = [t for t in self.database.toilets.find()]

        return all_toilets
