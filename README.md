# gophone
Tools for SIP powered by sipgo lib. 
For now not opensource but more to serve as demo for library.

[Download (Linux only for now) gophone](https://github.com/emiago/gophone/releases/latest/download/gophone)

CLI phone built for testing
Features:
- [x] Dial Answer Register
- [x] Media: rtp logging, rtp summary, audio
- [ ] Transfers, Different responses NoAnswer,Busy

C Dependecies for audio to run
```sh
apt install libportaudio2 # debian/ubuntu
dnf install portaudio # fedora
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
  LOG_LEVEL=string                      Log level for out messaging
  SIP_DEBUG=bool                        LOG SIP traffic. Used with LOG_LEVEL=debug
  RTP_DEBUG=bool                        LOG RTP traffic. Used with LOG_LEVEL=debug
  GOPHONE_MEDIA=<same as -media>        Sets default media in case of calls

Examples:
gophone answer -l 127.0.0.200:5060 
gophone dial sip:1234@127.0.0.200:5060
gophone dial -sipheader="X-AccountId:test123" sip:1234@server:5060
gophone register -username=sipgo -password=1234 127.0.0.1:5060 
digest authentication:
gophone dial -ua alice -username=alice1234 -password=1234 "sip:echo@server:5060"
with media:
gophone dial -media=audio sip:1234@localhost:5060
gophone dial -media=mic sip:1234@localhost:5060
gophone answer -media=speaker
```
