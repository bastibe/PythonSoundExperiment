from libcpp cimport bool as cbool
from libcpp.string cimport string as cstr

cdef extern from "SFML/Config.hpp" namespace "sf":
    ctypedef signed   char Int8
    ctypedef unsigned char Uint8
    ctypedef signed   short Int16
    ctypedef unsigned short Uint16
    # if os.name == 'nt':
    #     ctypedef signed   __int64 Int64;
    #     ctypedef unsigned __int64 Uint64;
    # else:
    ctypedef signed   int Int32
    ctypedef unsigned int Uint32
    ctypedef signed   long long Int64
    ctypedef unsigned long long Uint64


cdef extern from "player.hpp":
    ctypedef cbool (*playerCallback)(object, Chunk &)
    cdef struct Chunk "sf::SoundStream::Chunk":
        Int16 *samples
        size_t sampleCount
    cdef cppclass Player:
        Player(object, playerCallback, unsigned int, unsigned int)
        void play()
        void pause()
        void stop()
        unsigned int getChannelCount()
        unsigned int getSampleRate()
        Status getStatus()
        cbool onGetData(Chunk &)

cdef extern from "SFML/Audio/SoundSource.hpp" namespace "sf":
    ctypedef enum Status "sf::SoundSource::Status":
        Stopped "sf::SoundSource::Stopped"
        Paused "sf::SoundSource::Paused"
        Playing "sf::SoundSource::Playing"
