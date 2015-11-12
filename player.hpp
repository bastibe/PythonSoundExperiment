#ifndef PYSOUND_PLAYER_HPP
#define PYSOUND_PLAYER_HPP

#include <SFML/Audio/SoundStream.hpp>
#include <SFML/System/Time.hpp>
#include "Python.h"
#include <iostream>

/*
  This file contains a subclass of sf::SoundStream that implements the
  `onGetData` callback such that it really calls a Python function.

  It is initialized with a Python object and a function pointer, which
  are meant to be a `SoundPlayer` instance, and the C function
  `__callback__` in sound.pyx. The C function is called with the
  `SoundPlayer` instance, and in turns calls the Python function
  `SoundPlayer._callback`.

  It also passes on the `Chunk` to the Python function so a Python
  program can fill it with audio data.

  `onSeek` is implemented but empty. It is not meant to be used in
  this context.
 */

//
typedef bool (*playerCallback)(PyObject *self, sf::SoundStream::Chunk &chunk);

class Player : public sf::SoundStream {
public:
    playerCallback m_callback = NULL;
    PyObject *m_self = NULL;

    Player(PyObject *self, playerCallback callback, unsigned int samplerate, unsigned int channelsize)
        : m_self(self), m_callback(callback) {
        this->initialize(channelsize, samplerate);
    };

    virtual ~Player() { m_callback = NULL; };

private:
    bool onGetData(sf::SoundStream::Chunk &chunk) {
        bool val = m_callback(this->m_self, chunk);
        return val;
    };

    void onSeek(sf::Time timeOffset) {};
};

#endif
