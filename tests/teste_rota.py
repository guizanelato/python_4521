import unittest

from app import app as flaskapp

class TesteRota(unittest.TestCase):
    def setUp(self):
        app = flaskapp.test_client()
        self.response = app.get('/')

    def test_getRota(self):
        self.assertEqual(200, self.response.status_code)
