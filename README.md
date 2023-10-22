# sipgo-tools
Tools for SIP powered by sipgo lib. 
For now not opensource but more to serve as demo for library.

Download (Linux only for now):
-  [gophone](https://github.com/emiago/sipgo-tools/releases/latest/download/gophone)
-  [psip](https://github.com/emiago/sipgo-tools/releases/latest/download/psip)

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
gophone dial -sip-header="X-AccountId:test123" sip:1234@server:5060
gophone register sip:sipgo:mypass@127.0.0.1:5060
digest authentication:
gophone -ua alice dial -username=alice1234 -password=1234 "sip:echo@server:5060"
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

```
$>psip -h
Usage: psip [FLAGS]

  -http string
    	Listen HTTP address. env 'PSIP_HTTP_METRICS' (default ":8080")
  -in string
    	Inbound proxy destination. env 'PSIP_INBOUND_TARGET'
  -ip string
    	External IP to use. env 'PSIP_EXTERNAL_ADDR'
  -pprof
    	Full profile
  -tcp string
    	Listen TCP address. env 'PSIP_LISTEN_TCP' (default "127.0.0.1:5060")
  -udp string
    	Listen UDP address. env 'PSIP_LISTEN_UDP' (default "127.0.0.1:5060")

Debuging:
  LOG_LEVEL=string                      Log level for out messaging
  SIP_DEBUG=bool                        SIP trace on debug level

Examples:
psip -in 127.0.0.200:5060 -udp 127.0.0.1:5066 -tcp 127.0.0.1:5066
```
