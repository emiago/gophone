# sipgo-tools
Tools for SIP

## gophone
CLI phone built for testing
Features:
- [x] Dial Answer Register
- [x] Media: rtp logging, rtp summary, audio
- [ ] Transfers, Different responses NoAnswer,Busy
```
$>gophone -h
Usage of gophone command:

Commands:
  register      Send register request
  dial          Dial destination
  answer        Answer call

  -l string
    	My listen ip
  -t string
    	Transport udp|tcp|tls|ws|wss (default "udp")
  -ua string
    	User agent of phone (default "sipgo")

Enviroment variables:
  LOG_LEVEL=string                      Log level for out messaging
  SIP_DEBUG=bool                        Log level for out messaging
  GOPHONE_MEDIA=<same as -media>        Sets default media in case of calls

Examples:
gophone -l 127.0.0.200:5060 answer
gophone dial sip:1234@127.0.0.200:5060
gophone register sip:sipgo:mypass@127.0.0.1:5060
with media:
gophone dial -media=audio sip:1234@localhost:5060
gophone dial -media=mic sip:1234@localhost:5060
gophone answer -media=speaker
```
## psip
CLI inbound proxy and registrar.
Features:
- [x] Inbound proxy
- [x] Dialog routing
- [ ] Multiple inbound targets and loadbalancing within proxy
- [ ] Inbound/Outbound proxy
