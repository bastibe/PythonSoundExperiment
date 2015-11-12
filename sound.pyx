import time
from sound cimport Player, Chunk, Stopped, Paused, Playing
import numpy
cimport numpy

cdef cbool __callback__(object self, Chunk &chunk) with gil:
    """Fill `chunk` with whatever `self.callback` returns.

    This has to be a C function in order to comply with the
    `playerCallback` function pointer definition. Still, it acts as if
    it was a method on `SoundPlayer`.

    """
    cdef numpy.ndarray[signed short, ndim=1, mode="c"] data
    data = (<SoundPlayer>self)._callback()
    chunk.samples = <Int16 *>data.data
    chunk.sampleCount = len(data)
    return <cbool>len(data) > 0

cdef class SoundPlayer:
    """Play queued sounds.

    This class wraps a subclass of `SFML:Audio:SoundStream` that
    manages a queue of audio signals and plays them one by one.

    Use `play` to queue up audio signals, and use `isplaying` to check
    if anything is currently playing.

    """
    cdef Player *thisptr
    cdef list queue
    cdef list playing

    def _callback(self):
        """Return a signal from `queue` or an empty array."""
        if not self.queue:
            self.playing = []
            return numpy.zeros(0, dtype='int16')
        self.playing = [self.queue.pop(0)]
        return self.playing[0]

    def __cinit__(self, samplerate, channelcount):
        self.queue = []
        self.playing = []
        self.thisptr = new Player(self, &__callback__, samplerate, channelcount)

    def __dealloc__(self):
        del self.thisptr

    def play(self, data):
        """Convert `data` to C contiguous int16 and append to queue.

        Also starts playback if not already started.

        """
        if numpy.issubdtype(data.dtype, numpy.floating):
            data *= 2**15
        data = numpy.ascontiguousarray(data.ravel(), 'int16')
        self.queue.append(data)
        if not self.isplaying:
            self.thisptr.play()

    @property
    def isplaying(self):
        return self.thisptr.getStatus() == Playing
