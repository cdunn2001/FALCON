"""Debugging aids.
"""
import itertools

class FakePool(object):
    """Fake version of multiprocessing.Pool
    """
    def map(self, func, iterable, chunksize=None):
        return map(func, iterable)
    def imap(self, func, iterable, chunksize=None):
        return itertools.imap(func, iterable)
    def __init__(self, *args, **kwds):
        pass
