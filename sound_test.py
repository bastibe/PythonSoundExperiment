import time
from soundfile import SoundFile
from sound import SoundCards

s1 = SoundCards()
with SoundFile("Mann_short.wav") as f:
    s1.play(f.read(), f.channels, f.samplerate, blocking=False)
    time.sleep(0.1)
s2 = SoundCards()
with SoundFile("Mann_short.wav") as f:
    s2.play(f.read(), f.channels, f.samplerate)
