import soundfile

from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr

cdef extern from "SFML/Config.hpp" namespace "sf":
    ctypedef signed   char Int8
    ctypedef unsigned char Uint8
    ctypedef signed   short Int16
    ctypedef unsigned short Uint16
    ctypedef signed   int Int32
    ctypedef unsigned int Uint32
    #if defined(_MSC_VER)
    #    typedef signed   __int64 Int64;
    #    typedef unsigned __int64 Uint64;
    #else
    ctypedef signed   long long Int64
    ctypedef unsigned long long Uint64

cdef extern from "SFML/Audio/SoundSource.hpp" namespace "sf":
    ctypedef enum Status "sf::SoundSource::Status":
        Stopped "sf::SoundSource::Stopped"
        Paused "sf::SoundSource::Paused"
        Playing "sf::SoundSource::Playing"

cdef extern from "SFML/Audio/Music.hpp" namespace "sf":
    cdef cppclass Music:
        Music() except +
        cbool openFromFile(const cstr &)
        void play()
        Status getStatus()

cdef extern from "SFML/Audio/SoundBuffer.hpp" namespace "sf":
    cdef cppclass SoundBuffer:
        SoundBuffer() except +
        SoundBuffer(const SoundBuffer &) except +
        cbool loadFromFile(const cstr &)
        #bool loadFromSamples(const Int16*, Uint64, unsigned int, unsigned int)
        #const Int16* getSamples()
        #Uint64 getSampleCount()
        #unsigned int getSampleRate()
        #unsigned int getChannelCount()

cdef extern from "SFML/Audio/Sound.hpp" namespace "sf":
    cdef cppclass Sound:
        Sound() except +
        Sound(Sound &) except +
        Sound(const SoundBuffer &) except +
        void play()
        #void stop()
        void setBuffer(const SoundBuffer &)
        #void setLoop(bool)
        #bool getLoop()

# cdef SoundBuffer buf = SoundBuffer()
cdef Music music

if not music.openFromFile("Mann_short.wav".encode()):
    print("ERROR: could not load file")

music.play()

import time
while music.getStatus() == Playing:
    time.sleep(0.1)

# cdef Sound sound = Sound()
# sound.setBuffer(music)
# sound.play()
