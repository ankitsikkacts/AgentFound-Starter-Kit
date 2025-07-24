import unittest
from pymongo import MongoClient
from pymongo.errors import ConnectionFailure

class TestMongoDBConnection(unittest.TestCase):
    def setUp(self):
        # Replace with your MongoDB URI
        self.mongo_uri = "mongodb://localhost:27017"
        self.client = MongoClient(self.mongo_uri, serverSelectionTimeoutMS=5000)

    def test_connection_handshake(self):
        try:
            # The ismaster command is cheap and does not require auth
            server_info = self.client.admin.command('ismaster')
            self.assertTrue(server_info['ismaster'])
            print("MongoDB connection handshake successful.")
        except ConnectionFailure:
            self.fail("MongoDB connection handshake failed.")

    def tearDown(self):
        self.client.close()

if __name__ == '__main__':
    unittest.main()
