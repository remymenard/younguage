document.addEventListener('DOMContentLoaded', () => {

  const jsQR = require('jsqr');
  const Peer = require('simple-peer');
  const io = require('socket.io-client');
  const state = {
    subtitles: [],
    isConnected: false,
    isCamera: false,
    peerId: '',
    error: {
      show: false,
        message: ''
      },
    qr: {
        output: false,
        data: false
    },
    stream: false,
    video: false,
    log: [],
    socket: false,
    peer: false,
    peerConnected: false,
    searchText: '',
    controls: [
      {
        action: 'play_video',
            icon: 'play_arrow'
          },
        {
          action: 'pause_video',
            icon: 'pause'
        },
        {
            action: 'replay_video',
            icon: 'replay_10'
          },
        {
            action: 'forward_video',
            icon: 'forward_10'
        },
        {
          action: 'next_episode',
          icon: 'fast_forward'
        }
    ]
  };


const app = new Vue({
  el: '#app',
    data() {
      return state;
    },
    mounted() {
      console.log('mounted')
        const peer = new Peer({ initiator: false, trickle: false });
        const socket = io('https://agile-island-59573.herokuapp.com/', {transports:['websocket']});
        this.socket = socket;
        this.peer = peer;
        socket.on('incoming-signal', (data) => {
          console.log('connected')
          peer.signal(data);
        });
          socket.on('signal', (data) => {
          console.log('connected')
            socket.emit('set-answer', { signal: data, id: this.peerId });
          });
          socket.on('connect', () => {
            console.log('connected')
            this.peerConnected = true;
          });
        socket.on('data', (data) => {
          console.log('connected')
            this.handleIncoming(data.toString());
          });
          socket.on('error', (e) => {
            this.peerConnected = false;
            this.showError(e.message);
          });
          socket.on('data', (data) => {
            const dataString = data.toString();
            if (dataString[0] === '{') {
              const data = JSON.parse(dataString);
              console.log(data)
              if(data.action === "subtitles") {
                this.updateSubtitles(data.payload)
              }
            }
          })
          socket.on('close', function(err) {
            this.peerConnected = false;
          });
        },
        methods: {
          updateSubtitles(data) {
            this.subtitles = [];
            console.log(data)
            data.forEach(element => {
              this.subtitles.push(`</br><div> ${element} </div>`)
            });
          },
          sendPeer(data) {
            console.log(data)
            this.peer.send(JSON.stringify(data));
          },
          showError(message) {
            this.error.show = true;
            this.error.message = message;
          },
          scanCode() {
            const video = this.$refs.video;
            navigator.mediaDevices
            .getUserMedia({ video: { facingMode: 'environment' } })
            .then((stream) => {
              this.stream = stream;
                    this.isCamera = true;
                    video.srcObject = stream;
                    video.setAttribute('playsinline', true);
                    video.play();
                    requestAnimationFrame(tick);
                  })
                  .catch((e) => {
                    this.showError(e.message);
                  });
                },
        connectRemote() {
          console.log('test')
          console.log(this.socket.emit('get-signal', this.peerId))
          this.socket.emit('get-signal', this.peerId);
        },
        searchNetflix() {
            this.sendPeer({
              action: 'search',
              payload: {
                text: this.searchText
              }
            });
          },
          videoAction(action) {
            this.sendPeer({
              action: 'video_action',
              payload: {
                action
              }
            });
          },
          handleIncoming(dataString) {
            const data = JSON.parse(dataString);
            if (Object.keys(data).includes('error')) {
              this.showError(data.error);
            }
            if (Object.keys(data).includes('success')) {
              this.error.show = false;
            }
          },
          refreshWindow() {
            window.location.reload();
          }
        }
      });

function tick() {
    try {
      const video = app.$refs.video;
        if (video.readyState === video.HAVE_ENOUGH_DATA) {
          const canvasElement = app.$refs.canvas;
            const canvas = canvasElement.getContext('2d');
            canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);
            const imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);
            const code = jsQR(imageData.data, imageData.width, imageData.height, {
              inversionAttempts: 'dontInvert'
            });
            if (code) {
                app.stream.getTracks().forEach((track) => track.stop());
                app.isCamera = false;
                app.qr.output = true;
                app.qr.data = code.data;
                app.peerId = code.data;
              } else {
                app.qr.output = false;
                app.qr.data = '';
              }
            }
            if (!app.qr.output) {
              requestAnimationFrame(tick);
            }
          } catch (e) {
            app.error.show = true;
            app.error.message = e.message;
          }
        }

      })
