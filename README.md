# Minimalistic weechat in a docker

# Getting started

```bash
cat ~/.ssh/id_rsa.pub > authorized_keys
docker build -t weechat .
docker run --rm=true -p 2222:22 --name=weechat weechat

# first connection
ssh -p 2222 irc@localhost tmux new weechat

# or just attach to already running tmux
ssh -p 2222 irc@localhost tmux attach
```
