FROM ubuntu:latest

# update system
RUN apt update
RUN apt upgrade -y
RUN apt install git -y

# install curl
RUN apt install curl -y

# install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# install rust-analyzer
RUN rustup component add rust-analyzer

# install building tools
run apt install build-essential -y

# install helix
RUN git clone https://github.com/helix-editor/helix
WORKDIR helix/
RUN cargo install --path helix-term --locked


# Configure Helix
WORKDIR /root/.config/
RUN git clone https://github.com/LukeOchoa/helix_themes && git clone https://github.com/LukeOchoa/helix_config

RUN mkdir helix/
RUN mv helix_config/* helix/.
RUN mv /helix/runtime/ helix/.
RUN mv helix_themes/* helix/runtime/themes/.
RUN cp -r helix/runtime/ /root/.cargo/bin/.
RUN rustup component add rust-analyzer
