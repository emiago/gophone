# gophone

is CLI SIP phone powered by [sipgo](https://github.com/emiago/sipgo) for more friendly call testing.
It provides also **json** type output for more easier filtering if you are running in cron based script.

This tool is not opensource for now but it is free and more to serve demo for library.


CLI phone built for testing
Features:
- [x] Dial Answer Register
- [x] Media: rtp logging, rtp summary, audio
- [x] Different responses NoAnswer,Busy
- [x] Offline Speech To text Transcription for output. Check [Speech To Text](#speech-to-text) for more
- [ ] Offline Speech To text Transcription for input 
- [ ] Transfers


# Quick start

Automatically install gophone and deps on your linux maching (amd64)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/emiago/gophone/main/install.sh)"
```

## Usage 

```
$>gophone -h
Usage of gophone command:

Commands:
  register      Send register request
  dial          Dial destination
  answer        Answer call

  -t string
    	Transport udp|tcp|tls|ws|wss (default "udp")

Enviroment variables:
  LOG_LEVEL=debug|info|error            Log level for output. Default=info
  LOG_FORMAT=json|console               Log format for output. Default=console
  LOG_NOCOLOR                           Disable color
  SIP_DEBUG                             LOG SIP traffic. Used with LOG_LEVEL=debug
  RTP_DEBUG                             LOG RTP traffic. Used with LOG_LEVEL=debug
  GOPHONE_MEDIA=<same as -media>        Sets default media in case of calls

Examples:
gophone answer -l 127.0.0.200:5060 
gophone answer -l 127.0.0.200:5060 -code 486 -reason Busy
gophone dial sip:1234@127.0.0.200:5060
gophone dial -sipheader="X-AccountId:test123" sip:1234@server:5060
gophone register -username=sipgo -password=1234 127.0.0.1:5060 

with digest authentication:
gophone dial -ua alice -username=alice1234 -password=1234 "sip:echo@server:5060"

with media:
gophone dial -media=audio sip:1234@localhost:5060
gophone dial -media=mic sip:1234@localhost:5060
gophone answer -media=speaker

with transcribe:
gophone dial -media=log -transcribe sip:1234@localhost:5060
```

## Speech to text:

It is using [whisper models](https://openai.com/research/whisper) for transcribing audio offline and end of call. 

With rtp stats and transcription it helps to check audio output without even having speaker on. 

Example call on asterisk.
```bash
$>gophone dial -media=log -transcribe sip:thanks@127.0.0.1:5060
...
19:05:50.948 INF Transcriber > wait, transcribing speech... len=88236
19:05:52.186 INF Transcriber > text="Goodbye. Thank you for trying out the asterisk open source PBX."
```

# Install manually

C Dependecies for audio to run
```sh
apt install libportaudio2 # debian/ubuntu
dnf install portaudio # fedora
```

**Speech to text compile:**

```bash
git clone https://github.com/ggerganov/whisper.cpp
cd whisper.cpp && make libwhisper.so 
cp libwhisper.so /usr/local/lib && cp whisper.h gglm.h /usr/local/include
```



**Gophone install:**

[Download (Linux only for now) gophone](https://github.com/emiago/gophone/releases/latest/download/gophone)
or run this
```bash
wget https://github.com/emiago/gophone/releases/latest/download/gophone && mv gophone ~/.local/bin
```
