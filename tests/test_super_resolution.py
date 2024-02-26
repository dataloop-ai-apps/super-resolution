import os
import unittest
import dtlpy as dl

from modules.super_resolution import ServiceRunner


class Node:
    def __init__(self, metadata):
        self.metadata = metadata


class TestRunner(unittest.TestCase):
    def setUp(self):
        self.runner = ServiceRunner()
        self.item = dl.items.get(item_id='658ae4cd160fb30cdebf1156')
        self.context = dl.Context()

    def test_super_resolution(self):
        self.context._node = Node(metadata={'customNodeConfig': {'weights': 'gans'}})
        super_resolution_item = self.runner.super_res(item=self.item, context=self.context)
        self.assertIsInstance(super_resolution_item, dl.Item)
        self.assertEqual(super_resolution_item.height, 480)
        self.assertEqual(super_resolution_item.width, 500)
        self.assertEqual(super_resolution_item.dir, f"/super_resolution/gans{self.item.dir}")
        self.assertEqual(super_resolution_item.name, self.item.name)
        self.assertEqual(super_resolution_item.metadata['system']['originalItemId'], self.item.id)


if __name__ == "__main__":
    unittest.main()
