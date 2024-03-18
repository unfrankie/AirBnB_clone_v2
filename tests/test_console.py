import unittest
from unittest.mock import patch
from io import StringIO
import os
from console import HBNBCommand


class TestConsoleParamsCreate(unittest.TestCase):
    def setUp(self):
        self.console = HBNBCommand()

    def tearDown(self):
        try:
            os.remove("file.json")
        except FileNotFoundError:
            pass

    @patch('sys.stdout', new_callable=StringIO)
    def test_params_create(self, mock_stdout):
        # Test creating State objects with parameters
        self.console.onecmd("create State name=\"California\"")
        self.console.onecmd("create State name=\"Arizona\"")
        self.assertIn("[State]", mock_stdout.getvalue())
        self.assertIn("[State]", mock_stdout.getvalue())

        # Test creating Place objects with parameters
        self.console.onecmd("create Place city_id=\"0001\" user_id=\"0001\" name=\"My_little_house\" number_rooms=4 number_bathrooms=2 max_guest=10 price_by_night=300 latitude=37.773972 longitude=-122.431297")
        self.assertIn("[Place]", mock_stdout.getvalue())


if __name__ == '__main__':
    unittest.main()
